// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../Navbar.dart';

class AdminMainPage extends StatelessWidget{
  const AdminMainPage({super.key});
  // final GlobalKey<ScaffoldState> Scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context){
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Navbar(),
      body: Container(height: 10),
    );

  }
}
