import 'package:db_finalproject/data/User.dart';

class Teacher extends User{
  String? trJobType;
  String? trDepartment;
  String? trOriganization;

  Teacher({
    required super.id,
    super.passwd,
    required super.name,
    required super.email,
    required super.sexual,
    required super.phone,
    this.trJobType,
    this.trDepartment,
    this.trOriganization
  });

  factory Teacher.fromJson(Map<String, dynamic> json){
    return Teacher(
      id: json['trid'] as String, 
      name: json['trname'] as String, 
      email: json['trid'] as String, //在資料庫裏面email只存在id欄位，在前端為了方便呼叫會多email欄位
      sexual: json['trsexual'] as String, 
      phone: json['trphone'] as String,
      trJobType: json['trjobtype'] as String?,
      trDepartment: json['trdepartment'] as String?,
      trOriganization: json['trorganization'] as String?
    );
  }
}