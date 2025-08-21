import 'package:fake_store/core/constants/api_endpoints.dart';
import 'package:fake_store/data/datasources/api_service.dart';
import 'package:fake_store/data/models/user_model.dart';

class UserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  Future<UserModel> getUser(int userId) async {
    final response = await _apiService.get(ApiEndpoints.userProfile(userId));
    return UserModel.fromJson(response.data);
  }
}
