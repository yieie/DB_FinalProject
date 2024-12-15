import 'package:db_finalproject/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/AuthProvider.dart';
import 'package:db_finalproject/Sidebar.dart';

class WorkshopJoin extends StatefulWidget{
  @override
  _WorkshopJoinState createState() => _WorkshopJoinState();
}

class _WorkshopJoinState extends State<WorkshopJoin> {

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
            child: Text("WorkshopJoin")
          ),
          Sidebar()
        ]
      )
    );

  }
}