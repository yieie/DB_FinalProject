//公告結構(還缺照片及文件變數，待補)
import 'package:flutter/foundation.dart';

class AnnStruct{
  int id;
  String date;
  String title;
  String? info;
  String? imgamount;
  List<String>? imageurl;
  String? fileamount;
  List<String>? filename;
  List<String>? fileurl;

  AnnStruct({required this.id,required this.date,required this.title,
            this.info,this.imgamount,this.imageurl,
            this.fileamount,this.filename,this.fileurl});

  factory AnnStruct.fromBasicJson(Map<String, dynamic> json) {
    return AnnStruct(
      id: json['annID'] as int,
      date: json['annTime'] as String,
      title: json['annTitle'] as String,
      imgamount: json['annAmount'] as String?,
      fileamount: json['fileAmount'] as String?
    );
  }

  factory AnnStruct.fromDetailJson(Map<String, dynamic> json) {
    return AnnStruct(
      id: json['annID'] as int,
      date: json['annTime'] as String,
      title: json['annTitle'] as String,
      info: json['annInfo'] as String?,
      imageurl: json['poster'] as List<String>?,
      filename: json['fileName'] as List<String>?,
      fileurl: json['fileurl'] as List<String>?,
    );
  }
}

class UserStruct{
  String id;
  String passwd;
  String name;
  String email;
  String sexual;
  String phone;

  UserStruct({
    required this.id,
    required this.passwd,
    required this.name,
    required this.email,
    required this.sexual,
    required this.phone
  });
}

class StuStruct extends UserStruct{
  String major;
  String grade;
  bool? isLeader;
  String? teamid;

  StuStruct({
    required super.id,
    required super.passwd,
    required super.name,
    required super.email,
    required super.sexual,
    required super.phone,
    required this.major,
    required this.grade
  });
}

class TeamsStatus {
  int amounts; //隊伍總數
  int approved; //審核通過數量
  int notreview; //未審核數量
  int incomplete; //需補件數量
  int qualifying; //進初賽隊伍數量
  int finalround; //進決賽隊伍數量

  TeamsStatus({
    required this.amounts, 
    required this.approved, 
    required this.notreview, 
    required this.incomplete,
    required this.qualifying,
    required this.finalround
  });

  factory TeamsStatus.fromJson(Map<String,dynamic> json){
    return TeamsStatus(
      amounts: json['amount'] as int, 
      approved: json['approved'] as int, 
      notreview: json['notreview'] as int, 
      incomplete: json['incomplete'] as int, 
      qualifying: json['qualifying'] as int, 
      finalround: json['finalround'] as int
    );
  }
}

class TeamStruct {
  String teamid;
  String teamname;
  String? rank;
  String? affidavit;
  String? consent;
  String? teacheremail;
  String? state;

  String workid;
  String? workname;
  String? worksummary;
  String? worksdgs;
  String? workposter;
  String? workyturl;
  String? workgithub;
  String? workyear;
  String? workintro;

  TeamStruct({
    required this.teamid,
    required this.teamname,
    required this.workid,
    this.rank,this.affidavit,
    this.consent,this.teacheremail,
    this.state,this.workname,
    this.worksummary,this.worksdgs,
    this.workposter,this.workyturl,
    this.workgithub,this.workyear,
    this.workintro
  });

  factory TeamStruct.fromBasicJson(Map<String, dynamic> json){
    return TeamStruct(
      teamid: json['teamid'] as String,
      teamname: json['teamname'] as String,
      workid: json['workid'] as String,
      workintro: json['workintro'] as String?,
      consent: json['consent'] as String?,
      affidavit: json['affidavit'] as String?
    );
  } 
}