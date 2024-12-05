import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Navbar.dart';
import 'ApiService.dart';


class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Navbar(),
      body:const LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget{
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();

}

class _LoginFormState extends State<LoginForm>{
  final _loginfromkey=GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService=ApiService();
  
  //呼叫apiservice登入，並將token儲存在本機端
  void _login(BuildContext context) async{
    final username = _usernameController.text;
    final password = _passwordController.text;

    final token = await _apiService.login(username, password);
    if(token != null){
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('登入成功')),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('登入失敗，請檢查帳號密碼')),
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return Align(
      alignment: Alignment.center,
      child: Container(
          width: 350,
          height: 200,
          alignment: Alignment.center,
          // decoration: BoxDecoration(
          //   border:Border.all(),
          // ),
          child: Form(
            key:_loginfromkey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '帳號',
                    
                  ),
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return '帳號請勿為空值';
                    }
                    return null;
                  },
                ),
                Container(height: 10),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '密碼',
                    
                  ),
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return '密碼請勿為空值';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () =>_login(context),
                      child: const Text('登入'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Colors.white60,
                        foregroundColor: Colors.black
                      ),
                      ),
                  )
              ],
            ),
          ),
         ),
    );
  }
}