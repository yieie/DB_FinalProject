import 'package:db_finalproject/core/services/ApiService.dart';
import 'package:db_finalproject/data/Team.dart';

class TeamService {
  final ApiService _apiService = ApiService();
  //爬所有隊伍資料，只要隊伍ID、名稱、類別、排名、作品名稱、yt、githuburl
  Future<List<Team>> getBasicAllTeamWithConstraint(String year) async{
    final response = await _apiService.get('/Teams/Cond/$year');
    return (response as List).map((json) => Team.fromJson(json)).toList();
  }
}