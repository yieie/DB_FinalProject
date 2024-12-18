import 'package:flutter/material.dart';
import '../../features/common/presentation/HomePage.dart';
import 'package:provider/provider.dart';
import '../../core/services/AuthProvider.dart';

//獨立導航條，方面在不同頁面重複使用
class Navbar extends StatefulWidget implements PreferredSizeWidget {
  
  const Navbar({super.key});

  @override
  _NavbarState createState() => _NavbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NavbarState extends State<Navbar> {
  // bool _isLoggedIn = false;
  

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    return AppBar(
      backgroundColor: Colors.grey.shade300,
      automaticallyImplyLeading: false, // 禁用返回按鈕
      leading: 
      authProvider.isLoggedIn? 
      IconButton(
        icon:Icon(Icons.menu),
        onPressed: (){
          authProvider.clicksidebar();
        },
      )
      :null
      ,
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
        if (authProvider.isLoggedIn)
          TextButton(
            onPressed: () {
              setState(() {
                authProvider.logout();
              });
            },
            child: const Text('登出'),
          )
        else
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('登入'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('註冊'),
              ),
            ],
          ),
      ],
    );
  }
}