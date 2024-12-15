// import 'dart:ffi';

import 'package:db_finalproject/Admin/AdminMainPage.dart';
import 'package:db_finalproject/Judge/JudgeMainPage.dart';
import 'package:db_finalproject/Stu/stu.dart';
import 'package:db_finalproject/Tr/TrMainPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';
import 'LoginPage.dart';
import 'AuthProvider.dart';
import 'RegisterPage.dart';
import 'UploadImg.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child:MaterialApp(
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black
          )
        )
      ),
      initialRoute: '/',
      routes:{
        // '/':(context) =>HomePage(),
        '/':(context) =>TrMainPage(),
        '/login':(context)=>LoginPage(),
        '/register':(context)=>RegisterPage(),
        // '/teacher':(context)=>TrMainPage()
        // '/student':(context)=>StuMainPage(),
      },
    )
  ));
 
}

