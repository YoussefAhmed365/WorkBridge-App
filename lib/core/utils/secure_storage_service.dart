import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  static const String _tokenKey = 'auth_token';
  static const String _userRoleKey = 'user_role';

  // Save Token
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // Get Token
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // Save User Role (JOB_SEEKER, EMPLOYER, SERVICE_REQUESTER)
  Future<void> saveUserRole(String role) async {
    await _storage.write(key: _userRoleKey, value: role);
  }

  // Get User Role
  Future<String?> getUserRole() async {
    return await _storage.read(key: _userRoleKey);
  }

  // Clear Session Data
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}