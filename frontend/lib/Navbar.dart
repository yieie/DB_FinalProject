import 'package:flutter/material.dart';
import 'HomePage.dart';
//獨立導航條，方面在不同頁面重複使用
class Navbar extends StatefulWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  _NavbarState createState() => _NavbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NavbarState extends State<Navbar> {
  bool _isLoggedIn = false;
  

  @override
  Widget build(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    return AppBar(
      backgroundColor: Colors.black26,
      automaticallyImplyLeading: false, // 禁用返回按鈕
      title: const Text('第十二屆激發學生創意競賽'),
      actions: [
        TextButton(
          onPressed:() {
            if(currentRoute=='/'){
               Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }
            else{
              Navigator.pushNamed(context, '/');
            }
          },
          style: TextButton.styleFrom(foregroundColor: Colors.black),
          child: const Text('首頁'),
        ),
        if (_isLoggedIn)
          TextButton(
            onPressed: () {
              setState(() {
                _isLoggedIn = false;
              });
            },
            child: const Text('登出'),
          )
        else
          TextButton(
            onPressed: () {
              setState(() {
                _isLoggedIn = true;
              });
              Navigator.pushNamed(context, '/');
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('登入'),
          ),
      ],
    );
  }
}
