import 'package:db_finalproject/judge/logic/RateService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'package:db_finalproject/data/Score.dart';

class RateRecords extends StatefulWidget {
  const RateRecords({super.key});

  @override
  State<RateRecords> createState() => _RateRecordsState();
}

class _RateRecordsState extends State<RateRecords> {

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final scrSize = MediaQuery.of(context).size;
    final double screenWidth = scrSize.width-250;
    bool iswidthful = screenWidth > 850 ? true : false;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Navbar(),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: authProvider.isSidebarOpen ? 250 : 0),
            child: SingleChildScrollView(
                child: SafeArea(
                  child: Row(
                    children: [
                      if(iswidthful)
                        Flexible(flex: 1, child: Container(color: Colors.transparent)),

                      RecordsField(screenWidth:screenWidth),

                      if(iswidthful)
                        Flexible(flex: 1, child: Container(color: Colors.transparent)),
                    ]
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

class RecordsField extends StatefulWidget{
  final double screenWidth;

  const RecordsField({super.key, required this.screenWidth});
  @override
  State<RecordsField> createState() => _RecordsFieldState();
}

class _RecordsFieldState extends State<RecordsField>{

  List<Score> scoredTeams = [
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
            teamtype: '創業實作組',
            teamname: '我們超若的',
            judgename: "judge@example.com",
            Rate1: "78",
            Rate2: "82",
            Rate3: "80",
            Rate4: "85",
          ),
        ];
  final RateService _rateService = RateService();

  Future<void> fetchScoredbyJudgeId(String judgeid) async {
    try {
      scoredTeams = await _rateService.getAllScorebyJudgeId(judgeid);
      setState(() {});
    } catch (e) {
      print('Error fetching scored teams: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.usertype == 'judge' && authProvider.useraccount != 'none') {
        fetchScoredbyJudgeId(authProvider.useraccount);
      }  
    });
  }

  @override
  Widget build(BuildContext context){
    final IdeaTeams = scoredTeams.where((team) => team.teamtype.startsWith('創意發想組'));
    final BusinessTeams = scoredTeams.where((team) => team.teamtype.startsWith('創業實作組'));
    return SizedBox(
      width: widget.screenWidth>850?850:widget.screenWidth*0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Spacer(),
              Column(
                children: [
                  Text("創意發想組:\n分數1(35%): 創新與特色\n分數2(35%): 實用價值與技術、服務獨特性\n分數3(25%): 創意實作可行性\n分數4(5%): 其他")
                ],
              ),
              SizedBox(width: 50,),
              Column(
                children: [
                  Text("創業實作組:\n分數1(35%): 產品及服務內容創新性\n分數2(35%): 市場可行性\n分數3(25%): 未來發展性\n分數4(5%): 其他")
                ],
              ),
              Spacer()
            ],
          ),
          const Text(
            "評分紀錄",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "創意發想組",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(15),
            child: const Row(
              children: [
                Expanded(flex: 2 ,child: Text('隊伍組別')),
                Expanded(flex: 3 ,child: Text('隊伍ID')),
                Expanded(flex: 3, child: Text('隊伍名稱')),
                Expanded(flex: 2, child: Text('評審委員')),
                Expanded(flex: 2, child: Text('分數1')),
                Expanded(flex: 2, child: Text("分數2")),
                Expanded(flex: 2, child: Text("分數3")),
                Expanded(flex: 2, child: Text("分數4")),
                Expanded(flex: 2, child: Text('總分')),
                Expanded(flex: 1, child: Text('排名')),
              ],
            ),
          ),
          IdeaTeams.isEmpty ? const Center(child: CircularProgressIndicator()):
          SizedBox(
            height: 300,
            child: ListView(
              children: IdeaTeams.map((team) {
                return Card(
                  color: team.teamrank == '1'
                      ? Colors.amber
                      : team.teamrank == '2'
                          ? Colors.grey.shade300
                          : team.teamrank == '3'
                              ? const Color(0xFFCD7F32)
                              : Colors.blue.shade100,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Text(team.teamtype)),
                        Expanded(flex: 3, child: Text(team.teamid)),
                        Expanded(flex: 3, child: Text(team.teamname)),
                        Expanded(flex: 2, child: Text(team.judgename)),
                        Expanded(flex: 2, child: Text(team.Rate1 ?? '')),
                        Expanded(flex: 2, child: Text(team.Rate2 ?? '')),
                        Expanded(flex: 2, child: Text(team.Rate3 ?? '')),
                        Expanded(flex: 2, child: Text(team.Rate4 ?? '')),
                        Expanded(flex: 2, child: Text(team.totalrate ?? '')),
                        Expanded(flex: 1, child: Text(team.teamrank ?? '')),
                      ],
                    ),
                  ),
                );
              }).toList(), // 使用 `.toList()` 將 Iterable 轉換為 Widget 列表
            ),
          ),

          const SizedBox(height: 20),
          const Text(
            "創業實作組",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(15),
            child: const Row(
              children: [
                Expanded(flex: 2 ,child: Text('隊伍組別')),
                Expanded(flex: 3 ,child: Text('隊伍ID')),
                Expanded(flex: 3, child: Text('隊伍名稱')),
                Expanded(flex: 2, child: Text('評審委員')),
                Expanded(flex: 2, child: Text('分數1')),
                Expanded(flex: 2, child: Text("分數2")),
                Expanded(flex: 2, child: Text("分數3")),
                Expanded(flex: 2, child: Text("分數4")),
                Expanded(flex: 2, child: Text('總分')),
                Expanded(flex: 1, child: Text('排名')),
              ],
            ),
          ),
          BusinessTeams.isEmpty ? const Center(child: CircularProgressIndicator()):
          SizedBox(
            height: 300,
            child: ListView(
              children: BusinessTeams.map((team) {
                return Card(
                  color: team.teamrank == '1'
                      ? Colors.amber
                      : team.teamrank == '2'
                          ? Colors.grey.shade300
                          : team.teamrank == '3'
                              ? const Color(0xFFCD7F32)
                              : Colors.blue.shade100,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Text(team.teamtype)),
                        Expanded(flex: 3, child: Text(team.teamid)),
                        Expanded(flex: 3, child: Text(team.teamname)),
                        Expanded(flex: 2, child: Text(team.judgename)),
                        Expanded(flex: 2, child: Text(team.Rate1 ?? '')),
                        Expanded(flex: 2, child: Text(team.Rate2 ?? '')),
                        Expanded(flex: 2, child: Text(team.Rate3 ?? '')),
                        Expanded(flex: 2, child: Text(team.Rate4 ?? '')),
                        Expanded(flex: 2, child: Text(team.totalrate ?? '')),
                        Expanded(flex: 1, child: Text(team.teamrank ?? '')),
                      ],
                    ),
                  ),
                );
              }).toList(), // 使用 `.toList()` 將 Iterable 轉換為 Widget 列表
            ),
          ),
        ],
      ),
    );
  }
}