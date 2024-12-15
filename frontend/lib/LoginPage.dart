import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Navbar.dart';
import 'ApiService.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'AuthProvider.dart';
import 'Admin/AdminMainPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Navbar(),
      body: const UserType(),
    );
  }
}

class UserType extends StatelessWidget {
  const UserType({super.key});
  

  @override
  Widget build(BuildContext context){
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "請選擇您的身份別",
            style: TextStyle(fontSize: 24),),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200,50),
                  backgroundColor: Colors.white24,
                  foregroundColor: Colors.black
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginForm(usertype: "stu")));
                }, 
                child: Text("學生")
              ),
              SizedBox(width: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200,50),
                  backgroundColor: Colors.white24,
                  foregroundColor: Colors.black
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginForm(usertype: "Tr")));
                }, 
                child: Text("老師")
              ),
              SizedBox(width: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200,50),
                  backgroundColor: Colors.white24,
                  foregroundColor: Colors.black
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginForm(usertype: "admin")));
                }, 
                child: Text("系統管理員")
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final String usertype;
  const LoginForm({super.key,required this.usertype});
  

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginfromkey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();
  

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    String? response = await ApiService.login(widget.usertype,username, password);

    if (response != null) {
      print("登入成功: $response");
      Provider.of<AuthProvider>(context, listen: false).login();
      Provider.of<AuthProvider>(context, listen: false).chageusertype(widget.usertype);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('登入成功')),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => AdminMainPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('登入失敗，請檢查帳號密碼')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Navbar(),
      body: Align(
      alignment: Alignment.center,
      child: Container(
        width: 350,
        height: 300,
        alignment: Alignment.center,
        child: Form(
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
              ElevatedButton(
                onPressed:_login
                //  (){
                //   print("usertype:");
                //   print(widget.usertype);
                // }
                ,
                child: const Text('登入'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white60,
                  foregroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    )
    );
  }
}