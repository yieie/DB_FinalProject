import 'package:flutter/material.dart';
import 'Navbar.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Navbar(),
      body:const Identity(),
    );
  }
}

class Identity extends StatefulWidget{
  const Identity({super.key});

  @override
  State<Identity> createState() => _IdentityState();

}

class _IdentityState extends State<Identity>{
  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: 100,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Text("學生"),
        ),
        Container(
          alignment: Alignment.center,
          height: 100,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Text("指導老師"),
        ),
        Container(
          alignment: Alignment.center,
          height: 100,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Text("評審委員")
        )
      ],
      
    );

  }
}