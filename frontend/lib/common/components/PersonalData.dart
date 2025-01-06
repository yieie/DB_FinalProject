import 'package:db_finalproject/common/logic/PersonalDataService.dart';
import 'package:db_finalproject/data/Student.dart';
import 'package:db_finalproject/data/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';

final List<String> major =  [
  "請選擇","西洋語文學系","運動健康與休閒學系","東亞語文學系","運動競技學系","建築學系","工藝與創意設計學系",
  "法律學系","政治法律學系","財經法律學系",
  "應用經濟學系","亞太工商管理學系","財務金融學系","資訊管理學系",
  "應用數學系","生命科學系","應用化學系","應用物理學系",
  "電機工程學系","土木與環境工程學系","化學工程及材料工程學系","資訊工程學系"]; 
final List<String> grade=["請選擇","一年級","二年級","三年級","四年級","五年級","六年級"];
final List<String> sex = ['男','女'];

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PersonalDataService _personalDataService = PersonalDataService();

  User? user;
  // Map<String,FocusNode> focusNodes = {};

  Future<void> _saveChanges(String usertype) async{
    try{
      await _personalDataService.updateUserData(usertype, user!);
    }catch(e){
      print(e);
    }
  }

  Future<void> fetchUserData(String usertype, String useraccount) async{
    try{
      user= await _personalDataService.getUserData(usertype, useraccount);
      // user!.id = useraccount;
      setState(() {});
    }catch(e){
      print(e);
      user = Student(id: 'A1103344', passwd: '1111',name: '王大強', email: 'a1103344@mail.nuk.edu.tw', sexual: '女', phone: '0977888555', major: '資訊管理學系', grade: '四年級');
      setState(() {});
    }
  }

  

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.usertype != 'none' && authProvider.useraccount != 'none') {
        print(authProvider.usertype);
        print(authProvider.useraccount);
        fetchUserData(authProvider.usertype, authProvider.useraccount);
      }
  /*     if(authProvider.usertype == 'stu'){
        focusNodes = {
          "stupasswd": FocusNode(),
          "stuname": FocusNode(),
          "stuphone": FocusNode(),
          "stuemail": FocusNode()
        };
      }else if(authProvider.usertype == 'tr'){
        focusNodes = {
          "trpasswd": FocusNode(),
          "trname": FocusNode(),
          "trphone": FocusNode(),
          "trjobtype": FocusNode(),
          "trdepartment": FocusNode(),
          "trorganization": FocusNode()
        };
      }else if(authProvider.usertype == 'judge'){
        focusNodes = {
          "judgepasswd": FocusNode(),
          "judgename": FocusNode(),
          "judgephone": FocusNode(),
          "judgetitle": FocusNode()
        };
      } */
    });
  }

/*   @override
  void dispose() {
    focusNodes.values.forEach((node) => node.dispose()); // 記得在銷毀時清理
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userType = authProvider.usertype;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Navbar(),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: authProvider.isSidebarOpen ? 250 : 0),
            child: Container(
              height: 700,
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
                    const SizedBox(height: 30),
                    user == null ?const Center(child: CircularProgressIndicator()):
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
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
                                    _saveChanges(userType);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("資料已成功更新！")),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text(
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
      _buildReadOnlyField("學號", user!.id),
      _buildEditableField("密碼", "stupasswd", user!),
      _buildEditableField("姓名", "stuname", user!),
      _buildEditableSelectedBox('生理性別', sex, 'stusexual',user!),
      _buildEditableField("聯絡方式", "stuphone", user!),
      _buildEditableField("Email", "stuemail", user!),
      _buildEditableDropdownButton('系所', major , "stumajor", user!),
      _buildEditableDropdownButton("年級", grade ,"stugrade", user!),
    ];
  }

  List<Widget> _buildTeacherFields() {
    return [
      _buildReadOnlyField("Email", user!.id),
      _buildEditableField("密碼", "tjpasswd", user!),
      _buildEditableField("姓名", "tjname", user!),
      _buildEditableSelectedBox('生理性別', sex, 'trsexual',user!),
      _buildEditableField("聯絡方式", "tjphone", user!),
      _buildEditableField("職位", "trjobtype", user!),
      _buildEditableField("系所", "trdepartment", user!),
      _buildEditableField("組織", "trorganization", user!),
    ];
  }

  List<Widget> _buildJudgeFields() {
    return [
      _buildReadOnlyField("Email", user!.id),
      _buildEditableField("密碼", "judgepasswd", user!),
      _buildEditableField("姓名", "judgename", user!),
      _buildEditableSelectedBox('生理性別', sex, 'judgesexual',user!),
      _buildEditableField("聯絡方式", "judgephone", user!),
      _buildEditableField("職稱", "judgetitle", user!),
    ];
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        readOnly: true,
      ),
    );
  }

  Widget _buildEditableField(String label, String key, User user) {
    return Padding(
      padding: const EdgeInsets.only(top: 20,bottom: 20),
      child: TextFormField(
        // focusNode: focusNodes[key],
        initialValue: user.getField(key),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
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
          user.setField(key, value!);
        },
      ),
    );
  }

  Widget _buildEditableDropdownButton(String fieldname,List<String> choice, String key, User user){
    return Row(
      children:[
        Text(fieldname,style: const TextStyle(fontSize: 16),),
        const SizedBox(width: 10,),
        DropdownButton<String>(
          value: user.getField(key),
          icon: const Icon(Icons.keyboard_arrow_down),
          dropdownColor: Colors.white,
          onChanged: (String? value){
            setState(() {
              user.setField(key, value!);
            });
          },
          items: choice.map((String item){
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ]
    );
  }

  Widget _buildEditableSelectedBox(String fieldname,List<String> choice, String key, User user){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [Text(fieldname,style: const TextStyle(fontSize: 16)),...
      choice.map((String item) {
        return Row(
          children: [
            Radio<String>(
              value: item,
              groupValue: user.getField(key),
              onChanged: (value) {
                setState(() {
                  user.setField(key, value!);
                });
              },
            ),
            Text(item)
          ],
        );
      })
      ]
    );
  }
}