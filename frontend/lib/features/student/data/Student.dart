import 'package:db_finalproject/features/common/data/User.dart';

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
}
