import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/common/logic/LoginService.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'dart:convert';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: Navbar(),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginfromkey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginService _loginService = LoginService();
  String? usertype;
  

  Future<void> _login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String? usertype;
    RegExp regex = RegExp(r'11[1-3]|10[7-9]');
    if(username.contains('@')){
      usertype='tj';
    }
    else if(username.indexOf(RegExp(r'[ABLM][ablm]')) == 0 && username.length == 8){
      if(regex.hasMatch(username.substring(1,4))){
        usertype='stu';
      }
      else{
        usertype='admin';
      }
    }
    else{
      usertype = 'admin';
    }
    String? response = await _loginService.login(usertype!, username, password);
    print(response);

    if (response != null) {
      print("登入成功: $response");
      Provider.of<AuthProvider>(context, listen: false).login(username);
      Provider.of<AuthProvider>(context, listen: false).chageusertype(usertype!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('登入成功')),
      );
      Navigator.pushNamed(context, '/$usertype');
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('登入失敗，請檢查帳號密碼')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 350,
        height: 300,
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow:const [ BoxShadow(
            color: Colors.black45,
            offset: Offset(10, 20),
            blurRadius: 45.0,
            spreadRadius: 0.0,
          )]
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Form(
            key: _loginfromkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _usernameController, // 綁定控制器
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '帳號',
                    hintText: '請輸入帳號',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '帳號請勿為空值';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController, // 綁定控制器
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '密碼',
                    hintText: '請輸入密碼',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '密碼請勿為空值';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed:_login,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.black,
                    fixedSize:const Size(200, 50)
                  ),
                  child: const Text('登入',style: TextStyle(fontSize: 16),),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10,bottom: 10),
                  color: Colors.grey.shade400,
                  height: 1,
                ),
                TextButton(
                  onPressed: (){},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blueAccent
                  ),
                  child: const Text("忘記密碼?",style: TextStyle(decoration: TextDecoration.underline,decorationColor: Colors.blueAccent))
                )
              ],
            ),
          ),
          ]
        ),
      ),
    );
  }
}