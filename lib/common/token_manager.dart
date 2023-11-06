import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Save token to secure storage
  Future<void> saveToken(String tokenKey, String token) async {
    await _secureStorage.write(key: tokenKey, value: token);
  }

  // Get token from secure storage
  Future<String?> getToken(String tokenKey) async {
    return await _secureStorage.read(key: tokenKey);
  }

  // Delete token from secure storage
  Future<void> deleteToken(String tokenKey) async {
    await _secureStorage.delete(key: tokenKey);
  }

  // Check if token exists
  Future<bool> hasToken(String tokenKey) async {
    String? token = await getToken(tokenKey);
    return token != null;
  }
}
