import 'package:db_finalproject/UploadImg.dart';
import 'package:db_finalproject/common/logic/PersonalDataService.dart';
import 'package:db_finalproject/data/Student.dart';
import 'package:db_finalproject/data/User.dart';
import 'package:db_finalproject/student/logic/SutTeamService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class JoinContest extends StatefulWidget{
  final String stuid;
  const JoinContest({super.key,required this.stuid});

  @override
  State<JoinContest> createState() => _JoinContestState();
}

class _JoinContestState extends State<JoinContest>{
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
  // final List<PlatformFile> _stuIDcard=[];
  String _presentStuController='無';

  final List<String> joinstate=['隊員資料','指導老師資料','參賽作品基本資料'];
  int formstate=0;

  final TextEditingController _trnameController = TextEditingController();
  String _trsexController='無';
  final TextEditingController _tremailController = TextEditingController();
  final TextEditingController _trphoneController = TextEditingController();
  final TextEditingController _trjobtypeController = TextEditingController();
  final TextEditingController _trdepartmentController = TextEditingController();
  final TextEditingController _troranizationController = TextEditingController();

  final TextEditingController _teamnameController = TextEditingController();
  String _teamtypeController = '無';
  final TextEditingController _worknameController = TextEditingController();
  final TextEditingController _worksummaryController = TextEditingController();
  bool _sdghaveController = false;
  final List<bool> _sdgsController = List.generate(17, (int index)=>false);

  Future<void> fetchStudentData() async{
    try{
      User user = await _stupersonalDataService.getUserData('stu', widget.stuid);
      if(user is Student){
        setState(() {
          _stuidController.add(TextEditingController(text: user.id));
          _stunameController.add(TextEditingController(text: user.name));
          _stuemailController.add(TextEditingController(text: user.email));
          _stusexualController.add(user.sexual);
          _stuphoneController.add(TextEditingController(text: user.phone));
          for (var department in collegeData.entries) {
            if (department.value.contains(user.major)) {
              _stucollegeController.add(department.key);// 回傳找到的 key
            }
          }
          _stumajorController.add(user.major);
          _stugradeController.add(user.grade);
          // _stuIDcard.add(PlatformFile(name: '', size: 0));
        });
      }else{
        throw Exception();
      }
    }catch(e){
      print(e);
    }
  }

  // void handleImagesChanged(int index, List<PlatformFile> files) {
  //   setState(() {
  //       _stuIDcard[index] = files.first;
  //   });
  // }

  void _addStudent(){
    if(_stuidController.length==6){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("隊伍最多6人，無法新增隊員")));
    }else{
      setState(() {
        _stuidController.add(TextEditingController());
        _stunameController.add(TextEditingController());
        _stuemailController.add(TextEditingController());
        _stusexualController.add('無');
        _stuphoneController.add(TextEditingController());
        _stucollegeController.add('請選擇');
        _stumajorController.add('請選擇');
        _stugradeController.add('請選擇');
        // _stuIDcard.add(PlatformFile(name: '', size: 0));
      });
    }
  }

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
        // _stuIDcard.removeAt(index);
      });
    }
  }

  Future<void> _saveChanges() async{
    print(_presentStuController);
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
    print(stus[0]);
    Map<String,dynamic> tr={};
    if(_tremailController.text.isNotEmpty){
      tr={
        'trid':_tremailController.text,
        'trname':_trnameController,
        'trsexual':_trsexController,
        'trphone': _trphoneController,
        'trjobtype': _trjobtypeController,
        'trdepartment': _trdepartmentController,
        'trorganization': _troranizationController
      };
    }

    Map<String, dynamic> team = {
      'teamname':_teamnameController.text,
      'teamtype':_teamtypeController,
      'teamstate': "報名待審核"
    };
    print(team);
    String sdg='';
    for(int i=0;i<17;i++){
      if(_sdgsController[i]==true){
        sdg='$sdg,$i';
      }
    }
    if(sdg==''){
      sdg='none';
    }
    Map<String, dynamic> work = {
      'workname': _worknameController.text,
      'worksummary': _worksummaryController.text,
      'worksdgs': sdg
    };
    print(work);
    try{
      await _stuTeamService.postJoinContest(tr.isEmpty?null:tr, team, work, stus);
    }catch(e){
      print(e);
    }

  }

  @override
  void initState(){
    super.initState();
    // fetchStudentData();
    _addStudent();
    _addStudent();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: 1000,
        height: 720,
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: 200,
                  height: 720,
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.center,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: joinstate.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(top: 5,bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: index == formstate ? Colors.grey.shade300:Colors.white
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("• ", style: TextStyle(fontSize: 18)), // 列點符號
                            Expanded(
                              child: Text(
                                joinstate[index],
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 800,
              height: 720,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 670,
                          child: Column(
                            children: [
                              if(formstate == 0)..._buildTeamMembersField(),
                              if(formstate == 1)..._buildTeacherDataField(),
                              if(formstate == 2) ..._buildWorkDataField(),
                            ]
                          )
                        ),

                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              const Spacer(),
                              ElevatedButton(
                                onPressed: (){
                                  if(formstate == 0){
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("已在開頭")));
                                  }
                                  else{
                                    setState(() {
                                      formstate--;
                                    });
                                  }
                                }, 
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(Colors.grey.shade200),
                                  foregroundColor: WidgetStateProperty.all(Colors.grey.shade700)
                                ),
                                child: const Text("上一步",style: TextStyle(fontSize: 18))
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: (){
                                  if(formstate == 2){
                                    _saveChanges();
                                  }
                                  else{
                                    setState(() {
                                      formstate++;
                                    });
                                  }
                                }, 
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(Colors.grey.shade300),
                                  foregroundColor: WidgetStateProperty.all(Colors.black)
                                ),
                                child: Text(formstate==2 ? "報名參加" : "下一步",style: TextStyle(fontSize: 18))
                              ),
                              const Spacer(),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
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
        margin: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            const Text("隊員資料",style: TextStyle(fontSize: 20),),
            const Spacer(),
            TextButton(
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
            const SizedBox(width: 8,)
          ],
        ),
      ),
      _buildStudentDataField()
    ];
  }


  Widget _buildStudentDataField(){
    return SizedBox(
      height: 600,
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
                      TextButton(
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
                      ),
                    ])
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextField(
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
                              // print(_stuemailController[index].text);
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
                  /* UploadImgs(
                    max: 1,
                    title:"學生證正面上傳區",
                    onImagesChanged:(files)=>handleImagesChanged(index, files)
                  ) */
                ],
              ),
            ),
          );
        },
      )
    );
  }

  List<Widget> _buildTeacherDataField(){
    return [
      Container(
        width: 700,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade100
        ),
        padding: const EdgeInsets.only(left: 15),
        margin: const EdgeInsets.only(top: 20),
        child: const Text("指導老師資料(若無可略過)",style: TextStyle(fontSize: 20),)
      ),
      SizedBox(
        width: 700,
        child: Card(
          color: Colors.grey.shade100,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  width: 350,
                  child: TextField(
                    controller: _trnameController,
                    decoration: const InputDecoration(
                      labelText: '姓名',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _tremailController,
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
                      groupValue: _trsexController,
                      onChanged: (value) {
                        setState(() {
                          _trsexController = "男";
                        });
                      },
                    ),
                    const Text("男",style: TextStyle(fontSize: 18),),
                    Radio<String>(
                      value: "女",
                      groupValue: _trsexController,
                      onChanged: (value) {
                        setState(() {
                          _trsexController = "女";
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
                    controller: _trphoneController,
                    decoration: const InputDecoration(
                      labelText: '電話號碼',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 18)
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _trjobtypeController,
                    decoration: const InputDecoration(
                      labelText: '職稱',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 18)
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _troranizationController,
                          decoration: const InputDecoration(
                            labelText: '所屬單位(學校)',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(fontSize: 18)
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _trdepartmentController,
                          decoration: const InputDecoration(
                            labelText: '職稱(系所)',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(fontSize: 18)
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    ];
  }

  List<Widget> _buildWorkDataField(){
    return[
      Container(
        width: 700,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade100
        ),
        padding: const EdgeInsets.only(left: 15),
        margin: const EdgeInsets.only(top: 20),
        child: const Text("作品資料",style: TextStyle(fontSize: 20),)
      ),
      SizedBox(
        width: 700,
        child: Card(
          color: Colors.grey.shade100,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _teamnameController,
                          decoration: const InputDecoration(
                            labelText: '隊伍名稱',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _worknameController,
                          decoration: const InputDecoration(
                            labelText: '作品名稱',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(fontSize: 18)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("參賽組別：",style: TextStyle(fontSize: 18),),
                    Radio<String>(
                      value: "創意發想組",
                      groupValue: _teamtypeController,
                      onChanged: (value) {
                        setState(() {
                          _teamtypeController = "創意發想組";
                        });
                      },
                    ),
                    const Text("創意發想組",style: TextStyle(fontSize: 18),),
                    Radio<String>(
                      value: "創業實作組",
                      groupValue: _teamtypeController,
                      onChanged: (value) {
                        setState(() {
                          _teamtypeController = "創業實作組";
                        });
                      },
                    ),
                    const Text("創業實作組",style: TextStyle(fontSize: 18),),
                  ],
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: _worksummaryController,
                  maxLength: 300,
                  minLines: 8,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    labelText: '*作品摘要',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 18)
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Checkbox(
                      value: _sdghaveController, 
                      onChanged: (value){
                        setState(() {
                          _sdghaveController = value!;
                        });
                      }
                    ),
                    const SizedBox(width: 5,),
                    const Text("與SDGs是否有關連",style: TextStyle(fontSize: 18),)
                  ],
                ),
                _sdghaveController ? _buildSDGsCheckBoxes() : Container(),
                
              ]
             ),
          ),
        ),
      )
    ];
  }

  Widget _buildSDGsCheckBoxes(){
    return SizedBox(
      height: 200,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6, // 每行顯示3張圖片
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 17,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Image.asset('assets/images/SDGs_${index+1}.png' ,fit: BoxFit.cover,),
              Positioned(
                bottom: 5,
                right: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Checkbox(
                    value: _sdgsController[index], 
                    onChanged: (value){
                      setState(() {
                        _sdgsController[index] = value!;
                      });
                    }
                  ),
                )
              ),
            ],
          );
        },
      ),
    );
  }
}