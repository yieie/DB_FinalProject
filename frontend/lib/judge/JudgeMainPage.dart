import 'package:db_finalproject/data/Team.dart';
import 'package:db_finalproject/judge/logic/RateService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'dart:html' as html;
import 'package:flutter/services.dart';

class JudgeMainPage extends StatefulWidget {
  const JudgeMainPage({super.key});

  @override
  State<JudgeMainPage> createState() => _JudgeMainPageState();
}

class _JudgeMainPageState extends State<JudgeMainPage> {

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
                    
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 20)),

                        ScoringList(screenWidth:screenWidth)
                      ],
                    ),
                
                    if(iswidthful)
                      Flexible(flex: 1, child: Container(color: Colors.transparent)),
                  ],
                ),
              ),
            )
          ),
          Sidebar()
        ],
      ),
    );
  }
}


class ScoringList extends StatefulWidget{
  const ScoringList({super.key, required this.screenWidth});
  final double screenWidth;

  @override
  State<ScoringList> createState() => _ScoringListState();
}

class _ScoringListState extends State<ScoringList>{
  final RateService _rateService = RateService();

  List<Team> teamidea=[
    Team(teamid: '2024team01', teamname: '我們這一隊', teamtype: '創意發想組',workname: '智慧系統'),
    Team(teamid: '2024team01', teamname: '我們這一隊', teamtype: '創意發想組',workname: '智慧系統'),
    Team(teamid: '2024team01', teamname: '我們這一隊', teamtype: '創意發想組',workname: '智慧系統'),
  ];
  List<Team> teambusiness=[
    Team(teamid: '2024team01', teamname: '我們這一隊', teamtype: '創意發想組',workname: '智慧系統'),
    Team(teamid: '2024team01', teamname: '我們這一隊', teamtype: '創意發想組',workname: '智慧系統'),
  ];

  Future<void> fetchScoringTeams() async{
    try{
      teamidea = await _rateService.getAllTeamIdea();
      teambusiness = await _rateService.getAllTeamBusiness();
      setState(() {});//重新渲染
    }catch(e){
      print(e);
    }
  }

  @override
  void initState(){
    super.initState();
    fetchScoringTeams();
  }


  @override
  Widget build(BuildContext context){
    return SizedBox(
        width: widget.screenWidth>850?850:widget.screenWidth*0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "評分清單",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20)
              ),
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(top: 15,left: 20,right: 20),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Expanded(flex:2, child: Text("隊伍ID",style:  TextStyle(fontSize:16))),
                        Expanded(flex:2, child: Text("隊伍名稱",style:  TextStyle(fontSize:16))),
                        Expanded(flex:3, child: Text("作品名稱",style:  TextStyle(fontSize:16))),
                        Expanded(flex:1, child: Text("操作",textAlign: TextAlign.center ,style:  TextStyle(fontSize:16))),
                      ],
                    ),
                    teamidea.isEmpty ? const Center(child: CircularProgressIndicator()) 
                    :Expanded(
                      child: ListView.builder(
                        itemCount: teamidea.length,
                        itemBuilder: (context,index){
                          final team = teamidea[index];
                          return Card(
                            color: Colors.grey.shade300,
                            margin: const EdgeInsets.only(top: 5,bottom: 5),
                            child: SizedBox(
                              height: 40,
                              child: Row(
                              children: [
                                Expanded(flex:2, child: Text(team.teamid,style:  const TextStyle(fontSize:16))),
                                Expanded(flex:2, child: Text(team.teamname,style:  const TextStyle(fontSize:16))),
                                Expanded(flex:3, child: Text(team.workname!,style:  const TextStyle(fontSize:16))),
                                Expanded(flex:1, 
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueGrey.shade100,
                                      foregroundColor: Colors.black
                                    ),
                                    onPressed: () {
                                      html.window.open(
                                          '/#/score/add&edit/teamidea?teamid=${team.teamid}',
                                          'ScoringTeam',
                                          'width=600,height=500,left=200,top=100'
                                      );
                                    },
                                    child: const Text("評分"),
                                  )),
                              ],
                          )));
                        },
                      )),
                  ],
                ),
              )
            ),
            const SizedBox(height: 20,),
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20)
              ),
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(top: 15,left: 20,right: 20),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Expanded(flex:2, child: Text("隊伍ID",style:  TextStyle(fontSize:16))),
                        Expanded(flex:2, child: Text("隊伍名稱",style:  TextStyle(fontSize:16))),
                        Expanded(flex:3, child: Text("作品名稱",style:  TextStyle(fontSize:16))),
                        Expanded(flex:1, child: Text("操作",textAlign: TextAlign.center ,style:  TextStyle(fontSize:16))),
                      ],
                    ),
                    teambusiness.isEmpty ? const Center(child: CircularProgressIndicator()) 
                    :Expanded(
                      child: ListView.builder(
                        itemCount: teambusiness.length,
                        itemBuilder: (context,index){
                          final team = teambusiness[index];
                          return Card(
                            color: Colors.grey.shade300,
                            margin: const EdgeInsets.only(top: 5,bottom: 5),
                            child: SizedBox(
                              height: 40,
                              child: Row(
                                children: [
                                  Expanded(flex:2, child: Text(team.teamid,style:  const TextStyle(fontSize:16))),
                                  Expanded(flex:2, child: Text(team.teamname,style:  const TextStyle(fontSize:16))),
                                  Expanded(flex:3, child: Text(team.workname!,style:  const TextStyle(fontSize:16))),
                                  Expanded(flex:1, 
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueGrey.shade100,
                                        foregroundColor: Colors.black
                                      ),
                                      onPressed: () {
                                        html.window.open(
                                          '/#/score/add&edit/teambusiness?teamid=${team.teamid}',
                                          'ScoringTeam',
                                          'width=600,height=500,left=200,top=100'
                                        );
                                      },
                                      child: const Text("評分"),
                                    )),
                                ],
                              ),
                            ));
                        },
                      )),
                  ],
                ),
              )
            ),
            const SizedBox(height: 20,),
          ],
        ),
    );
  }
}

class Scoring extends StatefulWidget {
  final String teamId;
  final String teamtype;
  const Scoring({super.key, required this.teamId, required this.teamtype});

  @override
  State<Scoring> createState() => _ScoringState();
}

class _ScoringState extends State<Scoring>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RateService _rateService = RateService();
  List<String> scores=['','','',''];

  Map<String,List<String>> scoreName={
    "創意發想組":["創新與特色 (35%) :","實用價值與技術、服務獨特性 (25%) :","創意實作可行性 (25%) :", "其他 (5%):"],
    "創業實作組":["產品及服務內容創新性 (35%) :","市場可行性 (25%) :","未來發展性 (25%) :", "其他 (5%):"]
  };

  Future<void> _saveChanges(String judgeid,String teamid) async{
    try{
      await _rateService.addScore(
      {
        'judgeid':judgeid,
        'score1':scores[0],
        'score2':scores[1],
        'score3':scores[2],
        'score4':scores[3]
      }
      , teamid);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("評分已新增\n三秒後關閉此視窗\n\n評分隊伍：$teamid\n${scoreName[widget.teamtype]![0]} ${scores[0]}分\n${scoreName[widget.teamtype]![1]} ${scores[1]}分\n${scoreName[widget.teamtype]![2]} ${scores[2]}分\n${scoreName[widget.teamtype]![3]} ${scores[3]}分"),
          );
        },
      );
    }catch(e){
      print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            backgroundColor: Colors.white,
            title: Text("連接資料庫失敗\n請稍後再試"),
          );
        },
      );
    }

    Future.delayed(const Duration(seconds: 3), () {
      html.window.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 500,
          child:Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height:50,
                  child: Text(
                    "${widget.teamId} 評分",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
                ),
                ...scoreName[widget.teamtype]!.asMap().entries.map((entry) {
                  int index = entry.key;
                  String label = entry.value;
                  return Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(label, style: const TextStyle(fontSize: 18)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              labelText: "輸入數字",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "請輸入數字";
                              }
                              final number = int.tryParse(value);
                              if (number == null) {
                                return "請輸入有效的數字";
                              }
                              if (number > 100 || number < 0) {
                                return "請輸入0~100的數字";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              scores[index] = newValue!;
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _saveChanges(authProvider.useraccount, widget.teamId);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding:const  EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child:const  Text(
                      '送出評分',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            )
          ),
        )
      ),
    );
  }
}
