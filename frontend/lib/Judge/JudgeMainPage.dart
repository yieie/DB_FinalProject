// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../Navbar.dart';
// import '../Drawer.dart';

class JudgeMainPage extends StatelessWidget{
  const JudgeMainPage({super.key});
  // final GlobalKey<ScaffoldState> Scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context){
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Navbar(),
      // drawer: JudgeDrawer(),
      body: Container(height: 10),
    );

  }
}
