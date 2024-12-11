// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'LoginPage.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black
        )
      )
    ),
    initialRoute: '/',
    routes:{
      '/':(context) =>HomePage(),
      '/login':(context)=>LoginPage(),
      // '/Ann':(context)=>AnnAllPage(),
    },
  ));
 
}