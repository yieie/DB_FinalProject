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
      id: json['stuid']??'useraccount',
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

  @override
  Map<String,dynamic> toJson(){
    return {
      'stuid': id,
      'stupasswd': passwd,
      'stuname':name,
      'stuemail': email,
      'stusexual':sexual,
      'stuphone':phone,
      'stumajor':major,
      'stugrade':grade,
      'stuIdCard':stuIdCard
    };
  }

  @override
  void setField(String field,String value){
    switch (field) {
      case 'stuid':
        id = value;
        break;
      case 'stupasswd':
        passwd = value;
        break;
      case 'stuname':
        name = value;
        break;
      case 'stuemail':
        email = value;
        break;
      case 'stusexual':
        sexual = value;
        break;
      case 'stuphone':
        phone = value;
        break;
      case 'stumajor':
        major = value;
        break;
      case 'stugrade':
        grade = value;
        break;
      default:
        break;
    }
  }

  @override
  String getField(String field){
    switch (field) {
      case 'stuid':
        return id;
      case 'stupasswd':
        return passwd!;
      case 'stuname':
        return name;
      case 'stuemail':
        return email;
      case 'stusexual':
        return sexual;
      case 'stuphone':
        return phone;
      case 'stumajor':
        return major;
      case 'stugrade':
        return grade;
      default:
        return '';
    }
  }
}
