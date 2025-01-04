import 'dart:io';

import 'package:db_finalproject/core/services/ApiService.dart';
import 'package:db_finalproject/data/Student.dart';
import 'package:db_finalproject/data/Teacher.dart';
import 'package:db_finalproject/data/Team.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';

class StuTeamService {
  final ApiService _apiService = ApiService();

  //拿學生的teamid，如果沒有回傳'無'
  Future<String> getStudentTeamId(String stuid) async{
    final response = await _apiService.get('/Stu/$stuid/teamid');
    return response;
  }

  //報名參賽
  //傳到後端的順序 指導老師->隊伍->作品->學生->學生證 這樣外來鍵參照才不會出錯
  Future<void> postJoinContest(
    Map<String, dynamic>? tr,
    Map<String, dynamic> team,
    Map<String, dynamic> work,
    List<Map<String, dynamic>> stus,
    List<PlatformFile> idcard
  ) async{

    if(tr != null){
      await _apiService.post('/Tr/add', tr);
    }

    await _apiService.post('/Team/add', team);
    await _apiService.post('/Work/add', work);
    await _apiService.post('/Stu/add', { 'students':stus });

    //把stus裡每個學生id依序抓出來就是學生證順序
    /*
     *idcard_order形式
     * {
     * '0': 學號,
     * '1': 學號,
     * ...
     * 'n': 學號
     * }
     * 
     */
    Map<String,dynamic> idcard_order={};
    for(int i=0;i<stus.length;i++){
      idcard_order.addAll({'$i': stus[i]['stuid']});
    }
    await _apiService.uploadFile('/Stu/add/idcard', Imgs: idcard, additionalData: idcard_order);
  }
}