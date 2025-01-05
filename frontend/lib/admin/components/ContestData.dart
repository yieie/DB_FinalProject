import 'package:db_finalproject/admin/logic/AdminTeamService.dart';
import 'package:db_finalproject/data/Team.dart';
import 'package:db_finalproject/data/Student.dart';
import 'package:db_finalproject/data/Teacher.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'dart:html' as html;
import 'package:url_launcher/url_launcher.dart';

/*類似Adminmainpage中的隊伍資料，有更多功能，可以去查看隊伍的學生、老師、實際作品的檔案*/

class ContestData extends StatefulWidget{
  const ContestData({super.key});

  @override
  State<ContestData> createState() => _ContestDataState();
}

class _ContestDataState extends State<ContestData> {
  List<Team> teams=[];

  void updateTeams(List<Team> newTeams) {
    setState(() {
      teams = newTeams; // 更新數據並觸發重新渲染
    });
  }

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
            child: Column(
              children: [
                selectBar(onUpdateTeams: updateTeams),
                const SizedBox(height: 20,),
                showTeams(teams: teams)
              ],
            )
          ),
          const Sidebar()
        ]
      )
    );

  }
}

class selectBar extends StatefulWidget{
  final years=["2024","2023","2022","2021","2020","2019","2018","2017","2016","2015","2014","2013","2012"];
  final teamtype=["全組別","創意發想組","創業實作組"];
  final teamstaus=["無","報名待審核","已審核","待審核初賽資格","需補件","已補件","初賽隊伍","決賽隊伍"];
  final Function(List<Team>) onUpdateTeams;

  selectBar({super.key, required this.onUpdateTeams});

  @override
  State<selectBar> createState() => _selectedBarState();
}

class _selectedBarState extends State<selectBar>{
  String _selectedyears="2024";
  String _selectedteamtype="全組別";
  String _selectedteamstatus="無";
  
  final AdminTeamService _adminTeamService =AdminTeamService();
  List<Team> teams=[];

  Future<void> _search() async{
    widget.onUpdateTeams([]);
    try{
      teams = await _adminTeamService.getBasicAllTeamWithConstraint({
        'teamyear':_selectedyears,
        'teamtype':_selectedteamtype,
        'teamstate':_selectedteamstatus
      });
      widget.onUpdateTeams(teams);
    }catch(e){
      print("error:$e");
      teams=[ Team(teamid: "2024team001", teamname: "我們這一隊", workid: "2024work001", teamtype: "創意實作",state: "報名待審核",consent: "1111"),
              Team(teamid: "2024team321", teamname: "你說都的隊", workid: "2024work001", teamtype: "創意實作",state: "已補件",affidavit: "1111",consent: "1111"),
              Team(teamid: "2024team456", teamname: "對對隊", workid: "2024work001", teamtype: "創意實作",state: "需補件",workintro: "1111"),
              Team(teamid: "2024team021", teamname: "不可能不隊", workid: "2024work001", teamtype: "創意實作",state: "已審核",affidavit: "1111"),
              Team(teamid: "2024team021", teamname: "不可能不隊", workid: "2024work001", teamtype: "創意實作",state: "待審核初賽資格",affidavit: "1111"),
              Team(teamid: "2024team091", teamname: "對啦隊", workid: "2024work001", teamtype: "創意實作",state: "初賽隊伍",consent: "1111",workintro: "1111"),
              Team(teamid: "2024team102", teamname: "感覺對了就隊", workid: "2024work001", teamtype: "創意實作",state: "決賽隊伍",workintro: "1111" ,consent: "1111",affidavit: "1111")
              ];
      widget.onUpdateTeams(teams);
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        const Text("年份",style: TextStyle(fontSize: 16),),
        const SizedBox(width: 10,),
        DropdownButton(
          value: _selectedyears,
          icon: const Icon(Icons.keyboard_arrow_down),
          dropdownColor: Colors.white,
          onChanged: (String? value) {
            setState((){
              _selectedyears = value!;
            });
          },
          items: widget.years.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
        const Spacer(),
        const Text("隊伍組別",style: TextStyle(fontSize: 16)),
        const SizedBox(width: 10,),
        DropdownButton(
          value: _selectedteamtype,
          icon: const Icon(Icons.keyboard_arrow_down),
          dropdownColor: Colors.white,
          onChanged: (String? value) {
            setState((){
              _selectedteamtype = value!;
            });
          },
          items: widget.teamtype.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
        const Spacer(),
        const Text("隊伍狀態",style: TextStyle(fontSize: 16)),
        const SizedBox(width: 10,),
        DropdownButton(
          value: _selectedteamstatus,
          icon: const Icon(Icons.keyboard_arrow_down),
          dropdownColor: Colors.white,
          onChanged: (String? value) {
            setState((){
              _selectedteamstatus = value!;
            });
          },
          items: widget.teamstaus.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: _search,
          child: const Text("查詢"),
        ),
        const Spacer()
      ],
    );
  }
}

class showTeams extends StatefulWidget{
  final List<Team> teams;
  const showTeams({super.key,required this.teams});

  @override
  State<showTeams> createState() => _showTeamState();
}

class _showTeamState extends State<showTeams>{

  @override
  Widget build(BuildContext context){
    return widget.teams.isEmpty ? const Center(child: CircularProgressIndicator()) :
    Expanded(
      child: ListView.builder(
        itemCount: widget.teams.length,
        itemBuilder: (context, index) {
          final team = widget.teams[index];
          return Card(
            color: team.state=="報名待審核"? Colors.grey.shade200:
                    team.state=="需補件"?Colors.red.shade100:
                    team.state=="已補件"?Colors.orange.shade100:
                    team.state=="待審核初賽資格"?Colors.grey.shade200:
                    team.state=="已審核"?Colors.green.shade100:
                    team.state=="初賽隊伍"?Colors.blue.shade100:Colors.blue.shade300
                    ,
            margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: ListTile(
              title: Text('${team.teamid}: ${team.teamname}'),
              subtitle: Text("隊伍狀態:${team.state}"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
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

class showDetailTeam extends StatefulWidget{
  const showDetailTeam({super.key, required this.teamid});
  final String teamid;
  
  @override
  State<showDetailTeam> createState()=> _showDetailTeamState();
}

class _showDetailTeamState extends State<showDetailTeam>{

  final AdminTeamService _adminTeamService = AdminTeamService();
  Team? team;//=Team(teamid: '2024team001', teamname: '我們這一對', teamtype: '報名待審核',consent: '1231454');
  List<Student>? stu;//=[
      //   Student(id: 'A1105546', name: '王大明', email: 'a1105546@mail.nuk.edu.tw', sexual: '男', phone: '0933556456', major: '資訊工程系', grade: '大四'),
      //   Student(id: 'A1113324', name: '陳曉慧', email: 'a1113324@mail.nuk.edu.tw', sexual: '女', phone: '0955777888', major: '資訊管理系', grade: '大三'),
      //   Student(id: 'A1124477', name: '呂又亮', email: 'a1124477@mail.nuk.edu.tw', sexual: '男', phone: '0933145346', major: '哈哈哈哈系', grade: '大二'),
      // ];
  Teacher? teacher;//=Teacher(id: 'dijfi@gmail.com', name: '張大業', email: 'dijfi@gmail.com', sexual: '男', phone: '0966444888');

  Future<void> fectchteamdetail() async{
    try{
      team= await _adminTeamService.getDetailTeam(widget.teamid);
      stu = await _adminTeamService.getTeamStudent(widget.teamid); 
      if(team!.teacheremail != null){
        teacher = await _adminTeamService.getTeamTeacher(team!.teacheremail!);
      }
    }
    catch(e){
      print('error:$e');
      setState(() {
        team= Team(teamid: '2024team001', teamname: '我們這一對', teamtype: '創意實作組',state: '報名待審核',worksummary: '你好我哈囉刮刮刮\n刮刮刮刮刮',teacheremail: "dijfi@gmail.com",worksdgs: '1,2,5',workyturl: 'https://www.google.com/');
      stu=[
        Student(id: 'A1105546', name: '王大明', email: 'a1105546@mail.nuk.edu.tw', sexual: '男', phone: '0933556456', major: '資訊工程系', grade: '大四'),
        Student(id: 'A1113324', name: '陳曉慧', email: 'a1113324@mail.nuk.edu.tw', sexual: '女', phone: '0955777888', major: '資訊管理系', grade: '大三'),
        Student(id: 'A1124477', name: '呂又亮', email: 'a1124477@mail.nuk.edu.tw', sexual: '男', phone: '0933145346', major: '哈哈哈哈系', grade: '大二'),
      ];
      teacher =Teacher(id: 'dijfi@gmail.com', name: '張大業', email: 'dijfi@gmail.com', sexual: '男', phone: '0966444888');
        
      });
    }
  }
  
  Future<void> fetchFile(String fileurl) async{
    if(await _adminTeamService.getFile(fileurl) != null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("無法下載檔案")));
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
  
  Future<void> editTeamState(String teamid,String originstate,String state) async{
    if(state == '通過'){
      if(originstate == '報名待審核'){
        await _adminTeamService.editTeamState(teamid, '已審核');
      }else{
        await _adminTeamService.editTeamState(teamid, '初賽隊伍');
      }
    }
    else{
      await _adminTeamService.editTeamState(teamid, '需補件');
    }
  }

  @override
  void initState(){
    super.initState();
    fectchteamdetail();
  }

  @override
  Widget build(BuildContext context){
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: team==null?const Center(child: CircularProgressIndicator()):
      SingleChildScrollView(
        child: Container(
          padding:const  EdgeInsets.all(50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("隊伍資訊",style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const Spacer(),
                  Text("隊伍ID: ${team!.teamid}",style: const TextStyle(fontSize: 18),),
                  const Spacer(),
                  Text("隊伍名稱: ${team!.teamname}",style: const TextStyle(fontSize: 18)),
                  const Spacer(),
                  Text("參賽組別: ${team!.teamtype}",style: const TextStyle(fontSize: 18),),
                  const Spacer(),
                  Text("隊伍狀態: ${team!.state}",style: const TextStyle(fontSize: 18)),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children:[
                  const Text('作品說明書：',style: TextStyle(fontSize: 18)),
                  TextButton(
                    onPressed: team!.workintro==null?null:()=>fetchFile(team!.workintro!),
                    child: Text(team!.workintro??'尚未上傳',style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue.shade600,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue.shade600 
                        )),
                  )
                ]
              ),
              const SizedBox(height: 10,),
              Row(
                children:[
                  const Text('切結書：',style: TextStyle(fontSize: 18)),
                  TextButton(
                    onPressed: team!.affidavit==null?null:()=>fetchFile(team!.affidavit!),
                    child: Text(team!.affidavit??'尚未上傳',style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue.shade600,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue.shade600 
                        )),
                  )
                ]
              ),
              const SizedBox(height: 10,),
              Row(
                children:[
                  const Text('個人資料同意書：',style: TextStyle(fontSize: 18)),
                  TextButton(
                    onPressed: team!.consent==null?null:()=>fetchFile(team!.consent!),
                    child: Text(team!.consent??'尚未上傳',style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue.shade600,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue.shade600  
                        )),
                  )
                ]
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const Spacer(),
                  Text("作品ID: ${team!.workid??'無'}",style: const TextStyle(fontSize: 18),),
                  const Spacer(),
                  Text("作品名稱: ${team!.workname??'無'}",style: const TextStyle(fontSize: 18)),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children:[
                  const Text('作品Youtube連結：',style: TextStyle(fontSize: 18)),
                  TextButton(
                    onPressed: team!.workyturl==null?null:()=>_launchUrl(team!.workyturl!),
                    child: Text(team!.workyturl??'無',style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue.shade600,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue.shade600  
                        )),
                  )
                ]
              ),
              const SizedBox(height: 10,),
              Row(
                children:[
                  const Text('作品github連結：',style: TextStyle(fontSize: 18)),
                  TextButton(
                    onPressed: team!.workgithub==null?null:()=>_launchUrl(team!.workgithub!),
                    child: Text(team!.workgithub??'無',style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue.shade600,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue.shade600  
                        )),
                  )
                ]
              ),
              const SizedBox(height: 10,),
              Row(
                children:[
                  const Text('作品相關SDGs：',style: TextStyle(fontSize: 18)),
                  team!.worksdgs==null?const Text('無',style: TextStyle(fontSize: 18)):
                  Row(
                  children: 
                    team!.worksdgs!.split(',').map((sdg)=>
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.asset('assets/images/SDGs_$sdg.png',width: 50,height: 50,fit: BoxFit.cover),
                      )).toList()
                  )
                ]
              ),
              const SizedBox(height: 10,),
              Container(alignment:Alignment.topLeft, child: const Text('作品說明：',style: TextStyle(fontSize: 18))),
              const SizedBox(height: 10,),
              Container(alignment: Alignment.topLeft, child: Text(team!.worksummary!)),
              const SizedBox(height: 20,),
              const Text("作品海報",style: TextStyle(fontSize: 18)),
              team!.workposter==null?const Text("無",style: TextStyle(fontSize: 18)):Image.network('http://localhost:8080/${team!.workposter}'),
              const SizedBox(height: 20,),
              const Text("指導老師",style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10,),
              team!.teacheremail == null ? const Text('無',style: TextStyle(fontSize: 20)) :
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.only(top: 15,bottom: 15,left: 15),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text(teacher!.name)),
                    Expanded(flex: 2, child: Text(teacher!.sexual)),
                    Expanded(flex: 4, child: Text(teacher!.trJobType??'無')),
                    Expanded(flex: 4, child: Text(teacher!.trDepartment??'無')),
                    Expanded(flex: 4, child: Text(teacher!.trOriganization??'無')),
                    Expanded(flex: 3, child: Text(teacher!.phone)),
                    Expanded(flex: 4, child: Text(teacher!.email)),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              const Text("隊員資料",style: TextStyle(fontSize: 20)),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: stu!.length,
                  itemBuilder: (context, index) {
                    final student = stu![index];
                    return Container(
                      decoration: BoxDecoration(
                        color: student.isLeader == null ? Colors.blueGrey.shade100:
                             student.isLeader ==true? Colors.blueGrey.shade100:Colors.blueGrey.shade100,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      margin: const EdgeInsets.only(top: 15,bottom: 15),
                      padding: const  EdgeInsets.only(top: 15,bottom: 15,left: 15) ,
                      child: Column(
                        children:[ 
                        Row(
                          children: [
                            Expanded(flex: 3, child: Text(student.name,)),
                            Expanded(flex: 3, child: Text(student.id)),
                            Expanded(flex: 2, child: Text(student.sexual)),
                            Expanded(flex: 3, child: Text(student.major)),
                            Expanded(flex: 3, child: Text(student.grade)),
                            Expanded(flex: 3, child: Text(student.phone)),
                            Expanded(flex: 5, child: Text(student.email)),
                          ],
                        ),
                        // Image.network('http://localhost:8080/${student.stuIdCard}'),

                        ]
                      )
                    );
                  },
                ),
              ),
              const SizedBox(height: 20,),
              if(authProvider.usertype=='admin' &&( team!.state=="報名待審核" || team!.state=="待審核初賽資格" || team!.state=="已補件"))
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed:() {
                        editTeamState(team!.teamid, team!.state!, '通過');
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("隊伍狀態已更新")));
                      }, 
                      child: const Text("審核通過")
                    ),
                    const SizedBox(width: 20,),
                    ElevatedButton(
                      onPressed:() {
                        editTeamState(team!.teamid, team!.state!, '不通過');
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("隊伍狀態已更新")));
                      }, 
                      child: const Text("審核不通過，需補件")
                    ),
                  ],
                )
              
            ],
          ),
        ),
      ),
    );
  
  }

}