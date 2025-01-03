import 'package:db_finalproject/admin/components/ViewScores.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/admin/components/JudgeData.dart';
import 'package:db_finalproject/admin/components/WorkshopData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/admin/components/admin.dart';
import 'package:db_finalproject/judge/components/judge.dart';
import 'package:db_finalproject/student/components/stu.dart';
import 'package:db_finalproject/teacher/components/tr.dart';
import 'package:db_finalproject/common/components/PersonalData.dart';

class Sidebar extends StatefulWidget{
  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final Map<String, List<String>> userSidebar = {
    "admin": ['公告管理','工作坊管理','評審資料管理',"隊伍管理","查看評分資料"],
    "stu": ["個人資料管理","隊伍報名管理","文件上傳","工作坊報名"],
    "tr": ["個人資料管理","指導隊伍管理"],
    "judge": ["評分紀錄"],
  }; 

  Future<dynamic> pageroute(String str,String usertype) async{
    if(usertype=='admin'){
      if(str=='公告管理'){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnnManage(),
          ),
        );
      }else if(str =='比賽資料管理'){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContestData(),
          ),
        );
      }else if(str=="工作坊管理"){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkshopDataFrame(),
          ),
        );
      }else if(str == "評審資料管理"){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JudgeDataFrame(),
          ),
        );
      }else if(str == '隊伍管理'){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContestData(),
          ),
        );
      }else{
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewScores(),
          ),
        );
      }
    }else if (usertype == 'stu'){
      if(str=='個人資料管理'){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonalData(),
          ),
        );
      }else if(str =='隊伍報名管理'){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TeamData(),
          ),
        );
      }else if(str =='文件上傳'){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContestDataUpload(),
          ),
        );
      }else{
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkshopJoin(),
          ),
        );
      }
  }else if(usertype =='judge'){
    if(str =='評分隊伍列表'){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RateTeams(),
          ),
        );
      }else{
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RateRecords(),
          ),
        );
      }
  }else{
    if(str =='個人資料管理'){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonalData(),
          ),
        );
      }else{
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TeachTeams(),
          ),
        );
      }
  }
  }
  
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: authProvider.isSidebarOpen ? 250 : 0,
      color: Colors.grey.shade300,

      child: authProvider.isSidebarOpen?
      ListView(
        children: (userSidebar[authProvider.usertype]??[]).map((item)
        {
          return ListTile(
              leading:SizedBox(
                height: 15,
                width: 15,
                child: Icon(Icons.circle,size: 15),
              ) ,
              title: Text(item),
              onTap: (){
                pageroute(item, authProvider.usertype);
              },
            );
        }).toList(),
      ):null,
    );
  }
}