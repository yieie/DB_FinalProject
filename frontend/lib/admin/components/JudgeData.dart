import 'package:db_finalproject/admin/logic/JudgeService.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/data/Judge.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JudgeDataFrame extends StatelessWidget{
  JudgeDataFrame({super.key});
  
  @override
  Widget build(BuildContext context){
    final authProvider = Provider.of<AuthProvider>(context);
    final scrSize = MediaQuery.of(context).size;
    final double screenWidth = scrSize.width-250;
    bool iswidthful = screenWidth > 850 ? true : false;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:Navbar(),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: authProvider.isSidebarOpen ? 250 : 0),
            child:SafeArea(
              child: Row(
                children: [

                  if(iswidthful)
                    Flexible(flex: 1, child: Container(color: Colors.transparent)),
                  
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 20)),

                      SizedBox(
                        width: iswidthful?850:screenWidth,
                        child: JudgeData(),
                      ),

                    ],
                  ),
                  

                  if(iswidthful)
                    Flexible(flex: 1, child: Container(color: Colors.transparent)),
                ],
              )
            )
          ),
          Sidebar(),
        ]
      )
    );
  }
}

class JudgeData extends StatefulWidget{
  @override
  _JudgeDataState createState() => _JudgeDataState();
}

class _JudgeDataState extends State<JudgeData> {
  List<Judge> judges=[
    Judge(id: "123@gamil.com", name: "王大明", email: "123@gamil.com", sexual: "男", phone: "0930222111",title: "12345678"),
    Judge(id: "456@gamil.com", name: "吃大便", email: "456@gamil.com", sexual: "女", phone: "0955772881"),
  ];

  @override
  Widget build(BuildContext context){
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 15)),
              Text("評審資料",
              style: TextStyle(fontSize: 20)),
              Spacer(),
              TextButton(
                onPressed:(){
                  _openAddJudgeForm(context);
                } ,
                child: Row(
                  children: [
                    Icon(Icons.add_box_outlined,color: Colors.black,),
                    Text("新增評審",style: TextStyle(fontSize: 16),)
                  ],
                )),              
            ],
          ),
          SizedBox(height: 20,),
          Table(
            border: TableBorder(
              top: BorderSide(color: Colors.grey ),
              bottom: BorderSide(color: Colors.grey ),
              horizontalInside: BorderSide(color: Colors.grey ),
              verticalInside:BorderSide.none,
              right: BorderSide.none,
              left: BorderSide.none
            ),
            columnWidths: {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(0.5),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(2),
              4: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                children: <Widget>[
                  Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "姓名",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "性別",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "電話",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "頭銜",
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),...judges.map((item)=>TableRow(
              children: [
                Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    item.name,
                    textAlign: TextAlign.left,
                  ),
                ),  
                Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.sexual,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.phone,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.email,
                    textAlign: TextAlign.left,
                  ),
                ),
                item.title!=null?
                Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.title!,
                    textAlign: TextAlign.left,
                  ),
                ):Container(),
              ]
            )).toList()
          ])
        ],
      ),
    );
  }
}

void _openAddJudgeForm(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text("新增評審"),
        content: AddJudgeForm(),
      );
    },
  );
}

class AddJudgeForm extends StatefulWidget {
  AddJudgeForm({super.key});

  @override
  _AddJudgeFormState createState() => _AddJudgeFormState();
}

class _AddJudgeFormState extends State<AddJudgeForm> {
  final _nameController = TextEditingController();
  String _sexual="無";
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _titleController = TextEditingController();
  final JudgeService _judgeService = JudgeService();

  // 儲存修改的資料
  void _saveChanges() {
    Judge? judge;
    setState(() {
      judge= Judge(
        id: _emailController.text,
        name: _nameController.text, 
        email: _emailController.text, 
        sexual: _sexual, 
        phone: _phoneController.text,
        title: _titleController.text
        );
    });
    print(judge!.id);
    print(judge!.title);
    print(judge!.name);
    print(judge!.sexual);
    print(judge!.phone);
    Navigator.of(context).pop(); // 關閉修改表單
    _judgeService.addJudge(judge!);
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
        SizedBox(height: 10,),
        const Text("生理性別"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio<String>(
              value: "男",
              groupValue: _sexual,
              onChanged: (value) {
                setState(() {
                  _sexual = "男";
                });
              },
            ),
            Text("男"),
            Radio<String>(
              value: "女",
              groupValue: _sexual,
              onChanged: (value) {
                setState(() {
                  _sexual = "女";
                });
              },
            ),
            Text("女"),
          ],
        ),
        SizedBox(height: 10,),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(labelText: "email"),
        ),
        TextField(
          controller: _phoneController,
          decoration: InputDecoration(labelText: "電話"),
        ),
        TextField(
          controller: _titleController,
          decoration: InputDecoration(labelText: "頭銜"),
        ),
        SizedBox(height: 20),
        Row(
          children:[ 
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text("新增評審"),
            ),
            Spacer(),
            ElevatedButton(
              // style: ButtonStyle(),
              onPressed: (){Navigator.of(context).pop();},
              child: Text("取消"),
            ),
          ]
        ),
      ],
    );
  }
}