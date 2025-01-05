import 'package:db_finalproject/admin/AdminMainPage.dart';
import 'package:db_finalproject/admin/components/admin.dart';
import 'package:db_finalproject/common/components/HistoryData.dart';
import 'package:db_finalproject/judge/JudgeMainPage.dart';
import 'package:db_finalproject/student/StuMainPage.dart';
import 'package:db_finalproject/student/components/JoinContest.dart';
import 'package:db_finalproject/teacher/TrMainPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/HomePage.dart';
import 'common/components/LoginPage.dart';
import 'core/services/AuthProvider.dart';
import 'common/components/RegisterPage.dart';

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
      initialRoute: '/admin',
      onGenerateRoute: (settings) {
        print('Navigating to: ${settings.name}');
        final uri=Uri.parse(settings.name!);

        if (uri.path =='/'){
          return MaterialPageRoute(builder: (context) => const HomePage());
        }else if(uri.path == '/admin'){
          return MaterialPageRoute(builder: (context) => const AdminMainPage());
        }else if(uri.path == '/judge'){
          return MaterialPageRoute(builder: (context) => const JudgeMainPage());
        }else if(uri.path == '/tr'){
          return MaterialPageRoute(builder: (context) => const TrMainPage());
        }else if(uri.path == '/stu'){
          return MaterialPageRoute(builder: (context) => const StuMainPage());
        }else if(uri.path == '/history'){
          return MaterialPageRoute(builder: (context) => const HistoryData());
        }else if (uri.path == '/login'){
          return MaterialPageRoute(builder: (context) => const LoginPage());
        }else if (uri.path == '/register'){
          return MaterialPageRoute(builder: (context) => const RegisterPage());
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
        }else if (uri.path == '/score/add&edit/teamidea'){
          final String teamid = uri.queryParameters['teamid']!;
          return MaterialPageRoute(
            builder: (context) =>Scoring(teamId: teamid,teamtype: "創意發想組")
          );
        }else if (uri.path == '/score/add&edit/teambusiness'){
          final String teamid = uri.queryParameters['teamid']!;
          return MaterialPageRoute(
            builder: (context) =>Scoring(teamId: teamid,teamtype: "創業實作組")
          );
        }else if (uri.path == '/contest'){
          final String stuid = uri.queryParameters['stuid']!;
          return MaterialPageRoute(
            builder: (context) => JoinContest(stuid: stuid)
          );
        }
      }
    )
  ));
 
}

