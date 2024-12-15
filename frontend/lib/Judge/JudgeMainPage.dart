import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/AuthProvider.dart';
import 'package:db_finalproject/Sidebar.dart';
import 'package:db_finalproject/Navbar.dart';

class JudgeMainPage extends StatefulWidget {
  @override
  _JudgeMainPageState createState() => _JudgeMainPageState();
}

class _JudgeMainPageState extends State<JudgeMainPage> {
  List<Map<String, String>> scoringTeams = [
    {"teamid": "2024team001", "teamname": "我們這一隊"},
    {"teamid": "2024team002", "teamname": "最強隊伍"},
    {"teamid": "2024team003", "teamname": "挑戰者"},
  ];

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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "評分清單",
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
                                "操作",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        ...scoringTeams.map(
                          (team) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(team['teamid']!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(team['teamname']!),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: SizedBox(
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ScoringPage(teamId: team['teamid']!),
                                        ),
                                      );
                                    },
                                    child: Text("評分"),
                                  ),
                                ),
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

class ScoringPage extends StatelessWidget {
  final String teamId;

  const ScoringPage({required this.teamId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("評分隊伍: $teamId"),
      ),
      body: Center(
        child: Text(
          "評分頁面功能待實作",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
