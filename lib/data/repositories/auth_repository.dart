import 'package:fake_store/core/constants/api_endpoints.dart';
import 'package:fake_store/data/datasources/api_service.dart';
import 'package:fake_store/data/models/auth_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final ApiService _apiService;
  final FlutterSecureStorage _storage;

  AuthRepository(this._apiService, this._storage);

  Future<bool> login(String username, String password) async {
    try {
      final response = await _apiService.post(
        ApiEndpoints.login,
        data: LoginRequest(username: username, password: password).toJson(),
      );

      final token = LoginResponse.fromJson(response.data).token;
      await _storage.write(key: 'auth_token', value: token);
      return true;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'auth_token');
    return token != null;
  }
}
