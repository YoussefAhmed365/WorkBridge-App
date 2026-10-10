import 'package:dio/dio.dart';
import 'package:workbridge/core/constants/api_constants.dart';
import 'package:workbridge/core/errors/exceptions.dart';
import 'package:workbridge/core/utils/secure_storage_service.dart';

class DioClient {
  final Dio _dio;
  final SecureStorageService _secureStorageService;

  DioClient(this._dio, this._secureStorageService) {
    _dio
      ..options.baseUrl = ApiConstants.baseUrl
      ..options.connectTimeout = ApiConstants.connectionTimeout
      ..options.receiveTimeout = ApiConstants.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json', 'Accept': 'application/json'};

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _secureStorageService.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) {
          if (error.response?.statusCode == 401) {
            return handler.reject(DioException(requestOptions: error.requestOptions, error: UnauthorizedException()));
          }
          return handler.next(error);
        },
      ),
    );
  }

  // HTTP Helper Methods
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters, options: options);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await _dio.post(path, data: data, queryParameters: queryParameters, options: options);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await _dio.put(path, data: data, queryParameters: queryParameters, options: options);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await _dio.delete(path, data: data, queryParameters: queryParameters, options: options);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException error) {
    if (error.error is UnauthorizedException) {
      return error.error as UnauthorizedException;
    }
    final message = error.response?.data?['message'] ?? error.message ?? 'Something went wrong';
    final statusCode = error.response?.statusCode;
    return ServerException(message: message.toString(), statusCode: statusCode);
  }
}
