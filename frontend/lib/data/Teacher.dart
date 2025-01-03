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

  @override
  Map<String,dynamic> toJson(){
    return {
      'trid':email,
      'trpasswd': passwd,
      'trname':name,
      'trsexual':sexual,
      'trphone':phone,
      'trjobtype':trJobType,
      'trdepartment': trDepartment,
      'trorganization': trOriganization
    };
  }

  @override
  void setField(String field,String value){
    switch (field) {
      case 'trid':
        id = value;
        break;
      case 'trpasswd':
        passwd = value;
        break;
      case 'trname':
        name = value;
        break;
      case 'tremail':
        email = value;
        break;
      case 'trsexual':
        sexual = value;
        break;
      case 'trphone':
        phone = value;
        break;
      case 'trjobtype':
        trJobType = value;
        break;
      case 'trdepartment':
        trDepartment = value;
        break;
      case 'troriganization':
        trOriganization = value;
        break;
      default:
        break;
    }
  }


  @override
  String getField(String field){
    switch (field) {
      case 'trid':
        return id;
      case 'trpasswd':
        return passwd!;
      case 'trname':
        return name;
      case 'tremail':
        return email;
      case 'trsexual':
        return sexual;
      case 'trphone':
        return phone;
      case 'trjobtype':
        return trJobType!;
      case 'trdepartment':
        return trDepartment!;
      case 'troriganization':
        return trOriganization!;
      default:
        return '';
    }
  }
  
}