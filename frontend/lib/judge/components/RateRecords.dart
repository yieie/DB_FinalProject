import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'package:db_finalproject/data/Score.dart';
import 'package:db_finalproject/core/services/ApiService.dart';

class RateRecords extends StatefulWidget {
  @override
  _RateRecordsState createState() => _RateRecordsState();
}

class _RateRecordsState extends State<RateRecords> {
  List<Score> scoredTeams = [];
  ApiService _apiService = ApiService();

  Future<void> fetchScoredTeams() async {
    try {
      // scoredTeams = await _apiService.getScoredTeams();
      setState(() {
        // Placeholder data for testing
        scoredTeams = [
          Score(
            teamid: "2024team001",
            teamtype: '創意發想組',
            teamname: '我們超強的',
            judgename: "judge@example.com",
            Rate1: "85",
            Rate2: "90",
            Rate3: "88",
            Rate4: "92",
          ),
          Score(
            teamid: "2024team002",
            teamtype: '創意發想組',
            teamname: '我們超若的',
            judgename: "judge@example.com",
            Rate1: "78",
            Rate2: "82",
            Rate3: "80",
            Rate4: "85",
          ),
        ];
      });
      // setState(() {});
    } catch (e) {
      print('Error fetching scored teams: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchScoredTeams();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final creativeTeams = scoredTeams.where((team) => team.teamid.startsWith("2024team001"));
    final entrepreneurshipTeams = scoredTeams.where((team) => team.teamid.startsWith("2024team002"));

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
                      "評分紀錄",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    if (creativeTeams.isNotEmpty) ...[
                      Text(
                        "創意發想組",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      _buildCreativeTable(creativeTeams),
                    ],
                    if (entrepreneurshipTeams.isNotEmpty) ...[
                      SizedBox(height: 20),
                      Text(
                        "創業實作組",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      _buildEntrepreneurshipTable(entrepreneurshipTeams),
                    ],
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

  Widget _buildCreativeTable(Iterable<Score> teams) {
    return Table(
      border: TableBorder(
        top: BorderSide(color: Colors.grey),
        bottom: BorderSide(color: Colors.grey),
        horizontalInside: BorderSide(color: Colors.grey),
      ),
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(1),
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
                "創新與特色",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "實用價值與技術、服務獨特性",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "創意實作可行性",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "其它",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        ...teams.map(
          (team) => TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(team.teamid),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(team.Rate1 ?? "N/A"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(team.Rate2 ?? "N/A"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(team.Rate3 ?? "N/A"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(team.Rate4 ?? "N/A"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEntrepreneurshipTable(Iterable<Score> teams) {
    return Table(
      border: TableBorder(
        top: BorderSide(color: Colors.grey),
        bottom: BorderSide(color: Colors.grey),
        horizontalInside: BorderSide(color: Colors.grey),
      ),
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(1),
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
                "產品及服務內容創新性",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "市場可行性",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "未來發展性",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "其他",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        ...teams.map(
          (team) => TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(team.teamid),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(team.Rate1 ?? "N/A"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(team.Rate2 ?? "N/A"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(team.Rate3 ?? "N/A"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(team.Rate4 ?? "N/A"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
