import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api/auth';

  static Future<String?> login(String username, String password) async {
    final uri = Uri.parse('$baseUrl/login');
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json', //Content-Type是JSON
        },
        body: jsonEncode({ //body JSON格式
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print("Error: ${response.statusCode} ${response.body}");
        return null; // 登入失敗
      }
    } catch (e) {
      print("Request failed: $e");
      return null; // 處理例外
    }
  }
}
