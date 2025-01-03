import 'dart:io';

import 'package:db_finalproject/data/User.dart';

class Judge extends User{
  String? title;

  Judge({
    required super.id,
    super.passwd,
    required super.name,
    required super.email,
    required super.sexual,
    required super.phone,
    this.title
  });

  Map<String,dynamic> toJson(){
    return {
      'judgeid':email,
      'judgepasswd': passwd,
      'judgename':name,
      'judgesexual':sexual,
      'judgephone':phone,
      'judgetitle':title
    };
  }
}