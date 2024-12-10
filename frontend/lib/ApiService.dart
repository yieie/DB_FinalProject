import 'package:dio/dio.dart';
import 'DataStruct.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8081/api')); // 改為 HTTP
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

  //拿取Announcement資料，使用get查詢，目前只拿取date、title、info
  //AnnStruct結構可參照DataStruct.dart
  Future<List<AnnStruct>> getAnn() async{
    final response = await _dio.get('/Ann/list');
    await Future.delayed(Duration(seconds: 1));
    if(response.statusCode == 200){
      final data = response.data;
      if (data != null) {
        return (data as List).map((json) => AnnStruct.fromJson(json)).toList();
      } else {
        throw Exception('Response data is null');
      }
    }
    else{
      throw Exception('Failed to get Announcement');
    }

  }
}
