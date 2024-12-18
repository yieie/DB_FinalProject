import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // static const String baseUrl = 'http://localhost:8080/api';
  static const String baseUrl = 'http://localhost:8081/api';


  Future<dynamic> get(String endpoint) async{
    final response= await http.get(Uri.parse('$baseUrl$endpoint'));
    _handleErrors(response);
    return jsonDecode(response.body);
  }

  Future<dynamic> post(String endpoint,Map<String,dynamic> body) async{
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type':'application/json'},
      body: jsonEncode(body)
    );

    _handleErrors(response);
    return jsonDecode(response.body);
  }

  void _handleErrors(http.Response response){
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('HTTP Error: ${response.statusCode}');
    }
  }
}