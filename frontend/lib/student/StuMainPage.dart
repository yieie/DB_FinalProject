import 'package:db_finalproject/data/Teacher.dart';
import 'package:db_finalproject/data/Team.dart';
import 'package:db_finalproject/data/Student.dart';
import 'package:db_finalproject/student/logic/SutTeamService.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'package:flutter/material.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/admin/logic/AdminTeamService.dart';
import 'dart:html' as html;

class StuMainPage extends StatefulWidget{
  const StuMainPage({super.key});
  @override
  State<StuMainPage> createState() => _StuMainPageState();
}

class _StuMainPageState extends State<StuMainPage>{
  @override
  Widget build(BuildContext context){
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Navbar(),
      body:Stack(
        
        children:
        [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: authProvider.isSidebarOpen ? 250 : 0),
            child:const  Dashboard()
          ),
          const Sidebar()
        ]
      )
    );
  }
}
class Dashboard extends StatefulWidget{
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() =>_DashboardState();
}

class _DashboardState extends State<Dashboard>{
 
  @override
  Widget build(BuildContext context){
    final scrSize = MediaQuery.of(context).size;
    final double screenWidth = scrSize.width-250;
    bool iswidthful = screenWidth > 850 ? true : false;
    return SingleChildScrollView(
      child:SafeArea(
          child: Row(
            children: [

              if(iswidthful)
                Flexible(flex: 1, child: Container(color: Colors.transparent)),
              
              Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 20)),

                  TeamsCond(rowheight: 30,screenWidth: screenWidth),

                ],
              ),
              

              if(iswidthful)
                Flexible(flex: 1, child: Container(color: Colors.transparent)),
            ],
          )
      )
    );

  }
}

class TeamsCond extends StatefulWidget{
  final double rowheight;
  final double screenWidth;
  const TeamsCond({super.key, required this.rowheight ,required this.screenWidth});
  @override
  State<TeamsCond> createState() => _TeamsCondState();
}

class _TeamsCondState extends State<TeamsCond>{
  List<Student> stu=[];
  String i="hi";
  Team? team;
  Teacher? tr;
  String teamid='';
  final StuTeamService _stuTeamService = StuTeamService();
  final AdminTeamService _adminTeamService = AdminTeamService();

  Future<void> fetchStuTeamId(String stuid) async{
    try{
      teamid=await _stuTeamService.getStudentTeamId(stuid);
      setState(() {});
    }catch(e){
      print(e);
    }
  }

  Future<void> fectchteamdetail() async{
    try{
      team= await _adminTeamService.getDetailTeam(teamid);
      stu = await _adminTeamService.getTeamStudent(teamid); 
      if(team!.teacheremail != null){
        tr = await _adminTeamService.getTeamTeacher(team!.teacheremail!);
      }
      setState(() {});
    }
    catch(e){
      print('error:$e');
      setState(() {
        team= Team(teamid: '2024team001', teamname: '我們這一對', teamtype: '創意實作組',state: '報名待審核',worksummary: '你好我哈囉刮刮刮\n刮刮刮刮刮',teacheremail: "dijfi@gmail.com",worksdgs: '1,2,5',workyturl: 'https://www.google.com/');
      stu=[
        Student(id: 'A1105546', name: '王大明', email: 'a1105546@mail.nuk.edu.tw', sexual: '男', phone: '0933556456', major: '資訊工程系', grade: '大四'),
        Student(id: 'A1113324', name: '陳曉慧', email: 'a1113324@mail.nuk.edu.tw', sexual: '女', phone: '0955777888', major: '資訊管理系', grade: '大三'),
        Student(id: 'A1124477', name: '呂又亮', email: 'a1124477@mail.nuk.edu.tw', sexual: '男', phone: '0933145346', major: '哈哈哈哈系', grade: '大二'),
      ];
      tr =Teacher(id: 'dijfi@gmail.com', name: '張大業', email: 'dijfi@gmail.com', sexual: '男', phone: '0966444888');
        
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.usertype == 'stu' && authProvider.useraccount != 'none') {
        fetchStuTeamId(authProvider.useraccount);
      }  
    });
    if(teamid.contains('team')){
      fectchteamdetail();
    }
  }

  @override
  Widget build(BuildContext context){
    final authProvider = Provider.of<AuthProvider>(context);
    return (teamid == '無' || teamid == '')? 
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
    )
    :
          Container(
            width: widget.screenWidth>850?850:widget.screenWidth*0.9,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20)
            ),
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(top: 15,left: 20,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        "隊伍管理",
                        style:  TextStyle(
                          fontSize:24
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      const Spacer(),
                      const Text(
                        "隊伍ID：2024team321",
                        style:  TextStyle(
                          fontSize:16
                        )
                      ),
                      const Spacer(),
                      const Text(
                        "隊伍名稱：對拉對",
                        style:  TextStyle(
                          fontSize:16
                        )
                      ),
                      const Spacer(),
                      Container(
                        height: widget.rowheight,
                        alignment: Alignment.center,
                        child: Container(
                          height: 30,
                          width: 100,
                          padding: const EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            color: team!.state == "待審核" ? Colors.grey.shade300 :
                                    team!.state == "已審核" ? Colors.green.shade200 :
                                    team!.state == "需補件" ? Colors.red.shade200 :
                                    team!.state == "已補件" ? Colors.orange.shade200 :
                                    team!.state == "初賽隊伍" ? Colors.blue.shade200 :
                                    team!.state == "決賽隊伍" ? Colors.blue.shade400 :
                                    Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            team!.state!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16
                            ),
                          ),
                        )
                      ),
                      const Spacer()
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: const EdgeInsets.only(left: 15),
                            child: const Text("隊員序號")
                          ),
                        ),
                        const Expanded(
                          flex: 4,
                          child: Text("姓名"),
                        ),
                        const Expanded(
                          flex: 4,
                          child: Text("學號"),
                        ),
                        const Expanded(
                          flex: 4,
                          child: Text("系所"),
                        ),
                        const Expanded(
                          flex: 2,
                          child: Text("性別",textAlign: TextAlign.center,),
                        ),
                        const Expanded(
                          flex: 4,
                          child: Text("電話號碼"),
                        ),
                        const Expanded(
                          flex: 8,
                          child: Text("電子郵件"),
                        ),

                      ],
                    ),
                  stu!.isEmpty? const Center(child: CircularProgressIndicator()):
                  Table(
                    border: const TableBorder(
                      top: BorderSide(color: Colors.grey ),
                      bottom: BorderSide(color: Colors.grey ),
                      horizontalInside: BorderSide(color: Colors.grey ),
                      verticalInside: BorderSide.none,
                      right: BorderSide.none,
                      left: BorderSide.none
                    ),
                    columnWidths: const {
                      0: FlexColumnWidth(4),
                      1: FlexColumnWidth(4),
                      2: FlexColumnWidth(4),
                      3: FlexColumnWidth(4),
                      4: FlexColumnWidth(2),
                      5: FlexColumnWidth(4),
                      6: FlexColumnWidth(8)
                    },
                    children: stu.asMap().entries.map((entry){
                      int index = entry.key;
                      Student item = entry.value;
                      return TableRow(
                      children: [
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            index==0?"隊員1-代表人":"隊員${index+1}",
                            textAlign: TextAlign.left,
                          ),
                        ),  
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.name,
                            textAlign: TextAlign.left,
                          ),
                        ),  
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.id,
                            textAlign: TextAlign.left,
                          ),
                        ),  
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.major,
                            textAlign: TextAlign.left,
                          ),
                        ),  
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.center,
                          child: Text(
                            item.sexual,
                            textAlign: TextAlign.center,
                          ),
                        ),  
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.phone,
                            textAlign: TextAlign.left,
                          ),
                        ),  
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.email,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ]
                    );
                    }).toList(),
                  ),
                  const SizedBox(height: 30,),
                  const Row(
                    children: [
                      Spacer(),
                      Text(
                        "作品ID：2024work321",
                        style:  TextStyle(
                          fontSize:16
                        )
                      ),
                      Spacer(),
                      Text(
                        "作品名稱：智慧型監測系統",
                        style:  TextStyle(
                          fontSize:16
                        )
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Spacer(),
                      const Text("作品說明書："),
                      Container(
                        height: widget.rowheight,
                        alignment: Alignment.center,
                        // padding: EdgeInsets.only(top: 5),
                        child: Container(
                          height: 20,
                          width: 70,
                          decoration: BoxDecoration(
                            color: team!.workintro == null ? Colors.grey.shade300:Colors.green.shade200,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            team!.workintro == null? "未上傳":"已上傳",
                            textAlign: TextAlign.center,
                          ),
                        )
                      ),
                      const Spacer(),
                      const Text("切結書："),
                      Container(
                        height: widget.rowheight,
                        alignment: Alignment.center,
                        // padding: EdgeInsets.only(top: 5),
                        child: Container(
                          height: 20,
                          width: 70,
                          decoration: BoxDecoration(
                            color: team!.affidavit == null ? Colors.grey.shade300:Colors.green.shade200,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            team!.affidavit == null? "未上傳":"已上傳",
                            textAlign: TextAlign.center,
                          ),
                        )
                      ),
                      const Spacer(),
                      const Text("同意書："),
                      Container(
                        height: widget.rowheight,
                        alignment: Alignment.center,
                        // padding: EdgeInsets.only(top: 5),
                        child: Container(
                          height: 20,
                          width: 70,
                          decoration: BoxDecoration(
                            color: team!.consent == null ? Colors.grey.shade300:Colors.green.shade200,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            team!.consent == null? "未上傳":"已上傳",
                            textAlign: TextAlign.center,
                          ),
                        )
                      ),
                      const Spacer()
                    ],
                  )
                ],
              )
            ),
          );
  }
}
