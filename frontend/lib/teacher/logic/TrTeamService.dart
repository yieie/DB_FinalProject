import 'package:db_finalproject/core/services/ApiService.dart';
import 'package:db_finalproject/data/Team.dart';

class TrTeamSerive{
  final ApiService _apiService = ApiService();

  //拿老師的指導隊伍
  //只需要拿隊伍ID、名稱、狀態、組別、
  Future<List<Team>> getBasicAllTeamByTrIdNYear(String trid,String year) async{
    final response = await _apiService.get('/Teams/trTeam/$trid/$year');
    return (response as List).map((json) => Team.fromJson(json)).toList();
  }
}