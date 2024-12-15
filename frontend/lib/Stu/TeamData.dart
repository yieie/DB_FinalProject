import 'package:db_finalproject/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/AuthProvider.dart';
import 'package:db_finalproject/Sidebar.dart';

class TeamData extends StatefulWidget{
  @override
  _TeamDataState createState() => _TeamDataState();
}

class _TeamDataState extends State<TeamData> {

 @override
  Widget build(BuildContext context){
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Navbar(),
      body:Stack(
        
        children:
        [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: authProvider.isSidebarOpen ? 250 : 0),
            child: Text("TeamData")
          ),
          Sidebar()
        ]
      )
    );

  }
}