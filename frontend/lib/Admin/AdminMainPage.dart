// import 'package:carousel_slider/carousel_slider.dart';
import 'package:db_finalproject/ApiService.dart';
import 'package:db_finalproject/DataStruct.dart';
import 'package:db_finalproject/Sidebar.dart';
import 'package:flutter/material.dart';
import 'package:db_finalproject/Navbar.dart';
import 'package:db_finalproject/AuthProvider.dart';
import 'package:provider/provider.dart';

class AdminMainPage extends StatefulWidget{
  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage>{
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

                  SizedBox(height: 20),

                  AnnsCond(apiService: _apiService, screenWidth: screenWidth, rowheight: 30)

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
  TeamsStatus status=TeamsStatus(amounts: 0, approved: 0, notreview: 0, incomplete: 0, qualifying: 0, finalround: 0);
  List<TeamStruct> teams=[
    TeamStruct(teamid: "2024team001", teamname: "我們這一隊", workid: "2024work001",state: "待審核",consent: "1111"),
    TeamStruct(teamid: "2024team321", teamname: "你說都的隊", workid: "2024work001",state: "已補件",affidavit: "1111",consent: "1111"),
    TeamStruct(teamid: "2024team456", teamname: "對對隊", workid: "2024work001",state: "需補件",workintro: "1111"),
    TeamStruct(teamid: "2024team021", teamname: "不可能不隊", workid: "2024work001",state: "已審核",affidavit: "1111"),
    TeamStruct(teamid: "2024team091", teamname: "對啦隊", workid: "2024work001",state: "初賽隊伍",consent: "1111",workintro: "1111"),
    TeamStruct(teamid: "2024team102", teamname: "感覺對了就隊", workid: "2024work001",state: "決賽隊伍",workintro: "1111" ,consent: "1111",affidavit: "1111")
  ];
  
  Future<void> fetchstatus() async{
    try {
      status = await widget.apiService.getTeamsStatus();
      setState((){});
      // 更新 UI 或處理邏輯
      print('Fetched ${TeamsStatus} announcements');
    } catch (e) {
      print('Error: $e');
      setState((){
        status=TeamsStatus(amounts: 0, approved: 0, notreview: 0, incomplete: 0, qualifying: 0, finalround: 0);
      });
    }
  }

  Future<void> fetchBasicAllTeam() async{
    try {
      teams = await widget.apiService.getBasicAllTeam();
      setState((){});
      // 更新 UI 或處理邏輯
      print('Fetched ${teams} announcements');
    } catch (e) {
      print('Error: $e');
      //測試用資
      setState((){
        teams=[ TeamStruct(teamid: "2024team001", teamname: "我們這一隊", workid: "2024work001",state: "待審核",consent: "1111"),
                TeamStruct(teamid: "2024team321", teamname: "你說都的隊", workid: "2024work001",state: "已補件",affidavit: "1111",consent: "1111"),
                TeamStruct(teamid: "2024team456", teamname: "對對隊", workid: "2024work001",state: "需補件",workintro: "1111"),
                TeamStruct(teamid: "2024team021", teamname: "不可能不隊", workid: "2024work001",state: "已審核",affidavit: "1111"),
                TeamStruct(teamid: "2024team091", teamname: "對啦隊", workid: "2024work001",state: "初賽隊伍",consent: "1111",workintro: "1111"),
                TeamStruct(teamid: "2024team102", teamname: "感覺對了就隊", workid: "2024work001",state: "決賽隊伍",workintro: "1111" ,consent: "1111",affidavit: "1111")
                ];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // fetchstatus();
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
                  Row(
                    children: [
                      Text(
                        "隊伍管理",
                        style:  TextStyle(
                          fontSize:24
                        ),
                      ),
                      SizedBox(width: 50,),
                      Container(
                        height: 30,
                        width:100,
                        padding: EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade600),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text(
                          "已報名：${status.amounts}",
                          textAlign: TextAlign.center,
                        )
                      ),
                      SizedBox(width: 20,),
                      Container(
                        height: 30,
                        width:100,
                        padding: EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.shade200,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text(
                          "已審核：${status.amounts}",
                          textAlign: TextAlign.center,
                        )
                      ),
                      SizedBox(width: 20,),
                      Container(
                        height: 30,
                        width:100,
                        padding: EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text(
                          "待審核：${status.amounts}",
                          textAlign: TextAlign.center,
                        )
                      ),
                      SizedBox(width: 20,),
                      Container(
                        height: 30,
                        width:100,
                        padding: EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.shade200,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text(
                          "需補件：${status.amounts}",
                          textAlign: TextAlign.center,
                        )
                      ),
                      SizedBox(width: 20,),
                      Container(
                        height: 30,
                        width:100,
                        padding: EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade200,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text(
                          "已補件：${status.amounts}",
                          textAlign: TextAlign.center,
                        )
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                Table(
                  border: TableBorder(
                    top: BorderSide(color: Colors.grey ),
                    bottom: BorderSide(color: Colors.grey ),
                    horizontalInside: BorderSide(color: Colors.grey ),
                    verticalInside: BorderSide.none,
                    right: BorderSide.none,
                    left:BorderSide.none
                  ),
                  columnWidths: {
                    0: FlexColumnWidth(1.5),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                    4: FlexColumnWidth(1),
                    5: FlexColumnWidth(1)
                  },
                  children:[
                      TableRow(
                        children: <Widget>[
                          Container(
                            height: widget.rowheight,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              "隊伍ID",
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            height: widget.rowheight,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "隊伍名稱",
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            height: widget.rowheight,
                            alignment: Alignment.center,
                            child: Text(
                              "作品說明書",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: widget.rowheight,
                            alignment: Alignment.center,
                            child: Text(
                              "切結書",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: widget.rowheight,
                            alignment: Alignment.center,
                            child: Text(
                              "同意書",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: widget.rowheight,
                            alignment: Alignment.center,
                            child: Text(
                              "報名狀態",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ]
                  ),
                  SizedBox(height: 5),
                  teams.isEmpty? Center(child: CircularProgressIndicator()):
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
                      0: FlexColumnWidth(1.5),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(1),
                      5: FlexColumnWidth(1)
                    },
                    children: teams.map((item)=>TableRow(
                      children: [
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 15),
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
                          // padding: EdgeInsets.only(top: 5),
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
                              style: TextStyle(
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
                              style: TextStyle(
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
                              style: TextStyle(
                                fontSize: 12
                              ),
                            ),
                          )
                        ),
                        InkWell(
                          onTap: () {
                          print(item.teamid);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => AnnDetailPage(AnnID: item.id),
                          //   ),
                          // );

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

class AnnsCond extends StatefulWidget{
  ApiService apiService;
  double screenWidth;
  double rowheight;
  AnnsCond({required this.apiService,required this.screenWidth,required this.rowheight});

  @override
  State<AnnsCond> createState() => _AnnsCondState();
}

class _AnnsCondState extends State<AnnsCond> {
  List<AnnStruct> Anns=[AnnStruct(id: 5, date: "2024-12-01 23:15:03", title: "1234654897",imgamount: "0",fileamount: "0")];

  Future<void> fetchAnnDetails() async {
    try {
      Anns = await widget.apiService.getAnnBasic();
      setState((){});
      // 更新 UI 或處理邏輯
      print('Fetched ${Anns} announcements');
    } catch (e) {
      print('Error: $e');
      //測試用資
      setState((){
        Anns = [
          AnnStruct(id: 5, date: "2024-12-01 23:15:03", title: "1234654897",imgamount: "0",fileamount: "0")
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
                  Text(
                    "公告管理",
                    style:  TextStyle(
                      fontSize:20 
                    ),
                  ),
                  SizedBox(height: 20),
                  Table(
                    border: TableBorder(
                      top: BorderSide(color: Colors.grey ),
                      bottom: BorderSide(color: Colors.grey ),
                      horizontalInside: BorderSide(color: Colors.grey ),
                      verticalInside: BorderSide.none,
                      right:BorderSide.none,
                      left:BorderSide.none
                    ),
                    columnWidths: {
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
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "公告ID",
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              height: widget.rowheight,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "公告標題",
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              height: widget.rowheight,
                              alignment: Alignment.center,
                              child: Text(
                                "照片數量",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: widget.rowheight,
                              alignment: Alignment.center,
                              child: Text(
                                "檔案數量",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: widget.rowheight,
                              alignment: Alignment.center,
                              child: Text(
                                "最後更改時間",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: widget.rowheight,
                              alignment: Alignment.center,
                              child: Text(
                                "點擊編輯",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ]
                  ),
                  SizedBox(height: 5),
                  Anns.isEmpty? Center(child: CircularProgressIndicator()):
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
                          padding: EdgeInsets.only(left: 15),
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
                              style: TextStyle(
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
                              style: TextStyle(
                                fontSize: 12
                              ),
                            ),
                          )
                        ),
                        Container(
                          height: widget.rowheight,
                          alignment: Alignment.center,
                          child: Text(
                            item.date,
                            textAlign: TextAlign.left,
                          ),
                        ),  
                        InkWell(
                          onTap: () {
                          print(item.id);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => AnnDetailPage(AnnID: item.id),
                          //   ),
                          // );

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
                              child: Text(
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