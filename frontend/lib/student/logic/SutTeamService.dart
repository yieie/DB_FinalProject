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

  //拿學生的workid，如果沒有回傳'無'
  Future<String> getStudentWorkId(String stuid) async{
    final response = await _apiService.get('/Stu/$stuid/workid');
    return response;
  }

  //拿學生切結書(affidavit)、同意書(consent)的後端url
  Future<List<String>> getStudentTeamfiles(String teamid) async{
    final response = await _apiService.get('/Teams/$teamid/files');
    return [response['affidavit'],response['consent']];
  }

  //拿學生說明書(workintro)、海報(poster)的後端url
  Future<List<String>> getStudentWorkfiles(String workid) async{
    final response = await _apiService.get('/Work/$workid/files');
    return [response['workintro'],response['workposter']];
  }

  // 先跳過
  //更新說明書、切結書、同意書、海報、yturl、githuburl
  Future<void> uploadWorkNTeamfileNurl(
    String teamid,
    String workid,
    List<PlatformFile>? teamfile,
    PlatformFile? workfile,
    PlatformFile? workposter,
    Map<String, dynamic>? urls
  ) async{

    if( teamfile != null && teamfile.isNotEmpty){
      await _apiService.uploadFile('/Team/$teamid',files: teamfile);
    }

    if ( workfile != null && workposter != null){
      await _apiService.uploadFile('/Work/$workid',files: [workfile],Imgs: [workposter]);
    }else if(workfile != null){
      await _apiService.uploadFile('/Work/$workid',files: [workfile]);
    }else if(workposter != null){
      await _apiService.uploadFile('/Work/$workid',Imgs: [workposter]);
    }

    if(urls != null){
      await _apiService.put('/Work/$workid/url', urls);
    }
  }

  //這個可以先不寫!
  //更新檔案
  //locate可能為Work或Team，id隨之為workid、teamid
  //fileattribute含說明書、切結書、同意書
  Future<void> updateStudentFile(String locate,String id,String fileattribute,PlatformFile? file) async{
    if(file!=null){
      await _apiService.updateFile('/$locate/$id/$fileattribute', file: file);
    }else{
      await _apiService.put('/$locate/$id/$fileattribute', {fileattribute: 'none'});
    }
  }


  //可先不寫
  //更新作品海報
  Future<void> updateStudentImg(String workid,PlatformFile? file) async{
    if(file!=null){
      await _apiService.updateFile('/Work/$workid/poster', Img: file);
    }else{
      await _apiService.put('/Work/$workid/poster', {'workposter':'none'});
    }
  }


  //拿隊伍的所有隊員資料
  //應該跟AdminTeamService是同個api路徑，應該不用重寫?
  Future<List<Student>> getStudentByTeamId(String teamid) async{
    final response = await _apiService.get('/Team/$teamid');
    return (response as List).map((json)=>Student.fromJson(json)).toList();
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

    await _apiService.post('/Teams/add', team);
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