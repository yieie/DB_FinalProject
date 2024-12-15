import 'package:db_finalproject/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatefulWidget{
  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final Map<String, List<String>> userSidebar = {
    "admin": ['公告管理','比賽資料管理','使用者管理'],
    "stu": ["個人資料管理","隊伍報名管理","文件上傳","工作坊報名"],
    "tr": ["個人資料管理","指導隊伍管理"],
    "judge": ["評分隊伍列表","評分紀錄"],
  }; 
  
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
              leading: Icon(Icons.circle,size: 15),
              title: Text(item),
              onTap: (){

              },
            );
        }).toList(),
      ):null,
    );
  }
}