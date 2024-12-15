import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/AuthProvider.dart';
import 'package:db_finalproject/Navbar.dart';
import 'package:db_finalproject/Sidebar.dart';

class PersonalData extends StatefulWidget {
  @override
  _PersonalDataState createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 模擬的初始資料
  final Map<String, dynamic> _studentData = {
    "StuID": "12345678", // 學號不可更改
    "StuPasswd": "password123",
    "StuName": "張三",
    "StuSex": "男",
    "StuPhone": "0912345678",
    "StuEmail": "example@email.com",
    "StuDepartment": "資訊工程系",
    "StuGrade": "四年級",
    "IsLeader": 0,
  };

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
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '個人資料管理',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // 學號(只讀)
                            TextFormField(
                              initialValue: _studentData["StuID"],
                              decoration: InputDecoration(
                                labelText: '學號 (不可更改)',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                              readOnly: true,
                            ),
                            SizedBox(height: 20),
                            // 可編輯欄位
                            ..._buildEditableFields(),
                            SizedBox(
                              width: 200, // 調整按鈕寬度
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("資料已成功更新！")),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.blue, // 使用藍色背景
                                  foregroundColor: Colors.white, // 使用白色字體
                                ),
                                child: Text(
                                  '儲存修改',
                                  style: TextStyle(
                                    fontSize: 16, 
                                    fontWeight: FontWeight.bold, // 字體加粗
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Sidebar(),
        ],
      ),
    );
  }

  List<Widget> _buildEditableFields() {
    // 定義所有可編輯欄位
    final fields = [
      {"key": "StuPasswd", "label": "密碼"},
      {"key": "StuName", "label": "姓名"},
      {"key": "StuSex", "label": "性別"},
      {"key": "StuPhone", "label": "聯絡方式"},
      {"key": "StuEmail", "label": "Email"},
      {"key": "StuDepartment", "label": "系所"},
      {"key": "StuGrade", "label": "年級"},
    ];

    return fields.map((field) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          initialValue: _studentData[field["key"]],
          decoration: InputDecoration(
            labelText: field["label"],
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '${field["label"]}不能為空';
            }
            return null;
          },
          onSaved: (value) {
            //_studentData[field["key"]] = value;
          },
        ),
      );
    }).toList();
  }
}
