import 'dart:convert';
import 'package:db_finalproject/features/admin/data/TeamsStatus.dart';
import 'package:db_finalproject/core/services/ApiService.dart';

class TeamsStatusRepository {
  final ApiService _apiService = ApiService();

  Future<TeamsStatus> fetchTeamsStatus() async{
    final response = await _apiService.get('/Teams/Status');
    return TeamsStatus.fromJson(response);
  }
}