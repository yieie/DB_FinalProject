import 'package:flutter/material.dart';

class AdminDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Flexible(
            flex: 3,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end, // 將內容對齊右側
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child:Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('公告資料'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.dataset_outlined),
                  title: Text('報名資料'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('評審管理'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('評分與得獎'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('郵件發送'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Container(
            width: 280,
            height: 1,
            color: Colors.black26
          ),
          Flexible(
            flex: 1,
            child: 
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(Icons.manage_accounts),
                    title: Text('帳戶設定'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
}

class StuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Flexible(
            flex: 3,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end, // 將內容對齊右側
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child:Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('隊伍資料'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.dataset_outlined),
                  title: Text('報名資料'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Container(
            width: 280,
            height: 1,
            color: Colors.black26
          ),
          Flexible(
            flex: 1,
            child: 
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(Icons.manage_accounts),
                    title: Text('帳戶設定'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
}

class TrDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Flexible(
            flex: 3,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end, // 將內容對齊右側
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child:Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('指導隊伍資料'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Container(
            width: 280,
            height: 1,
            color: Colors.black26
          ),
          Flexible(
            flex: 1,
            child: 
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(Icons.manage_accounts),
                    title: Text('帳戶設定'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
}

class JudgeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Flexible(
            flex: 3,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end, // 將內容對齊右側
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child:Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('評分'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Container(
            width: 280,
            height: 1,
            color: Colors.black26
          ),
          Flexible(
            flex: 1,
            child: 
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(Icons.manage_accounts),
                    title: Text('帳戶設定'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
}