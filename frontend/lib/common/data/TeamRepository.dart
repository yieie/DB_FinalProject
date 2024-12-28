import 'dart:convert';

import 'package:db_finalproject/data/Team.dart';
import 'package:db_finalproject/core/services/ApiService.dart';

class TeamRepository {
  final ApiService _apiService = ApiService();

  Future<List<Team>> fetchBasicAllTeam() async{
    final response = await _apiService.get('Team/Cond');
    return (jsonDecode(response.body) as List).map((json) => Team.fromBasicJson(json)).toList();
  } 
}