import 'package:db_finalproject/core/services/ApiService.dart';
import 'package:db_finalproject/data/Score.dart';
import 'package:db_finalproject/data/Team.dart';
import 'package:db_finalproject/data/Student.dart';
import 'package:db_finalproject/data/Teacher.dart';

class AdminTeamService {
  final ApiService _apiService = ApiService();

  //拿所有隊伍的基本資料，隊伍id、名稱、作品說明書、切結書、同意書、隊伍狀態
  //回傳資料請以隊伍狀態排序，依序為報名待審核、已補件、待審核初賽資格、需補件、已審核、初賽隊伍、決賽隊伍
  Future<List<Team>> getBasicAllTeam() async{
    final response = await _apiService.get('/Teams/Cond');
    return (response as List).map((json) => Team.fromJson(json)).toList();
  }

  //拿所有隊伍的基本資料，但有限制，限制年份、組別(全組別，創意發想組，創業實作組)、隊伍狀態。
  //若無限制隊伍狀態，請同getBasicAllteam()排序
  //若無限制組別，請將同組別資料都一群先輸出，如創意發想組先，接創業實作組，或相反也可。
  Future<List<Team>> getBasicAllTeamWithConstraint(Map<String, dynamic> constraint) async{
    final response = await _apiService.post('/Teams/Cond/Constraint', constraint);
    return (response as List).map((json) => Team.fromJson(json)).toList();
  }

  //拿隊伍的所有資料
  Future<Team> getDetailTeam(String teamid) async{
    final response = await _apiService.get('/Teams/$teamid');
    return Team.fromJson(response);
  }

  //拿隊伍隊員的所有資料
  //回傳資料請將代表人(leader)放在首位
  Future<List<Student>> getTeamStudent(String teamid) async{
    final response = await _apiService.get('/Stu/$teamid');
    return (response as List).map((json)=>Student.fromJson(json)).toList();
  }

  //拿隊伍指導老師的資料
  Future<Teacher> getTeamTeacher(String teacheremail) async{
    final response = await _apiService.get('/Tr/$teacheremail');
    return Teacher.fromJson(response);
  }

  // 還沒寫
  //獲取檔案，下載檔案
  Future<dynamic> getFile(String fileurl) async{
    final response = await _apiService.downloadFile(fileurl);
    return response;
  }

  //修改隊伍狀態
  Future<dynamic> editTeamState(String teamid,String state) async{
    final response = await _apiService.post('/Teams/$teamid/edit', {'state':state});
  }

  //拿所有評分資料，會限制年份、組別(全組別、創意發想組、創業實作組)
  //如果rank不為空，回傳資料以rank排序
  //評分資料與資料庫內結構不同，要去Score.dart看實際需要回傳什麼
  Future<List<Score>> getScoresWithConstraints(Map<String,dynamic> constraint) async{
    final response = await _apiService.post('/Score/Constraints',constraint);
    return (response as List).map((json)=>Score.fromJson(json)).toList();
  }
}