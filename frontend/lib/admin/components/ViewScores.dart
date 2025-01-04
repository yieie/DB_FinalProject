import 'package:db_finalproject/admin/logic/AdminTeamService.dart';
import 'package:db_finalproject/data/Score.dart';
import 'package:flutter/material.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';

class ViewScores extends StatefulWidget{
  const ViewScores({super.key});

  @override
  State<ViewScores> createState() => _ViewScoresState();
}

class _ViewScoresState extends State<ViewScores> {

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
            child: const Scores()
          ),
          Sidebar()
        ]
      )
    );

  }
}

class Scores extends StatefulWidget {
  const Scores({super.key});

  @override
  State<Scores> createState() => _ScoresState();
}

class _ScoresState extends State<Scores> {
  String? _selectedYear; // 當前選中的年份
  final List<String> _years = ["2024","2023","2022","2021","2020","2019","2018","2017","2016","2015","2014","2013","2012"]; // 可選年份列表
  final List<String> _teamtype=['全組別','創意發想組','創業實作組'];
  String? _selectedTeamtype;
  final AdminTeamService _adminTeamService = AdminTeamService();

  List<Score> scores = [Score(teamid: '2024team001', teamname: '哈哈哈', teamtype: '創意發想組', judgename: '王大強',Rate1: '90',Rate2: '91',Rate3: '92',Rate4: '93',totalrate: '92.5',teamrank: '1'),
  Score(teamid: '2024team001', teamname: '哈哈哈', teamtype: '創意發想組', judgename: '王大強',Rate1: '90',Rate2: '91',Rate3: '92',Rate4: '93',totalrate: '92.5',teamrank: '2')];

  Future<void> fetchScores(String year,String teamtype) async{
    scores = await _adminTeamService.getScoresWithConstraints({'year':year,'teamtype':teamtype});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
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
            
            const SizedBox(height: 20),
            // 標題
            Row(
              children: [
                const Spacer(),
                const Text(
                  "請選擇年份：",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                
                // 年份下拉選單
                DropdownButton<String>(
                  hint: const Text("選擇年份"),
                  value: _selectedYear,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedYear = newValue;
                      if(_selectedYear!=null && _selectedTeamtype!=null){
                        fetchScores(_selectedYear!,_selectedTeamtype!);
                      }
                    });
                  },
                  items: _years.map<DropdownMenuItem<String>>((String year) {
                    return DropdownMenuItem<String>(
                      value: year,
                      child: Text(year),
                    );
                  }).toList(),
                ),

                const Spacer(),
                const Text(
                  "請選擇組別：",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),

                DropdownButton<String>(
                  hint: const Text("選擇組別"),
                  value: _selectedTeamtype,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTeamtype = newValue;
                      if(_selectedYear!=null && _selectedTeamtype!=null){
                        fetchScores(_selectedYear!,_selectedTeamtype!);
                      }
                    });
                  },
                  items: _teamtype.map<DropdownMenuItem<String>>((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                ),
                const Spacer(),
              ],
            ),

            const SizedBox(height: 20),

            // 成績列表
            if (_selectedYear != null && _selectedTeamtype != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$_selectedYear 年成績：",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: scores.length,
                        itemBuilder: (context, index) {
                          final team = scores[index];
                          return Card(
                            color: team.teamrank=='1'?Colors.amber:
                                   team.teamrank=='2'?Colors.grey.shade300:
                                   team.teamrank=='3'?const Color(0xFFCD7F32):Colors.blue.shade100,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Expanded(flex: 2 ,child: Text(team.teamtype)),
                                  Expanded(flex: 3 ,child: Text(team.teamid)),
                                  Expanded(flex: 3, child: Text(team.teamname)),
                                  Expanded(flex: 2, child: Text(team.judgename)),
                                  Expanded(flex: 2, child: Text(team.Rate1!)),
                                  Expanded(flex: 2, child: Text(team.Rate2!)),
                                  Expanded(flex: 2, child: Text(team.Rate3!)),
                                  Expanded(flex: 2, child: Text(team.Rate4!)),
                                  Expanded(flex: 2, child: Text(team.totalrate!)),
                                  Expanded(flex: 1, child: Text(team.teamrank??'')),
                                ],
                              ),
                            )
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            else
              const Center(
                child: Text(
                  "請先選擇年份及組別來查看成績。",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
          ],
        ),
      );
  }
}
