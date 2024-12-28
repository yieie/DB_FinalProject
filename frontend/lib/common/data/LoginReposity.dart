import 'package:db_finalproject/core/services/ApiService.dart';

class LoginReposity {
  final ApiService _apiService = ApiService();
  Future<String?> login(String usertype, String username, String password) async {
    final response = await _apiService.post('/auth/login',
        { 
          // 'usertype': usertype,
          'username': username, 
          'password': password,
        });
    return response.body;
  }
}