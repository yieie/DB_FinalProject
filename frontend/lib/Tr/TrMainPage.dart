// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../Navbar.dart';
import 'package:db_finalproject/ApiService.dart';
import 'package:db_finalproject/DataStruct.dart';
import 'package:db_finalproject/AuthProvider.dart';
import 'package:provider/provider.dart';
// import '../Drawer.dart';

class TrMainPage extends StatefulWidget {
  @override
  State<TrMainPage> createState() => _TrMainPageState();
}

class _TrMainPageState extends State<TrMainPage> {
  ApiService _apiService = ApiService();
  List<TeamStruct> teacherTeams = [];

  Future<void> fetchTeacherTeams() async {
    try {
      teacherTeams = await _apiService.getBasicAllTeam();
      setState(() {});
    } catch (e) {
      print('Error: $e');
      // 測試用數據
      setState(() {
        teacherTeams = [
          TeamStruct(teamid: "2024team001", teamname: "隊伍 A", state: "待審核", workid: "work001", workname: "作品 A", worksummary: "作品簡介 A"),
          TeamStruct(teamid: "2024team002", teamname: "隊伍 B", state: "已審核", workid: "work002", workname: "作品 B", worksummary: "作品簡介 B"),
          TeamStruct(teamid: "2024team003", teamname: "隊伍 C", state: "需補件", workid: "work003", workname: "作品 C", worksummary: "作品簡介 C"),
          TeamStruct(teamid: "2024team004", teamname: "隊伍 D", state: "已補件", workid: "work004", workname: "作品 D", worksummary: "作品簡介 D"),
          TeamStruct(teamid: "2024team005", teamname: "隊伍 E", state: "初賽隊伍", workid: "work005", workname: "作品 E", worksummary: "作品簡介 E"),
          TeamStruct(teamid: "2024team006", teamname: "隊伍 F", state: "決賽隊伍", workid: "work006", workname: "作品 F", worksummary: "作品簡介 F"),
        ];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTeacherTeams();
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
            child: Dashboard(teacherTeams: teacherTeams),
          ),
        ],
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  final List<TeamStruct> teacherTeams;

  Dashboard({required this.teacherTeams});

  @override
  Widget build(BuildContext context) {
    final scrSize = MediaQuery.of(context).size;
    final double screenWidth = scrSize.width - 250;
    bool iswidthful = screenWidth > 1000;

    return SingleChildScrollView(
      child: SafeArea(
        child: Row(
          children: [
            if (iswidthful)
              Flexible(flex: 1, child: Container(color: Colors.transparent)),
            Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 20)),
                TeacherTeamsList(
                  teacherTeams: teacherTeams,
                  rowheight: 30,
                  screenWidth: screenWidth,
                ),
              ],
            ),
            if (iswidthful)
              Flexible(flex: 1, child: Container(color: Colors.transparent)),
          ],
        ),
      ),
    );
  }
}

class TeacherTeamsList extends StatelessWidget {
  final List<TeamStruct> teacherTeams;
  final double rowheight;
  final double screenWidth;

  TeacherTeamsList({
    required this.teacherTeams,
    required this.rowheight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth > 1000 ? 1000 : screenWidth * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "隊伍列表",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Table(
              border: TableBorder(
                top: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey),
                horizontalInside: BorderSide(color: Colors.grey),
              ),
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(3),
              },
              children: [
                TableRow(
                  children: [
                    Container(
                      height: rowheight,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 15),
                      child: Text("隊伍ID", textAlign: TextAlign.left),
                    ),
                    Container(
                      height: rowheight,
                      alignment: Alignment.centerLeft,
                      child: Text("隊伍名稱", textAlign: TextAlign.left),
                    ),
                    Container(
                      height: rowheight,
                      alignment: Alignment.center,
                      child: Text("作品名稱", textAlign: TextAlign.center),
                    ),
                    Container(
                      height: rowheight,
                      alignment: Alignment.center,
                      child: Text("報名狀態", textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ] +
                  teacherTeams.map((team) {
                    return TableRow(
                      children: [
                        Container(
                          height: rowheight,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 15),
                          child: Text(team.teamid, textAlign: TextAlign.left),
                        ),
                        Container(
                          height: rowheight,
                          alignment: Alignment.centerLeft,
                          child: Text(team.teamname, textAlign: TextAlign.left),
                        ),
                        Container(
                          height: rowheight,
                          alignment: Alignment.center,
                          child: Text(team.workname ?? "未提供", textAlign: TextAlign.center),
                        ),
                        Container(
                          height: rowheight,
                          alignment: Alignment.center,
                          child: Container(
                            height: 20,
                            width: 70,
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
                              team.state ?? "N/A",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
