// import 'package:carousel_slider/carousel_slider.dart';
import 'package:db_finalproject/core/services/ApiService.dart';
import 'package:db_finalproject/data/Team.dart';
import 'package:db_finalproject/student/data/Student.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'package:flutter/material.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:provider/provider.dart';

class StuMainPage extends StatefulWidget{
  @override
  State<StuMainPage> createState() => _StuMainPageState();
}

class _StuMainPageState extends State<StuMainPage>{
  @override
  Widget build(BuildContext context){
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Navbar(),
      body:Stack(
        
        children:
        [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: authProvider.isSidebarOpen ? 250 : 0),
            child: Dashboard()
          ),
          Sidebar()
        ]
      )
    );
  }
}
class Dashboard extends StatefulWidget{
  
  @override
  State<Dashboard> createState() =>_DashboardState();
}

class _DashboardState extends State<Dashboard>{
  ApiService _apiService = ApiService();
 
  @override
  Widget build(BuildContext context){
    final scrSize = MediaQuery.of(context).size;
    final double screenWidth = scrSize.width-250;
    bool iswidthful = screenWidth > 1000 ? true : false;
    return SingleChildScrollView(
      child:SafeArea(
          child: Row(
            children: [

              if(iswidthful)
                Flexible(flex: 1, child: Container(color: Colors.transparent)),
              
              Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 20)),

                  TeamsCond(apiService: _apiService,rowheight: 30,screenWidth: screenWidth),

                  // Padding(padding: EdgeInsets.only(top: 20)),

                  // SizedBox(
                  //   width:iswidthful?1000:screenWidth,
                  //   child: LatestAnn(),
                  // )

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
  ApiService apiService;
  double rowheight;
  double screenWidth;
  TeamsCond({required this.apiService, required this.rowheight ,required this.screenWidth});
  @override
  State<TeamsCond> createState() => _TeamsCondState();
}

class _TeamsCondState extends State<TeamsCond>{
  List<Student> teammember=[
    Student(id: "A1103336", name: "王曉明", email: "A1103336@mail.nuk.edu.tw", sexual: "男", phone: "0925111222", major: "資訊管理學系", grade: "大四",isLeader: true),
    Student(id: "A1113302", name: "許雅婷", email: "A1113302@mail.nuk.edu.tw", sexual: "女", phone: "0919333444", major: "資訊管理學系", grade: "大三"),
    Student(id: "A1113311", name: "廖陳祥", email: "A1113311@mail.nuk.edu.tw", sexual: "男", phone: "0935666555", major: "資訊管理學系", grade: "大三"),
    Student(id: "A1123328", name: "張暄予", email: "A1123328@mail.nuk.edu.tw", sexual: "女", phone: "0978654852", major: "資訊管理學系", grade: "大二"),
  ];
  String i="hi";
  Team team=Team(
    teamid: "2024team001", 
    teamname: "我們這一隊", 
    teamtype: "創意發想",
    workid: "2024work001",
    state: "待審核",
    consent: "1111",
    worksummary: "鴉鴉鴉鴉鴉鴉",
    );

  /*Future<void> fetchBasicAllTeam() async{
    try {
      teams = await widget.apiService.getBasicAllTeam();
      setState((){});
      // 更新 UI 或處理邏輯
      print('Fetched ${teams} announcements');
    } catch (e) {
      print('Error: $e');
      //測試用資
      setState((){
        teams=[ Team(teamid: "2024team001", teamname: "我們這一隊", workid: "2024work001",state: "待審核",consent: "1111"),
                Team(teamid: "2024team321", teamname: "你說都的隊", workid: "2024work001",state: "已補件",affidavit: "1111",consent: "1111"),
                Team(teamid: "2024team456", teamname: "對對隊", workid: "2024work001",state: "需補件",workintro: "1111"),
                Team(teamid: "2024team021", teamname: "不可能不隊", workid: "2024work001",state: "已審核",affidavit: "1111"),
                Team(teamid: "2024team091", teamname: "對啦隊", workid: "2024work001",state: "初賽隊伍",consent: "1111",workintro: "1111"),
                Team(teamid: "2024team102", teamname: "感覺對了就隊", workid: "2024work001",state: "決賽隊伍",workintro: "1111" ,consent: "1111",affidavit: "1111")
                ];
      });
    }
  } */

  @override
  void initState() {
    super.initState();
    // fetchBasicAllTeam();
  }

  @override
  Widget build(BuildContext context){
    return 
          Container(
            width: widget.screenWidth>1000?1000:widget.screenWidth*0.9,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20)
            ),
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 15,left: 20,right: 20),
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
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        "隊伍ID：2024team321",
                        style:  TextStyle(
                          fontSize:16
                        )
                      ),
                      Spacer(),
                      Text(
                        "隊伍名稱：對拉對",
                        style:  TextStyle(
                          fontSize:16
                        )
                      ),
                      Spacer(),
                      Container(
                        height: widget.rowheight,
                        alignment: Alignment.center,
                        child: Container(
                          height: 30,
                          width: 100,
                          padding: EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            color: team.state == "待審核" ? Colors.grey.shade300 :
                                    team.state == "已審核" ? Colors.green.shade200 :
                                    team.state == "需補件" ? Colors.red.shade200 :
                                    team.state == "已補件" ? Colors.orange.shade200 :
                                    team.state == "初賽隊伍" ? Colors.blue.shade200 :
                                    team.state == "決賽隊伍" ? Colors.blue.shade400 :
                                    Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            team.state!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                        )
                      ),
                      Spacer()
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Text("隊員序號")
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text("姓名"),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text("學號"),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text("系所"),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text("性別",textAlign: TextAlign.center,),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text("電話號碼"),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text("電子郵件"),
                        ),

                      ],
                    ),
                  teammember.isEmpty? Center(child: CircularProgressIndicator()):
                  Table(
                    border: TableBorder(
                      top: BorderSide(color: Colors.grey ),
                      bottom: BorderSide(color: Colors.grey ),
                      horizontalInside: BorderSide(color: Colors.grey ),
                      verticalInside: BorderSide.none,
                      right: BorderSide.none,
                      left: BorderSide.none
                    ),
                    columnWidths: {
                      0: FlexColumnWidth(4),
                      1: FlexColumnWidth(4),
                      2: FlexColumnWidth(4),
                      3: FlexColumnWidth(4),
                      4: FlexColumnWidth(2),
                      5: FlexColumnWidth(4),
                      6: FlexColumnWidth(8)
                    },
                    children: teammember.asMap().entries.map((entry){
                      int index = entry.key;
                      Student item = entry.value;
                      return TableRow(
                      children: [
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 15),
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
                  SizedBox(height: 30,),
                  Row(
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
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Spacer(),
                      Text("作品說明書："),
                      Container(
                        height: widget.rowheight,
                        alignment: Alignment.center,
                        // padding: EdgeInsets.only(top: 5),
                        child: Container(
                          height: 20,
                          width: 70,
                          decoration: BoxDecoration(
                            color: team.workintro == null ? Colors.grey.shade300:Colors.green.shade200,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            team.workintro == null? "未上傳":"已上傳",
                            textAlign: TextAlign.center,
                          ),
                        )
                      ),
                      Spacer(),
                      Text("切結書："),
                      Container(
                        height: widget.rowheight,
                        alignment: Alignment.center,
                        // padding: EdgeInsets.only(top: 5),
                        child: Container(
                          height: 20,
                          width: 70,
                          decoration: BoxDecoration(
                            color: team.affidavit == null ? Colors.grey.shade300:Colors.green.shade200,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            team.affidavit == null? "未上傳":"已上傳",
                            textAlign: TextAlign.center,
                          ),
                        )
                      ),
                      Spacer(),
                      Text("同意書："),
                      Container(
                        height: widget.rowheight,
                        alignment: Alignment.center,
                        // padding: EdgeInsets.only(top: 5),
                        child: Container(
                          height: 20,
                          width: 70,
                          decoration: BoxDecoration(
                            color: team.consent == null ? Colors.grey.shade300:Colors.green.shade200,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            team.consent == null? "未上傳":"已上傳",
                            textAlign: TextAlign.center,
                          ),
                        )
                      ),
                      Spacer()

                    ],
                  )
                ],
              )
            ),
          );
  }
}
