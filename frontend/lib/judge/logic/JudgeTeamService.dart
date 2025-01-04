import 'package:db_finalproject/core/services/ApiService.dart';
import 'package:db_finalproject/data/Team.dart';

class JudgeTeamService {
  final ApiService _apiService = ApiService();

  //拿隊伍資訊，只需要隊伍ID、名稱、狀態、組別、作品名稱
  //只需要拿隊伍狀態為初賽隊伍 or 決賽隊伍
  //路徑可以自己改一下，不太知道要怎麼命名
  Future<List<Team>> getBasicAllTeamInContest() async{
    final response = await _apiService.get('/Teams/incontest');
    return (response as List).map((json) => Team.fromJson(json)).toList();
  }
}