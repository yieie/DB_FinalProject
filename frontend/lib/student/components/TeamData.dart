import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TeamData extends StatefulWidget {
  @override
  _TeamDataState createState() => _TeamDataState();
}

class _TeamDataState extends State<TeamData> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _teamNameController = TextEditingController();
  final List<Map<String, dynamic>> _studentData = List.generate(
    6,
    (_) => {
      "學號": TextEditingController(),
      "密碼": TextEditingController(),
      "姓名": TextEditingController(),
      "性別": TextEditingController(),
      "聯絡方式": TextEditingController(),
      "Email": TextEditingController(),
      "系所": TextEditingController(),
      "年級": TextEditingController(),
      "學生證": null,
      "是否為隊長": 0,
    },
  );
  String _teamType = "創意發想組";

  Future<void> _pickFile(int studentIndex, String field) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _studentData[studentIndex][field] = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("無法選擇文件：$e")),
      );
    }
  }

  Future<void> _registerTeam() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("隊伍報名已提交成功！")),
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "隊伍報名",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _teamNameController,
                        decoration: InputDecoration(
                          labelText: "隊伍名稱",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "隊伍名稱為必填";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      Text(
                        "成員資料 (至少兩人，最多六人)",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ..._studentData.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, dynamic> student = entry.value;
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "成員 ${index + 1}",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              ...student.keys
                                  .where((field) => field != "學生證" && field != "是否為隊長")
                                  .map((field) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextFormField(
                                    controller: student[field],
                                    decoration: InputDecoration(
                                      labelText: field,
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.grey.shade50,
                                    ),
                                    validator: (value) {
                                      if (index < 2 && (value == null || value.isEmpty)) {
                                        return "至少需要兩位成員資料完整";
                                      }
                                      return null;
                                    },
                                  ),
                                );
                              }).toList(),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () => _pickFile(index, "學生證"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      student["學生證"] == null
                                          ? "上傳學生證"
                                          : "已選擇: ${student["學生證"].path.split('/').last}",
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Row(
                                    children: [
                                      Text("是否為隊長"),
                                      Radio(
                                        value: 1,
                                        groupValue: student["是否為隊長"],
                                        onChanged: (value) {
                                          setState(() {
                                            for (var stu in _studentData) {
                                              stu["是否為隊長"] = 0;
                                            }
                                            student["是否為隊長"] = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      SizedBox(height: 30),
                      DropdownButtonFormField<String>(
                        value: _teamType,
                        items: ["創意發想組", "創業實作組"].map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _teamType = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "選擇隊伍類型",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: _registerTeam,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "提交報名",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Sidebar(),
        ],
      ),
    );
  }
}
