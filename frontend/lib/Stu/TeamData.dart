import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/AuthProvider.dart';
import 'package:db_finalproject/Navbar.dart';
import 'package:db_finalproject/Sidebar.dart';
import 'package:db_finalproject/DataStruct.dart';
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
      "StuID": TextEditingController(),
      "StuPasswd": TextEditingController(),
      "StuName": TextEditingController(),
      "StuSex": TextEditingController(),
      "StuPhone": TextEditingController(),
      "StuEmail": TextEditingController(),
      "StuDepartment": TextEditingController(),
      "StuGrade": TextEditingController(),
      "StuIDCard": null,
      "IsLeader": 0,
    },
  );
  File? _affidavitFile;
  File? _consentFile;
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
        SnackBar(content: Text("Failed to pick a file: $e"))
      );
    }
  }

  Future<void> _registerTeam() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Team registration submitted successfully!"))
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
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "隊伍報名",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _teamNameController,
                        decoration: InputDecoration(
                          labelText: "隊伍名稱",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "隊伍名稱為必填";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        "成員資料 (至少兩人，最多六人)",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ..._studentData.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, dynamic> student = entry.value;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("成員${index + 1}"),
                            SizedBox(height: 10),
                            ...student.keys.where((field) => field != "StuIDCard" && field != "IsLeader").map((field) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextFormField(
                                  controller: student[field],
                                  decoration: InputDecoration(
                                    labelText: field,
                                    border: OutlineInputBorder(),
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
                                  onPressed: () => _pickFile(index, "StuIDCard"),
                                  child: Text(student["StuIDCard"] == null
                                      ? "上傳學生證"
                                      : "已選擇: ${student["StuIDCard"].path.split('/').last}"),
                                ),
                                SizedBox(width: 20),
                                Row(
                                  children: [
                                    Text("是否為隊長"),
                                    Radio(
                                      value: 1,
                                      groupValue: student["IsLeader"],
                                      onChanged: (value) {
                                        setState(() {
                                          for (var stu in _studentData) {
                                            stu["IsLeader"] = 0;
                                          }
                                          student["IsLeader"] = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      }).toList(),
                      SizedBox(height: 20),
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
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _registerTeam,
                        child: Text("提交報名"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Sidebar()
        ],
      ),
    );
  }
}
