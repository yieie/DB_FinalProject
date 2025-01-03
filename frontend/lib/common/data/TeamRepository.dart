import 'dart:convert';

import 'package:db_finalproject/data/Team.dart';
import 'package:db_finalproject/core/services/ApiService.dart';

class TeamRepository {
  final ApiService _apiService = ApiService();

  Future<List<Team>> fetchBasicAllTeam() async{
    final response = await _apiService.get('/Teams/Cond');
    // return (jsonDecode(response.body) as List).map((json) => Team.fromBasicJson(json)).toList();
    // 不用decode，因為ApiService已經decode過了
    return (response as List).map((json) => Team.fromJson(json)).toList();
  } 
}