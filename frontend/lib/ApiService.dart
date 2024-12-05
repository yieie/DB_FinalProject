import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8080/api')); // 改為 HTTP
  //傳帳號密碼給後端伺服器，伺服器回傳token
  Future<String?> login(String username, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });
      return response.data['token']; // 返回 JWT Token
    } catch (e) {
      print('登入失敗: $e');
      if (e is DioException) {
        print('DioError: ${e.message}');
        print('Response Data: ${e.response?.data}');
        print('Response Status Code: ${e.response?.statusCode}');
      }
      return null;
    }
  }
}