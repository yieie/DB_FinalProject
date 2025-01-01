import 'package:db_finalproject/data/User.dart';

class Student extends User{
  String major;
  String grade;
  bool? isLeader;
  String? teamid;
  String? stuIdCard;

  Student({
    required super.id,
    super.passwd,
    required super.name,
    required super.email,
    required super.sexual,
    required super.phone,
    required this.major,
    required this.grade,
    this.isLeader,
    this.teamid,
    this.stuIdCard
  });

  factory Student.fromJson(Map<String,dynamic> json){
    return Student(
      id: json['stuid'] as String,
      name: json['stuname'] as String, 
      email: json['stuemail'] as String, 
      sexual: json['stusexual'] as String, 
      phone: json['stuphone'] as String, 
      major: json['stumajor'] as String, 
      grade: json['stugrade'] as String,
      isLeader: json['stuisLeader'] as bool?,
      teamid: json['teamid'] as String?,
      stuIdCard: json['stuIdCard'] as String?
    );
  }
}
