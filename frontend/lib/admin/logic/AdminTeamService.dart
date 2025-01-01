import 'package:db_finalproject/core/services/ApiService.dart';
import 'package:db_finalproject/data/Team.dart';
import 'dart:convert';

class AdminTeamService {
  final ApiService _apiService = ApiService();

  Future<List<Team>> getBasicAllTeam() async{
    final response = await _apiService.get('Team/Cond');
    return (jsonDecode(response.body) as List).map((json) => Team.fromBasicJson(json)).toList();
  }
}