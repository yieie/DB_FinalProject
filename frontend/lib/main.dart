// import 'dart:ffi';

import 'package:db_finalproject/features/admin/presentation/AdminMainPage.dart';
import 'package:db_finalproject/features/judge/presentation/JudgeMainPage.dart';
import 'package:db_finalproject/features/student/presentation/stu.dart';
import 'package:db_finalproject/features/teacher/presentation/TrMainPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/common/presentation/HomePage.dart';
import 'features/common/presentation/LoginPage.dart';
import 'core/services/AuthProvider.dart';
import 'features/common/presentation/RegisterPage.dart';
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
        '/':(context) =>HomePage(),
        // '/':(context) =>AdminMainPage(),
        '/login':(context)=>LoginPage(),
        '/register':(context)=>RegisterPage(),
        // '/teacher':(context)=>TrMainPage()
        // '/student':(context)=>StuMainPage(),
      },
    )
  ));
 
}

