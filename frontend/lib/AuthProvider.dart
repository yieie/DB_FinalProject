import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    notifyListeners(); // 通知所有聽眾更新狀態
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
