import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'DataStruct.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api';

  /*
   * 登入及註冊區域
   * 
   */

  static Future<String?> login(String usertype,String username, String password) async {
    final uri = Uri.parse('$baseUrl/auth/login');
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json', //Content-Type是JSON
        },
        body: jsonEncode({ //body JSON格式
          // 'usertype': usertype,
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

  static Future<String?> register(StuStruct stu) async {
    final uri = Uri.parse('$baseUrl/auth/register');
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json', //Content-Type是JSON
        },
        body:  jsonEncode({ //body JSON格式
          'id': stu.id,
          'passwd': stu.passwd,
          'name': stu.name,
          'mail': stu.email,
          'sexual': stu.sexual,
          'phone': stu.phone,
          'major': stu.major,
          'grade': stu.grade
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

  /*
   * 公告事項區域
   * 
   */

  Future<List<AnnStruct>> getAnnBasic() async {
    final uri = Uri.parse('$baseUrl/Ann/list');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null) {
          // 將 JSON 轉換為 AnnStruct 列表
          print("Decoded JSON: $data");
          return (data as List).map((json) => AnnStruct.fromBasicJson(json)).toList();
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

  Future<AnnStruct> getAnnDetail(int id) async{
    final url = Uri.parse('$baseUrl/Ann/details/$id');
    try{
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null) {
          // 將 JSON 轉換為 AnnStruct 列表
          // final List<dynamic> data = json.decode(response.body);
          return AnnStruct.fromDetailJson(data);
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

  /*
   * 系統管理員操作區域
   * 
   */

  Future<TeamsStatus> getTeamsStatus() async{
    final url = Uri.parse('$baseUrl/Teams/Status');
    try{
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null) {
          // 將 JSON 轉換為 AnnStruct 列表
          // final List<dynamic> data = json.decode(response.body);
          return TeamsStatus.fromJson(data);
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

  Future<List<TeamStruct>> getBasicAllTeam() async{
     final url = Uri.parse('$baseUrl/Teams/Cond');
    try{
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null) {
          return (data as List).map((json) => TeamStruct.fromBasicJson(json)).toList();
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