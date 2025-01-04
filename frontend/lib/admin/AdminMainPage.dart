import 'package:db_finalproject/admin/logic/TeamsStatusService.dart';
import 'package:db_finalproject/data/Announcement.dart';
import 'package:db_finalproject/data/TeamsStatus.dart';
import 'package:db_finalproject/data/Team.dart';
import 'package:db_finalproject/common/logic/AnnouncementService.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'package:flutter/material.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/admin/logic/AdminTeamService.dart';
import 'dart:html' as html;

class AdminMainPage extends StatefulWidget{
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage>{
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
            child: const Dashboard()
          ),
          Sidebar()
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

                  const SizedBox(height: 20),

                  AnnsCond(screenWidth: screenWidth, rowheight: 30)

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
  final TeamsStatusService _teamsStatusService = TeamsStatusService();
  final AdminTeamService _adminTeamService = AdminTeamService();
  final double rowheight;
  final double screenWidth;
  TeamsCond({super.key, required this.rowheight ,required this.screenWidth});
  @override
  State<TeamsCond> createState() => _TeamsCondState();
}

class _TeamsCondState extends State<TeamsCond>{
  TeamsStatus status=TeamsStatus(amounts: 0, approved: 0, notreview: 0, incomplete: 0, solved: 0);
  List<Team> teams=[
    Team(teamid: "2024team001", teamname: "我們這一隊", workid: "2024work001", teamtype: "創意實作",state: "待審核",consent: "1111"),
    Team(teamid: "2024team321", teamname: "你說都的隊", workid: "2024work001", teamtype: "創意實作",state: "已補件",affidavit: "1111",consent: "1111"),
    Team(teamid: "2024team456", teamname: "對對隊", workid: "2024work001", teamtype: "創意實作",state: "需補件",workintro: "1111"),
    Team(teamid: "2024team021", teamname: "不可能不隊", workid: "2024work001", teamtype: "創意實作",state: "已審核",affidavit: "1111"),
    Team(teamid: "2024team091", teamname: "對啦隊", workid: "2024work001", teamtype: "創意實作",state: "初賽隊伍",consent: "1111",workintro: "1111"),
    Team(teamid: "2024team102", teamname: "感覺對了就隊", workid: "2024work001", teamtype: "創意實作",state: "決賽隊伍",workintro: "1111" ,consent: "1111",affidavit: "1111")
  ];
  
  Future<void> fetchstatus() async{
    try {
      status = await widget._teamsStatusService.getTeamsStatus();
      setState((){});
    } catch (e) {
      print('Error: $e');
      setState((){
        status=TeamsStatus(amounts: 0, approved: 0, notreview: 0, incomplete: 0, solved: 0);
      });
    }
  }

  Future<void> fetchBasicAllTeam() async{
    try {
      teams = await widget._adminTeamService.getBasicAllTeam();
      setState((){});
    } catch (e) {
      print('Error: $e');
      // 測試用資
      setState((){
        teams=[ Team(teamid: "2024team001", teamname: "我們這一隊", workid: "2024work001", teamtype: "創意實作",state: "待審核",consent: "1111"),
                Team(teamid: "2024team321", teamname: "你說都的隊", workid: "2024work001", teamtype: "創意實作",state: "已補件",affidavit: "1111",consent: "1111"),
                Team(teamid: "2024team456", teamname: "對對隊", workid: "2024work001", teamtype: "創意實作",state: "需補件",workintro: "1111"),
                Team(teamid: "2024team021", teamname: "不可能不隊", workid: "2024work001", teamtype: "創意實作",state: "已審核",affidavit: "1111"),
                Team(teamid: "2024team091", teamname: "對啦隊", workid: "2024work001", teamtype: "創意實作",state: "初賽隊伍",consent: "1111",workintro: "1111"),
                Team(teamid: "2024team102", teamname: "感覺對了就隊", workid: "2024work001", teamtype: "創意實作",state: "決賽隊伍",workintro: "1111" ,consent: "1111",affidavit: "1111")
                ];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchstatus();
    fetchBasicAllTeam();
  }

  @override
  Widget build(BuildContext context){
    return 
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
                  Row(
                    children: [
                      const Text(
                        "隊伍管理",
                        style:  TextStyle(
                          fontSize:24
                        ),
                      ),
                      const SizedBox(width: 50,),
                      Container(
                        height: 30,
                        width:100,
                        padding: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade600),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text(
                          "已報名：${status.amounts}",
                          textAlign: TextAlign.center,
                        )
                      ),
                      const SizedBox(width: 20,),
                      Container(
                        height: 30,
                        width:100,
                        padding: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.shade200,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text(
                          "已審核：${status.solved}",
                          textAlign: TextAlign.center,
                        )
                      ),
                      const SizedBox(width: 20,),
                      Container(
                        height: 30,
                        width:100,
                        padding: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text(
                          "待審核：${status.solved}",
                          textAlign: TextAlign.center,
                        )
                      ),
                      const SizedBox(width: 20,),
                      Container(
                        height: 30,
                        width:100,
                        padding: const  EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.shade200,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text(
                          "需補件：${status.solved}",
                          textAlign: TextAlign.center,
                        )
                      ),
                      const SizedBox(width: 20,),
                      Container(
                        height: 30,
                        width:100,
                        padding: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade200,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text(
                          "已補件：${status.solved}",
                          textAlign: TextAlign.center,
                        )
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  teams.isEmpty? const Center(child: CircularProgressIndicator()):
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
                      0: FlexColumnWidth(1.5),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(1),
                      5: FlexColumnWidth(1)
                    },
                    children: [
                      TableRow(
                        children: <Widget>[
                          Container(
                            height: widget.rowheight,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 15),
                            child: const Text(
                              "隊伍ID",
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            height: widget.rowheight,
                            alignment: Alignment.centerLeft,
                            child: const  Text(
                              "隊伍名稱",
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            height: widget.rowheight,
                            alignment: Alignment.center,
                            child: const  Text(
                              "作品說明書",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: widget.rowheight,
                            alignment: Alignment.center,
                            child: const  Text(
                              "切結書",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: widget.rowheight,
                            alignment: Alignment.center,
                            child: const  Text(
                              "同意書",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: widget.rowheight,
                            alignment: Alignment.center,
                            child: const  Text(
                              "報名狀態",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),...teams.map((item)=>TableRow(
                      children: [
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.centerLeft,
                          padding: const  EdgeInsets.only(left: 15),
                          child: Text(
                            item.teamid,
                            textAlign: TextAlign.left,
                          ),
                        ),  
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.teamname,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.center,
                          child: Container(
                            height: 20,
                            width: 70,
                            decoration: BoxDecoration(
                              color: item.workintro == null ? Colors.grey.shade300:Colors.green.shade200,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Text(
                              item.workintro == null? "未上傳":"已上傳",
                              textAlign: TextAlign.center,
                              style: const  TextStyle(
                                fontSize: 12
                              ),
                            ),
                          )
                        ),
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.center,
                          // padding: EdgeInsets.only(top: 5),
                          child: Container(
                            height: 20,
                            width: 70,
                            decoration: BoxDecoration(
                              color: item.consent == null ? Colors.grey.shade300:Colors.green.shade200,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Text(
                              item.consent == null? "未上傳":"已上傳",
                              textAlign: TextAlign.center,
                              style: const  TextStyle(
                                fontSize: 12
                              ),
                            ),
                          )
                        ),
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.center,
                          // padding: EdgeInsets.only(top: 5),
                          child: Container(
                            height: 20,
                            width: 70,
                            decoration: BoxDecoration(
                              color: item.affidavit == null ? Colors.grey.shade300:Colors.green.shade200,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Text(
                              item.affidavit == null? "未上傳":"已上傳",
                              textAlign: TextAlign.center,
                              style: const  TextStyle(
                                fontSize: 12
                              ),
                            ),
                          )
                        ),
                        InkWell(
                          onTap: () {
                            html.window.open(
                              '/#/team/review?teamid=${item.teamid}', // 新視窗的網址
                              'reviewTeam',      // 視窗名稱（用於管理視窗實例）
                              'width=1000,height=720,left=200,top=100', // 視窗屬性
                            );
                          } ,
                          child: Container(
                            height: widget.rowheight,
                            alignment: Alignment.center,
                            child: Container(
                              height: 20,
                              width: 70,
                              decoration: BoxDecoration(
                                color: item.state == "待審核" ? Colors.grey.shade300 :
                                       item.state == "已審核" ? Colors.green.shade200 :
                                       item.state == "需補件" ? Colors.red.shade200 :
                                       item.state == "已補件" ? Colors.orange.shade200 :
                                       item.state == "初賽隊伍" ? Colors.blue.shade200 :
                                       item.state == "決賽隊伍" ? Colors.blue.shade400 :
                                       Colors.white,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Text(
                                item.state!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12
                                ),
                              ),
                            )
                          ),
                        ),
                      ]
                    ))
                    ]
                  )
                ],
              )
            ),
          );
  }
}

class AnnsCond extends StatefulWidget{
  final AnnouncementService _announcementService = AnnouncementService();
  final double screenWidth;
  final double rowheight;
  AnnsCond({super.key, required this.screenWidth,required this.rowheight});

  @override
  State<AnnsCond> createState() => _AnnsCondState();
}

class _AnnsCondState extends State<AnnsCond> {
  List<Announcement> Anns=[Announcement(id: 5, date: "2024-12-01 23:15:03", title: "1234654897",imgamount: "0",fileamount: "0")];

  Future<void> fetchAnnDetails() async {
    try {
      Anns = await widget._announcementService.getBasicAnnouncement();
      setState((){});
    } catch (e) {
      print('Error: $e');
      //測試用資
      setState((){
        Anns = [
          Announcement(id: 5, date: "2024-12-01 23:15:03", title: "1234654897",imgamount: "0",fileamount: "0")
        ];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // fetchAnnDetails();
  }


  @override
  Widget build(BuildContext context){
    return Container(
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
                  const Text(
                    "公告管理",
                    style:  TextStyle(
                      fontSize:20 
                    ),
                  ),
                  const SizedBox(height: 20),
                  Table(
                    border: const TableBorder(
                      top: BorderSide(color: Colors.grey ),
                      bottom: BorderSide(color: Colors.grey ),
                      horizontalInside: BorderSide(color: Colors.grey ),
                      verticalInside: BorderSide.none,
                      right:BorderSide.none,
                      left:BorderSide.none
                    ),
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(4.5),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(1.5),
                      5: FlexColumnWidth(1)
                    },
                    children:[
                        TableRow(
                          children: <Widget>[
                            Container(
                              height: widget.rowheight,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              child: const Text(
                                "公告ID",
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              height: widget.rowheight,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "公告標題",
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              height: widget.rowheight,
                              alignment: Alignment.center,
                              child: const Text(
                                "照片數量",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: widget.rowheight,
                              alignment: Alignment.center,
                              child: const Text(
                                "檔案數量",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: widget.rowheight,
                              alignment: Alignment.center,
                              child: const Text(
                                "最後更改時間",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: widget.rowheight,
                              alignment: Alignment.center,
                              child: const Text(
                                "點擊編輯",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ]
                  ),
                  const SizedBox(height: 5),
                  Anns.isEmpty? const Center(child: CircularProgressIndicator()):
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
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(4.5),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(1.5),
                      5: FlexColumnWidth(1)
                    },
                    children: Anns.map((item)=>TableRow(
                      children: [
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "${item.id}",
                            textAlign: TextAlign.left,
                          ),
                        ),  
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.title,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.center,
                          // padding: EdgeInsets.only(top: 5),
                          child: Container(
                            height: 20,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Text(
                              item.imgamount!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12
                              ),
                            ),
                          )
                        ),
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.center,
                          // padding: EdgeInsets.only(top: 5),
                          child: Container(
                            height: 20,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Text(
                              item.fileamount!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12
                              ),
                            ),
                          )
                        ),
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.center,
                          child: Text(
                            item.date!,
                            textAlign: TextAlign.left,
                          ),
                        ),  
                        InkWell(
                          onTap: () {
                            html.window.open(
                                '/#/ann/add&edit?annid=${item.id}', // 新視窗的網址
                                'AddAnnouncement',      // 視窗名稱（用於管理視窗實例）
                                'width=1000,height=720,left=200,top=100', // 視窗屬性
                              );
                          } ,
                          child: Container(
                            height: widget.rowheight,
                            alignment: Alignment.center,
                            child: Container(
                              height: 20,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300 ,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: const Text(
                                "編輯",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12
                                ),
                              ),
                            )
                          ),
                        ),
                      ]
                    )).toList(),
                  )
                ],
              )
            ),
          );
  }
}