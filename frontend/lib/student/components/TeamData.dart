import 'package:db_finalproject/UploadImg.dart';
import 'package:db_finalproject/common/logic/PersonalDataService.dart';
import 'package:db_finalproject/data/Student.dart';
import 'package:db_finalproject/data/User.dart';
import 'package:db_finalproject/student/logic/SutTeamService.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

class TeammemberData extends StatefulWidget{
  const TeammemberData({super.key});

  @override
  State<TeammemberData> createState() => _TeammemberDataState();
}

class _TeammemberDataState extends State<TeammemberData>{
    final Map<String, List<String>> collegeData = {
    "請選擇": ['請選擇'],
    "人文社會科學院": ["請選擇","西洋語文學系","運動健康與休閒學系","東亞語文學系","運動競技學系","建築學系","工藝與創意設計學系"],
    "法學院": ["請選擇","法律學系","政治法律學系","財經法律學系"],
    "管理學院": ["請選擇","應用經濟學系","亞太工商管理學系","財務金融學系","資訊管理學系"],
    "理學院": ["請選擇","應用數學系","生命科學系","應用化學系","應用物理學系"],
    "工學院": ["請選擇","電機工程學系","土木與環境工程學系","化學工程及材料工程學系","資訊工程學系"],
  }; 
  final List<String> grade=["請選擇","一年級","二年級","三年級","四年級","五年級","六年級"];
  final StuTeamService _stuTeamService = StuTeamService();
  final PersonalDataService _stupersonalDataService = PersonalDataService();
  final List<TextEditingController> _stuidController=[];
  final List<TextEditingController> _stunameController=[];
  final List<TextEditingController> _stuemailController=[];
  final List<String> _stusexualController=[];
  final List<TextEditingController> _stuphoneController=[];
  final List<String> _stucollegeController=[];
  final List<String> _stumajorController=[];
  final List<String> _stugradeController=[];
  final List<String> _stuIDcard=[];
  List<PlatformFile> _editIDcard=[];
  String _presentStuController='無';

  String teamid='team';

  Future<void> fetchStuTeamId(String stuid) async{
    try{
      teamid=await _stuTeamService.getStudentTeamId(stuid);
      setState(() {});
    }catch(e){
      print(e);
    }
  }

  Future<void> fetchStudentData(String teamid) async{
    try{
      List<Student> stu = await _stuTeamService.getStudentByTeamId(teamid);
      setState(() {
        for(var s in stu){
          _stuidController.add(TextEditingController(text: s.id));
          _stunameController.add(TextEditingController(text: s.name));
          _stuemailController.add(TextEditingController(text: s.email));
          _stusexualController.add(s.sexual);
          _stuphoneController.add(TextEditingController(text: s.phone));
          for (var department in collegeData.entries) {
            if (department.value.contains(s.major)) {
              _stucollegeController.add(department.key);// 回傳找到的 key
            }
          }
          _stumajorController.add(s.major);
          _stugradeController.add(s.grade);
          _stuIDcard.add(s.stuIdCard!);
          _presentStuController = '${stu.indexOf(s)}';
        }
        _editIDcard=List.filled(_stuIDcard.length, PlatformFile(name: '', size: 0));
      });
    }catch(e){
      print(e);
      _addStudent();
      _addStudent();
      _presentStuController = '0';
    }
  }

  void handleImagesChanged(int index, List<PlatformFile> files) {
    setState(() {
        _editIDcard[index] = files.first;
    });
  }

  void _addStudent(){
    if(_stuidController.length==6){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("隊伍最多6人，無法新增隊員")));
    }else{
      setState(() {
        _stuidController.add(TextEditingController(text: 'A1111111'));
        _stunameController.add(TextEditingController());
        _stuemailController.add(TextEditingController());
        _stusexualController.add('無');
        _stuphoneController.add(TextEditingController());
        _stucollegeController.add('請選擇');
        _stumajorController.add('請選擇');
        _stugradeController.add('請選擇');
        _editIDcard.add(PlatformFile(name: '', size: 0));
      });
    }
  }
/* 
  void _removeStudent(int index){
    if(_stuidController.length == 2){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("隊伍最少2人，無法刪除隊員")));
    }
    else{
      setState(() {
        _stuidController.removeAt(index);
        _stunameController.removeAt(index);
        _stuemailController.removeAt(index);
        _stusexualController.removeAt(index);
        _stuphoneController.removeAt(index);
        _stucollegeController.removeAt(index);
        _stumajorController.removeAt(index);
        _stugradeController.removeAt(index);
        _stuIDcard.removeAt(index);
      });
    }
  } */

  Future<void> _saveChanges() async{
    List<Map<String,dynamic>> stus=[];
    for(int i=0;i<_stuidController.length;i++){
      stus.add(
        {
          'stuid': _stuidController[i].text,
          'stuname': _stunameController[i].text,
          'stuemail': _stuemailController[i].text, 
          'stusexual': _stusexualController[i],
          'stuphone': _stuphoneController[i].text,
          'stumajor': _stumajorController[i],
          'stugrade': _stugradeController[i]
        }
      );
      if(int.parse(_presentStuController)==i){
        stus[i].addAll({'stuisleader':'true'});
      }else{
        stus[i].addAll({'stuisleader':'false'});
      }
    }
    try{
    }catch(e){
      print(e);
    }

  }

  @override
  void initState(){
    super.initState();
    Future.microtask(() {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.usertype == 'stu' && authProvider.useraccount != 'none') {
        fetchStuTeamId(authProvider.useraccount);
      }  
    });
    if(teamid.contains('team')){
      fetchStudentData(teamid);
    }
  }

  @override
  Widget build(BuildContext context){
    final scrSize = MediaQuery.of(context).size;
    final double screenWidth = scrSize.width-250;
    bool iswidthful = screenWidth > 850 ? true : false;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Navbar(),
      body: Stack(
        
        children:
        [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: authProvider.isSidebarOpen ? 250 : 0),
            child:SingleChildScrollView(
              child:SafeArea(
                  child: Row(
                    children: [
                      if(iswidthful)
                        Flexible(flex: 1, child: Container(color: Colors.transparent)),
                      
                      Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 20)),

                          (teamid=='')?
                          Column(
                          children: [
                            const Text("您還沒報名參加比賽喔！",style: TextStyle(fontSize: 24),),
                            const SizedBox(height: 20,),
                            TextButton(
                              onPressed: (){
                                html.window.open(
                                  '/#/contest?stuid=${authProvider.useraccount}', // 新視窗的網址
                                  'JoinContest',      // 視窗名稱（用於管理視窗實例）
                                  'width=1000,height=720,left=200,top=100', // 視窗屬性
                                );
                              }, 
                              child: const Text(
                                "點選此處立即報名參加",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue,
                                ),)
                            )
                          ],
                        ):
                        SizedBox(
                          height: 650,
                          child: SingleChildScrollView(
                            child: SafeArea(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 580,
                                      child: Column(
                                        children: [
                                          ..._buildTeamMembersField(),
                                        ]
                                      )
                                    ),

                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: 
                                          ElevatedButton(
                                            onPressed: _saveChanges,
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all(Colors.grey.shade300),
                                              foregroundColor: WidgetStateProperty.all(Colors.black)
                                            ),
                                            child: const Text("修改資料",style: TextStyle(fontSize: 18))
                                          )
                                    )
                                  ],
                                ),
                              )
                            ),
                          )
                        ),

                        ],
                      ),
                      

                      if(iswidthful)
                        Flexible(flex: 1, child: Container(color: Colors.transparent)),
                    ],
                  )
              )
            )
          ),
          const Sidebar()
        ]
      )
    );
  }

  List<Widget> _buildTeamMembersField(){
    return [
      Container(
        width: 700,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade100
        ),
        padding: const EdgeInsets.only(left: 15),
        child: const Row(
          children: [
            Text("隊員資料",style: TextStyle(fontSize: 20),),
            Spacer(),
            /* TextButton(
              onPressed:_addStudent,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all((Colors.grey.shade300)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.add_box_outlined,color: Colors.black,),
                  Text("新增隊員",style: TextStyle(fontSize: 16),)
                ],
              ),
            ),
            const SizedBox(width: 8,) */
          ],
        ),
      ),
      _buildStudentDataField()
    ];
  }


  Widget _buildStudentDataField(){
    return SizedBox(
      height: 550,
      width: 700,
      child: ListView.builder(
        itemCount: _stuidController.length,
        itemBuilder: (context,index){
          return Card(
            color: Colors.grey.shade100,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 15),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(children: [
                      Text('隊員${index+1}',style: const TextStyle(fontSize: 18),),
                      const SizedBox(width: 10,),
                      Radio<String>(
                        value: '$index',
                        groupValue: _presentStuController,
                        onChanged: (value) {
                          setState(() {
                            _presentStuController = '$index';
                          });
                        },
                      ),
                      const Text("代表人",style: TextStyle(fontSize: 18),),
                      const Spacer(),
                      /* TextButton(
                        onPressed:() => _removeStudent(index),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all((Colors.red.shade200)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.remove_circle_outline,color: Colors.red,),
                            Text("移除隊員",style: TextStyle(fontSize: 16),)
                          ],
                        ),
                      ), */
                    ])
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            readOnly: true,
                            controller: _stuidController[index],
                            decoration: const InputDecoration(
                              labelText: "學號",
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 18)
                            ),
                            onChanged: (value){
                              setState(() {
                                _stuemailController[index].text = '${_stuidController[index].text}@mail.nuk.edu.tw';
                              });
                              print(_stuemailController[index].text);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            controller: _stunameController[index],
                            decoration: const InputDecoration(
                              labelText: '姓名',
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _stuemailController[index],
                      decoration: const InputDecoration(
                        labelText: '電子郵件',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(fontSize: 18)
                        
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("請選擇您的生理性別：",style: TextStyle(fontSize: 18),),
                      Radio<String>(
                        value: "男",
                        groupValue: _stusexualController[index],
                        onChanged: (value) {
                          setState(() {
                            _stusexualController[index] = "男";
                          });
                        },
                      ),
                      const Text("男",style: TextStyle(fontSize: 18),),
                      Radio<String>(
                        value: "女",
                        groupValue: _stusexualController[index],
                        onChanged: (value) {
                          setState(() {
                            _stusexualController[index] = "女";
                          });
                        },
                      ),
                      const Text("女",style: TextStyle(fontSize: 18),),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _stuphoneController[index],
                      decoration: const InputDecoration(
                        labelText: '電話號碼',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(fontSize: 18)
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children:[
                      const Text("院所：",style: TextStyle(fontSize: 18)),
                      DropdownButton(
                        value: _stucollegeController[index],
                        icon: const Icon(Icons.keyboard_arrow_down),
                        dropdownColor: Colors.white,
                        onChanged: (String? value) {
                          setState((){
                            _stucollegeController[index] = value!;
                            _stumajorController[index] = "請選擇";
                          });
                        },
                        items: collegeData.keys.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item,style: TextStyle(fontSize: 18)),
                          );
                        }).toList(),
                      ),
                      const Spacer(),
                      const Text("系別：",style: TextStyle(fontSize: 18)),
                      DropdownButton<String>(
                        value: _stumajorController[index],
                        icon: const Icon(Icons.keyboard_arrow_down),
                        dropdownColor: Colors.white,
                        onChanged: (String? value) {
                          setState(() {
                            _stumajorController[index] = value!;
                          });
                        },
                        items:(collegeData[_stucollegeController[index]]??[]).map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item,style: TextStyle(fontSize: 18)),
                          );
                        }).toList(),
                      ),
                      const Spacer(),
                      const Text("年級：",style: TextStyle(fontSize: 18)),
                      DropdownButton<String>(
                        value: _stugradeController[index],
                        icon: const Icon(Icons.keyboard_arrow_down),
                        dropdownColor: Colors.white,
                        onChanged: (String? value) {
                          setState(() {
                            _stugradeController[index] = value!;
                          });
                        },
                        items: grade.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item,style: TextStyle(fontSize: 18)),
                          );
                        }).toList(),
                      ),
                  ]),
                  UploadImgs(
                    max: 1,
                    title:"學生證正面上傳區",
                    onImagesChanged:(files)=>handleImagesChanged(index, files)
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }
}