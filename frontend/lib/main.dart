// import 'dart:ffi';

import 'package:db_finalproject/admin/AdminMainPage.dart';
import 'package:db_finalproject/admin/components/WorkshopData.dart';
import 'package:db_finalproject/admin/components/admin.dart';
import 'package:db_finalproject/judge/JudgeMainPage.dart';
import 'package:db_finalproject/student/components/stu.dart';
import 'package:db_finalproject/teacher/TrMainPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/HomePage.dart';
import 'common/components/LoginPage.dart';
import 'core/services/AuthProvider.dart';
import 'common/components/RegisterPage.dart';
import 'UploadFile.dart';

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
      onGenerateRoute: (settings) {
        print('Navigating to: ${settings.name}');
        final uri=Uri.parse(settings.name!);

        if (uri.path =='/'){
          // return MaterialPageRoute(builder: (context) => HomePage());
          return MaterialPageRoute(builder: (context) => StuMainPage());
          // return MaterialPageRoute(builder: (context)=>UploadFiles());
        }else if (uri.path == '/login'){
          return MaterialPageRoute(builder: (context) => LoginPage());
        }else if (uri.path == '/register'){
          return MaterialPageRoute(builder: (context) => RegisterPage());
        }else if (uri.path == '/ws/add&edit'){
          final String wsid=uri.queryParameters['wsid']??'-1';
          return MaterialPageRoute(
            builder: (context) => AddNEditWorkshopForm(wsid: wsid)
          );
        }else if (uri.path =='/ann/add&edit'){
          final String annid=uri.queryParameters['annid']??'-1';
          return MaterialPageRoute(
            builder: (context) => AddNEditAnnouncement(annid: annid)
          );
        }else if (uri.path =='/team/review'){
          final String teamid=uri.queryParameters['teamid']!;
          return MaterialPageRoute(
            builder: (context) => showDetailTeam(teamid: teamid)
          );
        }
      }
    )
  ));
 
}

