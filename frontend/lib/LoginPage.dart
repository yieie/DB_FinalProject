import 'package:flutter/material.dart';
import 'Navbar.dart';

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
                      onPressed: () {
                        if (_loginfromkey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
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