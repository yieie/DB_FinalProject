import 'package:db_finalproject/presentation/widgets/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/presentation/widgets/Sidebar.dart';

class RateTeams extends StatefulWidget{
  @override
  _RateTeamsState createState() => _RateTeamsState();
}

class _RateTeamsState extends State<RateTeams> {

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
            child: Text("RateTeams")
          ),
          Sidebar()
        ]
      )
    );

  }
}