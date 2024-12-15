import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = true;
  bool get isLoggedIn => _isLoggedIn;
  String _usertype = "stu";
  String get usertype => _usertype;

  bool _isSidebarOpen = false;
  bool get isSidebarOpen => _isSidebarOpen;

  void login() {
    _isLoggedIn = true;
    notifyListeners(); // 通知所有聽眾更新狀態
  }

  void logout() {
    _isLoggedIn = false;
    _usertype="none";
    notifyListeners();
  }

  void chageusertype(String str) {
    if(str=="admin" || str=="stu" || str =="tr" || str == "judge")
      _usertype=str;
    notifyListeners();
  }

  void clicksidebar() {
    _isSidebarOpen = !_isSidebarOpen;
    notifyListeners();
  }
}
