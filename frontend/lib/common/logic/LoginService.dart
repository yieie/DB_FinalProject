import 'package:db_finalproject/core/services/ApiService.dart';

class LoginService {
  final ApiService _apiService = ApiService();
  Future<String?> login(String usertype, String username, String userpasswd) async{
    final response = await _apiService.post('/auth/login',
        { 
          'usertype': usertype,
          'username': username, 
          'password': userpasswd,
        });
    return response.body;
  }
}