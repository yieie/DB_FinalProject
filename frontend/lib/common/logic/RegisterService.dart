import 'package:db_finalproject/data/Student.dart';
import 'package:db_finalproject/core/services/ApiService.dart';

class RegisterService {
  final ApiService _apiService = ApiService();

  Future<String?> register(Student stu) async{
    final response = await _apiService.post('/auth/register', 
    {
      'id':stu.id,
      'passwd' : stu.passwd,
      'name': stu.name,
      'mail': stu.email,
      'sexual': stu.sexual,
      'phone': stu.phone,
      'major': stu.major,
      'grade': stu.grade
    }
    );
    return response.body;
  }
}