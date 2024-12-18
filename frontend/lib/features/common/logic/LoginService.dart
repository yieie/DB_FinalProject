import 'package:db_finalproject/features/common/data/LoginReposity.dart';

class LoginService {
  final LoginReposity _loginReposity = LoginReposity();
  Future<String?> login(String usertype, String username, String userpasswd) async{
    return _loginReposity.login(usertype, username, userpasswd);
  }
}