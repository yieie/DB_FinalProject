import 'package:db_finalproject/judge/logic/JudgeTeamService.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'dart:html' as html;
import 'package:db_finalproject/data/Team.dart';

class RateTeams extends StatefulWidget{
  const RateTeams({super.key});
  @override
  State<RateTeams> createState() => _RateTeamsState();
}

class _RateTeamsState extends State<RateTeams> {

 @override
  Widget build(BuildContext context){
    final scrSize = MediaQuery.of(context).size;
    final double screenWidth = scrSize.width-250;
    bool iswidthful = screenWidth > 850 ? true : false;
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
            child: SingleChildScrollView(
              child: SafeArea(
                child: Row(
                  children: [
                    if(iswidthful)
                      Flexible(flex: 1, child: Container(color: Colors.transparent)),
                    
                    Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 20)),
                                    
                        Container(
                          width: screenWidth > 850 ? 850 : screenWidth * 0.9,
                          padding: const EdgeInsets.only(left: 16),
                          child: const Text("評分隊伍資料",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,))
                        ),
                        const SizedBox(height: 10,),
                        showTeams(screenWidth: screenWidth)
                      ],
                    ),
                
                    if(iswidthful)
                      Flexible(flex: 1, child: Container(color: Colors.transparent)),
                  ],
                ),
              ),
            )
          ),
          const Sidebar()
        ]
      )
    );

  }
}

class showTeams extends StatefulWidget{
  const showTeams({super.key,required this.screenWidth});
  final double screenWidth;

  @override
  State<showTeams> createState() => _showTeamState();
}

class _showTeamState extends State<showTeams>{
  List<Team>? teams;
  final JudgeTeamService _judgeTeamService = JudgeTeamService();

  Future<void> fetchTeamsInContest() async{
    try{
      teams = await _judgeTeamService.getBasicAllTeamInContest();
      setState(() {});
    }catch(e){
      print(e);
      teams=[Team(teamid: '2024team001', teamname: '我超強', teamtype: '創意發想組',state: '報名待審核',workname: '智慧系統')];
      setState(() {
        
      });
    }
  }

  @override
  void initState(){
    super.initState();
    fetchTeamsInContest();
  }

  @override
  Widget build(BuildContext context){
    return teams==null ? const Center(child: CircularProgressIndicator()):
      SizedBox(
      height: 500,
      width: widget.screenWidth > 850 ? 850 : widget.screenWidth * 0.9,
      child: ListView.builder(
        itemCount: teams!.length,
        itemBuilder: (context, index) {
          final team = teams![index];
          return Card(
            color: team.state=="初賽隊伍"?Colors.blue.shade100:Colors.blue.shade300,
            margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: ListTile(
              title: Text('${team.teamid}: ${team.teamname}'),
              subtitle: Text("作品名稱:${team.workname}"),
              trailing: IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {
                  html.window.open(
                    '/#/team/review?teamid=${team.teamid}', // 新視窗的網址
                    'reviewTeam',      // 視窗名稱（用於管理視窗實例）
                    'width=1000,height=720,left=200,top=100', // 視窗屬性
                  );
                } ,
              ),
            ),
          );
        },
      ),
    );
  }
}