import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api';
  // static const String baseUrl = 'http://localhost:8081/api';


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

  Future<dynamic> put(String endpoint,Map<String,dynamic> body) async{
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type':'application/json'},
      body: jsonEncode(body)
    );

    _handleErrors(response);
    return true;
  }

  Future<dynamic> uploadFile(
    String endpoint, {
    List<PlatformFile>? files,
    List<PlatformFile>? Imgs,
    Map<String, dynamic>? additionalData,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final request = http.MultipartRequest('POST', uri);
    if(files != null){
      for (var file in files) {
        print(request.fields);
        request.files.add(
          await http.MultipartFile.fromBytes(
            'files', // 對應後端的字段名
            file.bytes!,
            filename: file.name
          ),
        );
      }
    }

    if(Imgs != null){
      for (var Img in Imgs) {
        request.files.add(
          await http.MultipartFile.fromBytes(
            'Images', // 對應後端的字段名
            Img.bytes!,
            filename: Img.name
          ),
        );
      }
    }

    if (additionalData != null) {
      request.fields.addAll(additionalData.map((key, value) => MapEntry(key, value.toString())));
      print(request.fields);
    }

    print("請求 URL: ${request.url}");
    print("附加數據 (fields): ${request.fields}");

    print("文件列表 (files):");
    for (var file in request.files) {
      print("  - 字段名: ${file.field}");
      print("    文件名: ${file.filename}");
      print("    長度: ${file.length}");
    }

    final response = await request.send();

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseBody = await response.stream.bytesToString();
      return jsonDecode(responseBody);
    } else {
      throw Exception('HTTP Error: ${response.statusCode}');
    }
  }

  void _handleErrors(http.Response response){
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('HTTP Error: ${response.statusCode}');
    }
  }
}