import 'dart:convert';
import 'package:http/http.dart' as http;
import 'DataStruct.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api';

  static Future<String?> login(String username, String password) async {
    final uri = Uri.parse('$baseUrl/auth/login');
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

  //拿取Announcement資料，使用get查詢，目前只拿取date、title、info
  //AnnStruct結構可參照DataStruct.dart
  Future<List<AnnStruct>> getAnn() async {
    final uri = Uri.parse('$baseUrl/Ann/list');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null) {
          // 將 JSON 轉換為 AnnStruct 列表
          return (data as List).map((json) => AnnStruct.fromJson(json)).toList();
        } else {
          throw Exception('Response data is null');
        }
      } else {
        print("Error: ${response.statusCode} ${response.body}");
        throw Exception('Failed to get Announcement');
      }
    } catch (e) {
      print("Request failed: $e");
      throw Exception('Error fetching Announcements');
    }
  }
}
