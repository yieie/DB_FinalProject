import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';

class UserManage extends StatefulWidget {
  @override
  _UserManageState createState() => _UserManageState();
}

class _UserManageState extends State<UserManage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // 4個分頁
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // 模擬的使用者資料
  final List<Map<String, String>> _userData = [
    {"ID": "12345", "Name": "張三", "Password": "pwd123", "Gender": "男", "Role": "學生"},
    {"ID": "67890", "Name": "李四", "Password": "pwd456", "Gender": "女", "Role": "老師"},
    {"ID": "11223", "Name": "王五", "Password": "pwd789", "Gender": "男", "Role": "評審"},
    {"ID": "44556", "Name": "趙六", "Password": "pwd321", "Gender": "女", "Role": "學生"},
    {"ID": "99887", "Name": "孫七", "Password": "pwd654", "Gender": "男", "Role": "老師"},
  ];

  // 篩選使用者
  List<Map<String, String>> _getFilteredUsers(String role) {
    final query = _searchController.text.trim().toLowerCase();
    return _userData.where((user) {
      final matchesQuery = user.values.any((value) => value.toLowerCase().contains(query));
      final matchesRole = role == "總覽" || user["Role"] == role;
      return matchesQuery && matchesRole;
    }).toList();
  }

  // 建立欄位表格
  Widget _buildUserTable(String role) {
    final users = _getFilteredUsers(role);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          columns: [
            DataColumn(label: Text("ID", style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text("姓名", style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text("密碼", style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text("性別", style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text("角色", style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text("操作", style: TextStyle(fontWeight: FontWeight.bold))), // 新增操作欄位
          ],
          rows: users.map((user) {
            return DataRow(cells: [
              DataCell(Text(user["ID"]!)),
              DataCell(Text(user["Name"]!)),
              DataCell(Text(user["Password"]!)),
              DataCell(Text(user["Gender"]!)),
              DataCell(Text(user["Role"]!)),
              DataCell(
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _openEditUserForm(context, user), // 點擊時呼叫修改表單
                ),
              ),
            ]);
          }).toList(),
        ),
    );
  }

  // 開啟修改使用者資料表單
  void _openEditUserForm(BuildContext context, Map<String, String> user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("修改使用者資料"),
          content: EditUserForm(user: user),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Navbar(),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: authProvider.isSidebarOpen ? 250 : 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "輸入使用者名稱、ID或角色進行查詢",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    onChanged: (value) {
                      setState(() {}); // 更新表格內容
                    },
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.black54,
                  indicatorColor: Colors.blue,
                  overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.grey.shade300; // 按下時的顏色
                    }
                    if (states.contains(WidgetState.hovered)) {
                      return Colors.grey.shade100; // 懸停時的顏色
                    }
                    return null; // 預設無顏色
                  }),
                  // indicator: BoxDecoration(color: Colors.brown),
                  tabs: [
                    Tab(text: "總覽"),
                    Tab(text: "學生"),
                    Tab(text: "老師"),
                    Tab(text: "評審"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildUserTable("總覽"), // 總覽分頁
                      _buildUserTable("學生"), // 學生分頁
                      _buildUserTable("老師"), // 老師分頁
                      _buildUserTable("評審"), // 評審分頁
                    ],
                  ),
                ),
              ],
            ),
          ),
          Sidebar(),
        ],
      ),
    );
  }
}

class EditUserForm extends StatefulWidget {
  final Map<String, String> user;

  EditUserForm({required this.user});

  @override
  _EditUserFormState createState() => _EditUserFormState();
}

class _EditUserFormState extends State<EditUserForm> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _genderController = TextEditingController();
  final _roleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user["Name"]!;
    _passwordController.text = widget.user["Password"]!;
    _genderController.text = widget.user["Gender"]!;
    _roleController.text = widget.user["Role"]!;
  }

  // 儲存修改的資料
  void _saveChanges() {
    setState(() {
      widget.user["Name"] = _nameController.text;
      widget.user["Password"] = _passwordController.text;
      widget.user["Gender"] = _genderController.text;
      widget.user["Role"] = _roleController.text;
    });
    Navigator.of(context).pop(); // 關閉修改表單
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("使用者資料已更新")));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(labelText: "姓名"),
        ),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: "密碼"),
        ),
        TextField(
          controller: _genderController,
          decoration: InputDecoration(labelText: "性別"),
        ),
        TextField(
          controller: _roleController,
          decoration: InputDecoration(labelText: "角色"),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _saveChanges,
          child: Text("儲存"),
        ),
      ],
    );
  }
}
