import 'package:db_finalproject/common/data/RegisterRepository.dart';
import 'package:db_finalproject/data/Student.dart';

class RegisterService {
  final RegisterRepository _registerRepository = RegisterRepository();

  Future<String?> register(Student stu){
    return _registerRepository.register(stu);
  }
}