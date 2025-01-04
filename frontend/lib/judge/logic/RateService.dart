import 'package:db_finalproject/data/Score.dart';
import 'package:db_finalproject/core/services/ApiService.dart';
import 'package:db_finalproject/data/Team.dart';

class RateService {
  final ApiService _apiService = ApiService();

  //拿創意發想組的所有隊伍
  //只需要隊伍ID、隊伍名稱、作品名稱、隊伍類型
  Future<List<Team>> getAllTeamIdea() async{
    final response = await _apiService.get('/Teams/idea');
    return (response as List).map((json)=>Team.fromJson(json)).toList();
  }

  //拿創業實作組的所有隊伍
  //只需要隊伍ID、隊伍名稱、作品名稱、隊伍類型
  Future<List<Team>> getAllTeamBusiness() async{
    final response = await _apiService.get('/Teams/business');
    return (response as List).map((json)=>Team.fromJson(json)).toList();
  }

  //新增評分，data內含分數1~4以及評分的judgeid
  /*data格式
   *{
   * 'judgeid':judgeid,
   * 'score1':scores[0],
   * 'score2':scores[1],
   * 'score3':scores[2],
   * 'score4':scores[3]
   *}
   */
  Future<void> addScore(Map<String,String> data,String teamid) async{
    await _apiService.post('/Score/$teamid', data);
  }

  //拿評審評的所有分數，要回傳分數1~4，總分，隊伍的id、名字、組別，評審的名字(不是id!!)，如果有排名要回傳排名
  //只需要回傳當年度的成績
  Future<List<Score>> getAllScorebyJudgeId(String judgeid) async{
    final response = await _apiService.get('/Score/$judgeid');
    return (response as List).map((json) => Score.fromJson(json)).toList();
  }
}