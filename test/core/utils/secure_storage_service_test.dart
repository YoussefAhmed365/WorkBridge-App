import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:workbridge/core/utils/secure_storage_service.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late SecureStorageService secureStorageService;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    secureStorageService = SecureStorageService(mockStorage);
  });

  group('SecureStorageService', () {
    const tokenKey = 'auth_token';
    const userRoleKey = 'user_role';

    test('saveToken writes token to secure storage', () async {
      when(() => mockStorage.write(key: tokenKey, value: 'test_token'))
          .thenAnswer((_) async => {});

      await secureStorageService.saveToken('test_token');

      verify(() => mockStorage.write(key: tokenKey, value: 'test_token')).called(1);
    });

    test('getToken retrieves token from secure storage', () async {
      when(() => mockStorage.read(key: tokenKey))
          .thenAnswer((_) async => 'test_token');

      final token = await secureStorageService.getToken();

      expect(token, equals('test_token'));
      verify(() => mockStorage.read(key: tokenKey)).called(1);
    });

    test('saveUserRole writes user role to secure storage', () async {
      when(() => mockStorage.write(key: userRoleKey, value: 'JOB_SEEKER'))
          .thenAnswer((_) async => {});

      await secureStorageService.saveUserRole('JOB_SEEKER');

      verify(() => mockStorage.write(key: userRoleKey, value: 'JOB_SEEKER')).called(1);
    });

    test('getUserRole retrieves user role from secure storage', () async {
      when(() => mockStorage.read(key: userRoleKey))
          .thenAnswer((_) async => 'JOB_SEEKER');

      final role = await secureStorageService.getUserRole();

      expect(role, equals('JOB_SEEKER'));
      verify(() => mockStorage.read(key: userRoleKey)).called(1);
    });

    test('clearAll deletes all data from secure storage', () async {
      when(() => mockStorage.deleteAll())
          .thenAnswer((_) async => {});

      await secureStorageService.clearAll();

      verify(() => mockStorage.deleteAll()).called(1);
    });
  });
}
