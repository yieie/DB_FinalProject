import 'package:db_finalproject/common/logic/TeamService.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/data/Team.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'package:flutter/material.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;
import 'package:url_launcher/url_launcher.dart';

class HistoryData extends StatefulWidget{
  const HistoryData({super.key});

  @override
  State<HistoryData> createState () => _HistoryDataState();
}

class _HistoryDataState extends State<HistoryData>{

  @override
  Widget build(BuildContext context){
    final authProvider = Provider.of<AuthProvider>(context);
    final scrSize = MediaQuery.of(context).size;
    final double screenWidth = scrSize.width;
    bool iswidthful = screenWidth > 1000;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Navbar(),
      body: authProvider.isLoggedIn? Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: authProvider.isSidebarOpen ? 250 : 0),
            child: SafeArea(
              child: Row(
                children: [
                  if (iswidthful)
                    Flexible(flex: 1, child: Container(color: Colors.transparent)),
                  Expanded(
                    flex: 5, // 調整比例使內容區域大小正確
                    child: Column(
                      children: [
                        SizedBox(height: 20), // 呼叫子小部件顯示數據
                        ListHistoryData()
                      ],
                    ),
                  ),
                  if (iswidthful)
                    Flexible(flex: 1, child: Container(color: Colors.transparent)),
                ],
              ),
            ),
          ),
          Sidebar(),
        ],
      ):
      ListHistoryData()
    );
  }
}

class ListHistoryData extends StatefulWidget{
  const ListHistoryData({super.key});

  @override
  State<ListHistoryData> createState()=> _ListHistoryDataState();
}

class _ListHistoryDataState extends State<ListHistoryData>{
  String? _selectedYear; // 當前選中的年份
  final List<String> _years = ["2025","2024","2023","2022","2021","2020","2019","2018","2017","2016","2015","2014","2013","2012"]; // 可選年份列表
  final TeamService _teamService = TeamService();

  List<Team> teams=[];

  Future<void> fetchBasicAllTeam(String year) async{
    try{
      teams = await _teamService.getBasicAllTeamWithConstraint(year);
      setState(() {});
    }catch(e){
      print(e);
      teams=[
        Team(teamid: '2024team001', teamname: '嗨嗨嗨嗨', teamtype: '創意發想組',workname: 'c9cefjiahfijwef',rank: '1',workyturl: 'https://www.google.com/',workgithub: '51325461'),
        Team(teamid: '2024teamid', teamname: '嘎嘎嘎嘎嘎', teamtype: '創意發想組',workname: 'adfjijfokae',rank: '2',workyturl: '65158546146851',workgithub: '51325461'),
      ];
      setState(() {});
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication); // 打開外部瀏覽器
    } else {
      throw '無法打開網址: $url';
    }
  }

  @override
  Widget build(BuildContext context){
    final ideaTeams = teams.where((team) => team.teamtype.startsWith('創意發想組')).toList();
    final businessTeams = teams.where((team) => team.teamtype.startsWith('創業實作組')).toList();
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      if(_selectedYear!=null){
                        fetchBasicAllTeam(_selectedYear!);
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
              ],
            ),

            const SizedBox(height: 10),

            // 成績列表
            if (_selectedYear != null)
            
              SingleChildScrollView(
                child: SizedBox(
                  height: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$_selectedYear 年資料：",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 420,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade100
                            ),
                            child: Column(
                              children: [
                                const Text("創意實作組",style: TextStyle(fontSize: 18),),
                                SizedBox(
                                  width: 400,
                                  height: 430,
                                  child: ListView.builder(
                                    itemCount: ideaTeams.length,
                                    itemBuilder: (context, index) {
                                      final team = ideaTeams[index];
                                      return Card(
                                          color: team.rank=='1'?Colors.amber:
                                                 team.rank=='2'?Colors.grey.shade300:
                                                 team.rank=='3'?const Color(0xFFCD7F32):Colors.blue.shade100,
                                          margin: const EdgeInsets.symmetric(vertical: 8),
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.all(15),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(flex: 1, child: Text(team.rank==null?'':'第${team.rank}名',style: TextStyle(fontSize: 18),)),
                                                    Expanded(flex: 6, child: Text('隊伍名稱: ${team.teamname}',style: TextStyle(fontSize: 16),)),
                                                    
                                                  ],
                                                ),
                                                const SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    const Expanded(flex: 1, child: Text('')),
                                                    Expanded(flex: 6, child: Text('作品名稱: ${team.workid??''}',style: TextStyle(fontSize: 16),)),
                                                    
                                                  ],
                                                ),
                                                const SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    const Expanded(flex: 1, child: Text('')),
                                                    Expanded(flex: 6, child: 
                                                    TextButton(
                                                      style: ButtonStyle(
                                                        alignment: Alignment.centerLeft
                                                      ),
                                                      onPressed: team.workyturl==null?null:()=>_launchUrl(team.workyturl!),
                                                      child: Text('Youtube: ${team.workyturl??''}')
                                                      )
                                                    ),
                                                    
                                                  ],
                                                ),
                                                const SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    const Expanded(flex: 1, child: Text('')),
                                                    Expanded(flex: 6, child: 
                                                    TextButton(
                                                      style: ButtonStyle(
                                                        alignment: Alignment.centerLeft
                                                      ),
                                                      onPressed: team.workgithub==null?null:()=>_launchUrl(team.workgithub!),
                                                      child: Text('GitHub: ${team.workgithub??''}')
                                                      )
                                                    ),
                                                    
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Container(
                            width: 420,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade100
                            ),
                            child: Column(
                              children: [
                                const Text("創業實作組",style: TextStyle(fontSize: 18),),
                                SizedBox(
                                  width: 400,
                                  height: 430,
                                  child: ListView.builder(
                                    itemCount: businessTeams.length,
                                    itemBuilder: (context, index) {
                                      final team = businessTeams[index];
                                      return Card(
                                          color: team.rank=='1'?Colors.amber:
                                                 team.rank=='2'?Colors.grey.shade300:
                                                 team.rank=='3'?const Color(0xFFCD7F32):Colors.blue.shade100,
                                          margin: const EdgeInsets.symmetric(vertical: 8),
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.all(15),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(flex: 1, child: Text(team.rank==null?'':'第${team.rank}名',style: TextStyle(fontSize: 18),)),
                                                    Expanded(flex: 6, child: Text('隊伍名稱: ${team.teamname}',style: TextStyle(fontSize: 16),)),
                                                    
                                                  ],
                                                ),
                                                const SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    const Expanded(flex: 1, child: Text('')),
                                                    Expanded(flex: 6, child: Text('作品名稱: ${team.workid??''}',style: TextStyle(fontSize: 16),)),
                                                    
                                                  ],
                                                ),
                                                const SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    const Expanded(flex: 1, child: Text('')),
                                                    Expanded(flex: 6, child: 
                                                    TextButton(
                                                      style: ButtonStyle(
                                                        alignment: Alignment.centerLeft
                                                      ),
                                                      onPressed: team.workyturl==null?null:()=>_launchUrl(team.workyturl!),
                                                      child: Text('Youtube: ${team.workyturl??''}')
                                                      )
                                                    ),
                                                    
                                                  ],
                                                ),
                                                const SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    const Expanded(flex: 1, child: Text('')),
                                                    Expanded(flex: 6, child: 
                                                    TextButton(
                                                      style: ButtonStyle(
                                                        alignment: Alignment.centerLeft
                                                      ),
                                                      onPressed: team.workgithub==null?null:()=>_launchUrl(team.workgithub!),
                                                      child: Text('GitHub: ${team.workgithub??''}')
                                                      )
                                                    ),
                                                    
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                      );
                                    },
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
              )
            else
              const Center(
                child: Text(
                  "請先選擇年份及組別來查看歷年資料。",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
          ],
        ),
      );
  }
}