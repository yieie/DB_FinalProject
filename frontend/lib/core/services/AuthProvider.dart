import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  String _usertype = "none";
  String get usertype => _usertype;
  String _useraccount = 'iii@gmail.com';
  String get useraccount => _useraccount;

  bool _isSidebarOpen = false;
  bool get isSidebarOpen => _isSidebarOpen;

  void login(String useraccount) {
    _isLoggedIn = true;
    changeAccount(useraccount);
    notifyListeners(); // 通知所有聽眾更新狀態
  }

  void logout() {
    _isLoggedIn = false;
    _usertype="none";
    _useraccount = "null";
    _isSidebarOpen = false;
    notifyListeners();
  }

  void chageusertype(String str) {
    if(str=="admin" || str=="stu" || str =="tr" || str == "judge"){
      _usertype=str;
    }
    notifyListeners();
  }

  void clicksidebar() {
    _isSidebarOpen = !_isSidebarOpen;
    notifyListeners();
  }

  void changeAccount(String str){
    _useraccount=str;
  }
}
