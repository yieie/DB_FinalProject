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
  };

  final Map<String, dynamic> _teacherData = {
    "tjEmail": "teacher@example.com",
    "tjPasswd": "password123",
    "tjName": "李老師",
    "tjSex": "男",
    "tjPhone": "0987654321",
    "trJobType": "教授",
    "trDepartment": "資訊工程系",
    "trOrganization": "某大學",
  };

  final Map<String, dynamic> _judgeData = {
    "tjEmail": "judge@example.com",
    "tjPasswd": "password123",
    "tjName": "王評審",
    "tjSex": "女",
    "tjPhone": "0975123456",
    "jTitle": "首席評審",
  };

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userType = authProvider.usertype;

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
                            if (userType == "stu") ..._buildStudentFields(),
                            if (userType == "tr") ..._buildTeacherFields(),
                            if (userType == "judge") ..._buildJudgeFields(),
                            SizedBox(
                              width: 200,
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
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                ),
                                child: Text(
                                  '儲存修改',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
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

  List<Widget> _buildStudentFields() {
    return [
      _buildReadOnlyField("學號", _studentData["StuID"]),
      _buildEditableField("密碼", "StuPasswd", _studentData),
      _buildEditableField("姓名", "StuName", _studentData),
      _buildEditableField("性別", "StuSex", _studentData),
      _buildEditableField("聯絡方式", "StuPhone", _studentData),
      _buildEditableField("Email", "StuEmail", _studentData),
      _buildEditableField("系所", "StuDepartment", _studentData),
      _buildEditableField("年級", "StuGrade", _studentData),
    ];
  }

  List<Widget> _buildTeacherFields() {
    return [
      _buildReadOnlyField("Email", _teacherData["tjEmail"]),
      _buildEditableField("密碼", "tjPasswd", _teacherData),
      _buildEditableField("姓名", "tjName", _teacherData),
      _buildEditableField("性別", "tjSex", _teacherData),
      _buildEditableField("聯絡方式", "tjPhone", _teacherData),
      _buildEditableField("職位", "trJobType", _teacherData),
      _buildEditableField("系所", "trDepartment", _teacherData),
      _buildEditableField("組織", "trOrganization", _teacherData),
    ];
  }

  List<Widget> _buildJudgeFields() {
    return [
      _buildReadOnlyField("Email", _judgeData["tjEmail"]),
      _buildEditableField("密碼", "tjPasswd", _judgeData),
      _buildEditableField("姓名", "tjName", _judgeData),
      _buildEditableField("性別", "tjSex", _judgeData),
      _buildEditableField("聯絡方式", "tjPhone", _judgeData),
      _buildEditableField("職稱", "jTitle", _judgeData),
    ];
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        readOnly: true,
      ),
    );
  }

  Widget _buildEditableField(String label, String key, Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        initialValue: data[key],
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '$label不能為空';
          }
          return null;
        },
        onSaved: (value) {
          data[key] = value;
        },
      ),
    );
  }
}
