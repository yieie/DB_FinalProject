import 'package:db_finalproject/features/common/data/User.dart';

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
}