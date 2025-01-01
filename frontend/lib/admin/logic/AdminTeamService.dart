import 'package:db_finalproject/core/services/ApiService.dart';
import 'package:db_finalproject/data/Team.dart';
import 'package:db_finalproject/data/Student.dart';
import 'package:db_finalproject/data/Teacher.dart';
import 'dart:convert';

class AdminTeamService {
  final ApiService _apiService = ApiService();

  //拿所有隊伍的基本資料，隊伍id、名稱、作品說明書、切結書、同意書、隊伍狀態
  Future<List<Team>> getBasicAllTeam() async{
    final response = await _apiService.get('/Team/Cond');
    return (jsonDecode(response.body) as List).map((json) => Team.fromJson(json)).toList();
  }

  //拿所有隊伍的基本資料，但有限制，限制年份、組別、隊伍狀態。
  Future<List<Team>> getBasicAllTeamWithConstraint(Map<String, dynamic> constraint) async{
    final response = await _apiService.post('/Team/Cond', constraint);
    return (jsonDecode(response.body) as List).map((json) => Team.fromJson(json)).toList();
  }

  //拿隊伍的所有資料
  Future<Team> getDetailTeam(String teamid) async{
    final response = await _apiService.get('/Team/Cond/$teamid');
    return Team.fromJson(response);
  }

  //拿隊伍隊員的所有資料
  Future<List<Student>> getTeamStudent(String teamid) async{
    final response = await _apiService.get('/Stu/$teamid');
    return (jsonDecode(response.body) as List).map((json)=>Student.fromJson(json)).toList();
  }

  //拿隊伍指導老師的資料
  Future<Teacher> getTeamTeacher(String teacheremail) async{
    final response = await _apiService.get('/Tr/$teacheremail');
    return Teacher.fromJson(response);
  }

  //獲取檔案，下載檔案
  Future<dynamic> getFile(String fileurl) async{
    final response = await _apiService.downloadFile(fileurl);
    return response;
  }

  //修改隊伍狀態
  Future<dynamic> editTeamState(String teamid,String state) async{
    final response = await _apiService.post('/Team/$teamid/edit', {'state':state});
  }
}