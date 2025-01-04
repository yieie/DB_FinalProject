import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/admin/components/admin.dart';
import 'package:db_finalproject/judge/components/judge.dart';
import 'package:db_finalproject/student/components/stu.dart';
import 'package:db_finalproject/common/components/PersonalData.dart';

class Sidebar extends StatefulWidget{
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final Map<String, List<String>> userSidebar = {
    "admin": ['公告管理','工作坊管理','評審資料管理',"隊伍管理","查看評分資料"],
    "stu": ["個人資料管理","隊伍報名管理","文件上傳","工作坊報名"],
    "tr": ["個人資料管理"],
    "judge": ["個人資料管理","評分列表","評分隊伍資料"],
  }; 

  Future<dynamic> pageroute(String str,String usertype) async{
    if(usertype=='admin'){
      if(str=='公告管理'){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AnnManage(),
          ),
        );
      }else if(str =='比賽資料管理'){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ContestData(),
          ),
        );
      }else if(str=="工作坊管理"){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WorkshopDataFrame(),
          ),
        );
      }else if(str == "評審資料管理"){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const JudgeDataFrame(),
          ),
        );
      }else if(str == '隊伍管理'){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ContestData(),
          ),
        );
      }else{
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ViewScores(),
          ),
        );
      }
    }else if (usertype == 'stu'){
      if(str=='個人資料管理'){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PersonalData(),
          ),
        );
      }else if(str =='隊伍報名管理'){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TeamData(),
          ),
        );
      }else if(str =='文件上傳'){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ContestDataUpload(),
          ),
        );
      }else{
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WorkshopJoin(),
          ),
        );
      }
  }else if(usertype =='judge'){
    if(str =='個人資料管理'){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PersonalData(),
          ),
        );
      }else if(str == '評分列表'){
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RateRecords(),
          ),
        );
      }else{
        return 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RateTeams(),
          ),
        );
      }
  }else{
    return 
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PersonalData(),
      ),
    );
}
  }
  
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: authProvider.isSidebarOpen ? 250 : 0,
      color: Colors.grey.shade300,

      child: authProvider.isSidebarOpen?
      ListView(
        children: (userSidebar[authProvider.usertype]??[]).map((item)
        {
          return ListTile(
              leading:const SizedBox(
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