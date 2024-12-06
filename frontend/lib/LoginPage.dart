import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Navbar.dart';
import 'ApiService.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Navbar(),
      body: const LoginForm(),
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
  final ApiService _apiService = ApiService();

  // 呼叫 ApiService 登入，並將 token 儲存在本機端
  void _login(BuildContext context) async {
    // 驗證表單
    if (!_loginfromkey.currentState!.validate()) {
      return;
    }

    final username = _usernameController.text;
    final password = _passwordController.text;

    final token = await _apiService.login(username, password);
    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('登入成功')),
      );
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
                onPressed: () => _login(context),
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
    );
  }
}



//可以成功
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   void _login() async {
//     String? token = await ApiService.login(
//       _usernameController.text,
//       _passwordController.text,
//     );
//     if (token != null) {
//       print('Login successful, token: $token');
//       // 儲存 token 或進入下一頁
//     } else {
//       print('Login failed');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _login,
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(title: const Text('Login')),
//       body: const LoginForm(),
//     );
//   }
// }

// class LoginForm extends StatefulWidget {
//   const LoginForm({super.key});

//   @override
//   State<LoginForm> createState() => _LoginFormState();
// }

// class _LoginFormState extends State<LoginForm> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   // 簡化的登入邏輯
//   void _login() async {
//     // 模擬呼叫 API 登入
//     String? token = await ApiService.login(
//       _usernameController.text,
//       _passwordController.text,
//     );
//     if (token != null) {
//       print('Login successful, token: $token');
//       // 這裡可以選擇是否要導航到下一頁
//     } else {
//       print('Login failed');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.center,
//       child: Container(
//         width: 350,
//         height: 200,
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _usernameController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: '帳號',
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: '密碼',
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _login,
//               child: const Text('登入'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white60,
//                 foregroundColor: Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }