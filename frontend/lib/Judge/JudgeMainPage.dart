// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../Navbar.dart';

class JudgeMainPage extends StatelessWidget {
  const JudgeMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Navbar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              ScoringList(),
            ],
          ),
        ),
      ),
    );
  }
}

class ScoringList extends StatefulWidget {
  @override
  State<ScoringList> createState() => _ScoringListState();
}

class _ScoringListState extends State<ScoringList> {
  List<Map<String, String>> teams = [
    {"teamid": "2024team001", "teamname": "我們這一隊"},
    {"teamid": "2024team002", "teamname": "最強隊伍"},
    {"teamid": "2024team003", "teamname": "挑戰者"},
  ];

  @override
  Widget build(BuildContext context) {
    final scrSize = MediaQuery.of(context).size;
    final double screenWidth = scrSize.width - 250;
    bool isWideScreen = screenWidth > 1000;

    return Center( // 水平置中
      child: Container(
        width: isWideScreen ? 1000 : screenWidth * 0.9,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // 內容置中
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
                2: FlexColumnWidth(1),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("隊伍ID", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("隊伍名稱", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("操作", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    ),
                  ],
                ),
                ...teams.map((team) => TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(team['teamid']!, textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(team['teamname']!, textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
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
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ScoringPage extends StatelessWidget {
  final String teamId;

  const ScoringPage({required this.teamId, super.key});

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
