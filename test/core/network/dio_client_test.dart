import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:workbridge/core/constants/api_constants.dart';
import 'package:workbridge/core/errors/exceptions.dart';
import 'package:workbridge/core/network/dio_client.dart';
import 'package:workbridge/core/utils/secure_storage_service.dart';

class MockDio extends Mock implements Dio {}
class MockSecureStorageService extends Mock implements SecureStorageService {}
class MockErrorInterceptorHandler extends Mock implements ErrorInterceptorHandler {}
class FakeDioException extends Fake implements DioException {}

void main() {
  late MockDio mockDio;
  late MockSecureStorageService mockSecureStorageService;
  late BaseOptions dioOptions;
  late Interceptors interceptors;

  setUpAll(() {
    registerFallbackValue(FakeDioException());
  });

  setUp(() {
    mockDio = MockDio();
    mockSecureStorageService = MockSecureStorageService();
    dioOptions = BaseOptions();
    interceptors = Interceptors();

    when(() => mockDio.options).thenReturn(dioOptions);
    when(() => mockDio.interceptors).thenReturn(interceptors);
  });

  group('DioClient Configuration & Interceptor', () {
    test('initializes Dio options correctly and adds interceptor', () {
      DioClient(mockDio, mockSecureStorageService);

      expect(dioOptions.baseUrl, equals(ApiConstants.baseUrl));
      expect(dioOptions.connectTimeout, equals(ApiConstants.connectionTimeout));
      expect(dioOptions.receiveTimeout, equals(ApiConstants.receiveTimeout));
      expect(dioOptions.headers['Content-Type'], equals('application/json'));
      expect(dioOptions.headers['Accept'], equals('application/json'));
      expect(interceptors.whereType<InterceptorsWrapper>().length, equals(1));
    });

    test('interceptor adds Authorization header when token is present', () async {
      when(() => mockSecureStorageService.getToken()).thenAnswer((_) async => 'valid_token');

      DioClient(mockDio, mockSecureStorageService);
      final interceptor = interceptors.whereType<InterceptorsWrapper>().first;

      final requestOptions = RequestOptions(path: '/test');
      final handler = RequestInterceptorHandler();

      interceptor.onRequest(requestOptions, handler);
      await Future.delayed(Duration.zero);

      expect(requestOptions.headers['Authorization'], equals('Bearer valid_token'));
    });

    test('interceptor omits Authorization header when token is null or empty', () async {
      when(() => mockSecureStorageService.getToken()).thenAnswer((_) async => null);

      DioClient(mockDio, mockSecureStorageService);
      final interceptor = interceptors.whereType<InterceptorsWrapper>().first;

      final requestOptions = RequestOptions(path: '/test');
      final handler = RequestInterceptorHandler();

      interceptor.onRequest(requestOptions, handler);
      await Future.delayed(Duration.zero);

      expect(requestOptions.headers.containsKey('Authorization'), isFalse);
    });

    test('interceptor converts 401 error response to UnauthorizedException', () {
      DioClient(mockDio, mockSecureStorageService);
      final interceptor = interceptors.whereType<InterceptorsWrapper>().first;

      final requestOptions = RequestOptions(path: '/test');
      final error = DioException(
        requestOptions: requestOptions,
        response: Response(requestOptions: requestOptions, statusCode: 401),
      );
      final mockHandler = MockErrorInterceptorHandler();

      interceptor.onError(error, mockHandler);

      final verification = verify(() => mockHandler.reject(captureAny()));
      verification.called(1);
      final capturedException = verification.captured.first as DioException;
      expect(capturedException.error, isA<UnauthorizedException>());
    });
  });

  group('DioClient HTTP Methods', () {
    late DioClient dioClient;

    setUp(() {
      dioClient = DioClient(mockDio, mockSecureStorageService);
    });

    test('get executes dio.get successfully', () async {
      final expectedResponse = Response(
        requestOptions: RequestOptions(path: '/test'),
        data: {'success': true},
        statusCode: 200,
      );

      when(() => mockDio.get('/test', queryParameters: any(named: 'queryParameters'), options: any(named: 'options')))
          .thenAnswer((_) async => expectedResponse);

      final result = await dioClient.get('/test');

      expect(result, equals(expectedResponse));
    });

    test('post executes dio.post successfully', () async {
      final expectedResponse = Response(
        requestOptions: RequestOptions(path: '/test'),
        data: {'id': 1},
        statusCode: 201,
      );

      when(() => mockDio.post('/test', data: any(named: 'data'), queryParameters: any(named: 'queryParameters'), options: any(named: 'options')))
          .thenAnswer((_) async => expectedResponse);

      final result = await dioClient.post('/test', data: {'name': 'test'});

      expect(result, equals(expectedResponse));
    });

    test('put executes dio.put successfully', () async {
      final expectedResponse = Response(
        requestOptions: RequestOptions(path: '/test'),
        data: {'updated': true},
        statusCode: 200,
      );

      when(() => mockDio.put('/test', data: any(named: 'data'), queryParameters: any(named: 'queryParameters'), options: any(named: 'options')))
          .thenAnswer((_) async => expectedResponse);

      final result = await dioClient.put('/test', data: {'name': 'test'});

      expect(result, equals(expectedResponse));
    });

    test('delete executes dio.delete successfully', () async {
      final expectedResponse = Response(
        requestOptions: RequestOptions(path: '/test'),
        data: null,
        statusCode: 204,
      );

      when(() => mockDio.delete('/test', data: any(named: 'data'), queryParameters: any(named: 'queryParameters'), options: any(named: 'options')))
          .thenAnswer((_) async => expectedResponse);

      final result = await dioClient.delete('/test');

      expect(result, equals(expectedResponse));
    });

    test('rethrows UnauthorizedException when error contains UnauthorizedException', () async {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        error: UnauthorizedException(),
      );

      when(() => mockDio.get('/test', queryParameters: any(named: 'queryParameters'), options: any(named: 'options')))
          .thenThrow(dioError);

      expect(() => dioClient.get('/test'), throwsA(isA<UnauthorizedException>()));
    });

    test('maps DioException with message & status code to ServerException', () async {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        message: 'Network Error',
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 500,
          data: {'message': 'Internal Server Error'},
        ),
      );

      when(() => mockDio.get('/test', queryParameters: any(named: 'queryParameters'), options: any(named: 'options')))
          .thenThrow(dioError);

      try {
        await dioClient.get('/test');
        fail('Should throw ServerException');
      } on ServerException catch (e) {
        expect(e.message, equals('Internal Server Error'));
        expect(e.statusCode, equals(500));
      }
    });

    test('maps DioException without response data to ServerException with fallback message', () async {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/test'),
        message: 'Connection timed out',
      );

      when(() => mockDio.get('/test', queryParameters: any(named: 'queryParameters'), options: any(named: 'options')))
          .thenThrow(dioError);

      try {
        await dioClient.get('/test');
        fail('Should throw ServerException');
      } on ServerException catch (e) {
        expect(e.message, equals('Connection timed out'));
        expect(e.statusCode, isNull);
      }
    });
  });
}
