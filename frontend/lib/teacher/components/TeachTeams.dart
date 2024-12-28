import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'package:db_finalproject/core/services/ApiService.dart';
import 'package:db_finalproject/data/Team.dart';

class TeachTeams extends StatefulWidget{
  @override
  _TeachTeamsState createState() => _TeachTeamsState();
}

class _TeachTeamsState extends State<TeachTeams> {
  List<Team> teacherTeams = [];
  ApiService _apiService = ApiService();

  Future<void> fetchTeacherTeams() async {
    try {
      // teacherTeams = await _apiService.getBasicAllTeam();
      setState(() {});
    } catch (e) {
      print('Error fetching teacher teams: $e');
      setState(() {
        teacherTeams = [
          Team(
              teamid: "2023team001",
              teamname: "Example Team A",
              teamtype: "創意發想",
              workid: "work001",
              state: "初賽隊伍",
              workname: "Project A",
              worksummary: "Summary A"),
          Team(
              teamid: "2023team002",
              teamname: "Example Team B",
              teamtype: "創業實作",
              workid: "work002",
              state: "初賽隊伍",
              workname: "Project B",
              worksummary: "Summary B"),
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
  Widget build(BuildContext context){
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "歷年指導隊伍",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
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
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "隊伍ID",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "隊伍名稱",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "作品名稱",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "狀態",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        ...teacherTeams.map(
                          (team) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(team.teamid),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(team.teamname),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(team.workname ?? "未提供"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(team.state ?? "未知"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
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