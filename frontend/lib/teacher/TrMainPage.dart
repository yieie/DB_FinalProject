import 'package:db_finalproject/admin/components/admin.dart';
import 'package:db_finalproject/teacher/logic/TrTeamService.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'package:flutter/material.dart';
import '../widgets/Navbar.dart';
import 'package:db_finalproject/data/Team.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

class TrMainPage extends StatefulWidget {
  const TrMainPage({super.key});

  @override
  State<TrMainPage> createState() => _TrMainPageState();
}

class _TrMainPageState extends State<TrMainPage> {

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Navbar(),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: authProvider.isSidebarOpen ? 250 : 0),
            child: const Dashboard(),
          ),
          const Sidebar(),
        ],
      ),
    );
  }
}

class Dashboard extends StatelessWidget {

  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final scrSize = MediaQuery.of(context).size;
    final double screenWidth = scrSize.width - 250;
    bool iswidthful = screenWidth > 850;

    return SingleChildScrollView(
      child: SafeArea(
        child: Row(
          children: [
            if (iswidthful)
              Flexible(flex: 1, child: Container(color: Colors.transparent)),
            Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 20)),
                TeacherTeamsList(
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

class TeacherTeamsList extends StatefulWidget {
  final double rowheight;
  final double screenWidth;

  const TeacherTeamsList({
    super.key,
    required this.rowheight,
    required this.screenWidth,
  });

  @override
  State<TeacherTeamsList> createState() => _TeacherTeamsListState();

}

class _TeacherTeamsListState extends State<TeacherTeamsList>{
  List<Team>? teams;
  final TrTeamSerive _trTeamSerive = TrTeamSerive();
  final years=["2024","2023","2022","2021","2020","2019","2018","2017","2016","2015","2014","2013","2012"];
  String _selectedyears="2024";

  Future<void> getTeamsByTrIDNYear(String trid,String year) async{
    try{
      teams = await _trTeamSerive.getBasicAllTeamByTrIdNYear(trid, year);
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
    Future.microtask(() {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.usertype != 'none' && authProvider.useraccount != 'none') {
        getTeamsByTrIDNYear(authProvider.useraccount, authProvider.useraccount);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      height: 640,
      width: widget.screenWidth > 850 ? 850 : widget.screenWidth * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children:[ 
                const Text(
                  "隊伍列表",
                  style: TextStyle(fontSize: 24),
                ),
                const Spacer(),
                Text("年份： ",style: TextStyle(fontSize: 20)),
                DropdownButton(
                  value: _selectedyears,
                  onChanged: (String? value){
                    if(value != null){
                      setState(() {
                        _selectedyears=value;
                        getTeamsByTrIDNYear(authProvider.useraccount, _selectedyears);
                      });
                    }
                  },
                  items: years.map((String item){
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item,style: TextStyle(fontSize: 20)),
                    );
                  }).toList(), 
                )
              ]
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(flex: 2, child: Text('隊伍ID')),
                  Expanded(flex: 3, child: Text('隊伍名稱')),
                  Expanded(flex: 3, child: Text('作品名稱')),
                  Expanded(flex: 2, child: Text('參賽組別')),
                  Expanded(flex: 2, child: Text('隊伍狀態')),
                  Expanded(flex: 1, child: Text('檢視')),
                ],
              ),
            ),
            teams == null ? const Center(child: CircularProgressIndicator()) 
            :SizedBox(
              height: 500,
              width: double.maxFinite,
                child: ListView.builder(
                  itemCount: teams!.length,
                  itemBuilder: (context,index){
                    final team = teams![index];
                    return Card(
                      color: Colors.grey.shade300,
                      margin: const EdgeInsets.only(top: 5,bottom: 5),
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            Expanded(flex: 2, child: Text(team.teamid)),
                            Expanded(flex: 3, child: Text(team.teamname)),
                            Expanded(flex: 3, child: Text(team.workname??'')),
                            Expanded(flex: 2, child: Text(team.teamtype)),
                            Expanded(flex: 2, child: Text(team.state??'')),
                            Expanded(flex:1, 
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey.shade100,
                                  foregroundColor: Colors.black
                                ),
                                onPressed: () {
                                  html.window.open(
                                    '/#/team/review?teamid=${team.teamid}',
                                    'reviewTeam',
                                    'width=1000,height=720,left=200,top=100'
                                  );
                                },
                                child: const Icon(Icons.visibility,color: Colors.black,),
                              )),
                          ],
                        ),
                      )
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
