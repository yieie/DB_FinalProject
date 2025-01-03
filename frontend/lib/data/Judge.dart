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

  factory Judge.fromJson(Map<String, dynamic> json){
    return Judge(
      id: json['judgeid'] as String,
      name: json['judgename'] as String, 
      email: json['judgeemail'] as String, 
      sexual: json['judgesexual'] as String, 
      phone: json['judgephone'] as String,
      title: json['judgetitle'] as String?
    );
  }

  @override
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

  @override
  void setField(String field,String value){
    switch (field) {
      case 'judgeid':
        id = value;
        break;
      case 'judgepasswd':
        passwd = value;
        break;
      case 'judgename':
        name = value;
        break;
      case 'judgeemail':
        email = value;
        break;
      case 'judgesexual':
        sexual = value;
        break;
      case 'judgephone':
        phone = value;
        break;
      case 'judgetitle':
        title = value;
        break;
      default:
        break;
    }
  }

  @override
  String getField(String field){
    switch (field) {
      case 'judgeid':
        return id;
      case 'judgepasswd':
        return passwd!;
      case 'judgename':
        return name;
      case 'judgeemail':
        return email;
      case 'judgesexual':
        return sexual;
      case 'judgephone':
        return phone;
      case 'judgetitle':
        return title!;
      default:
        return '';
    }
  }
}