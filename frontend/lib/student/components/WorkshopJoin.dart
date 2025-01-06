import 'package:db_finalproject/student/logic/StuWorkshopService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'package:db_finalproject/data/Workshop.dart';
import 'package:db_finalproject/core/services/ApiService.dart';

class WorkshopJoin extends StatefulWidget {
  const WorkshopJoin({super.key});
  @override
  State<WorkshopJoin> createState() => _WorkshopJoinState();
}

class _WorkshopJoinState extends State<WorkshopJoin> {

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

                    showWorkshop(screenWidth: screenWidth),

                    if(iswidthful)
                      Flexible(flex: 1, child: Container(color: Colors.transparent))
                  ],
                )
              )
            ),
          ),
          const Sidebar()
        ],
      ),
    );
  }
}

class showWorkshop extends StatefulWidget{
  final double screenWidth;
  const showWorkshop({super.key, required this.screenWidth});

  @override
  State<showWorkshop> createState() => _showWorkshopState();
}

class _showWorkshopState extends State<showWorkshop>{
  List<Workshop>? workshops;
  final StuWorkshopservice _stuWorkshopservice = StuWorkshopservice();

  Future<void> fetchWorkshops() async {
    try {
      workshops = await _stuWorkshopservice.getAllWorkshop();
      setState(() {});
    } catch (e) {
      print('Error fetching workshops: $e');
      setState(() {
        workshops = [
          Workshop(wsid: 1, wsdate: "2024-01-15", wstime: "10:00 AM", wstopic: "AI Basics",lectName: '王大強',lecttitle: '哈哈哈哈'),
          Workshop(wsid: 2, wsdate: "2024-01-20", wstime: "2:00 PM", wstopic: "Flutter Development",lectName: '王曉強',lecttitle: '嘎嘎嘎嘎嘎'),
        ];
      });
    }
  }

  Future<void> registerWorkshop(int wsid,String stuid) async {
    try {
      await _stuWorkshopservice.registerWorkshop(wsid, stuid);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("成功報名工作坊!"))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("失敗"))
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWorkshops();
  }
  
  @override
  Widget build(BuildContext context){
    final authProvider = Provider.of<AuthProvider>(context);
    return SizedBox(
      width: widget.screenWidth>850?850:widget.screenWidth*0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "報名工作坊",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          workshops == null
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              width: double.maxFinite,
              height: 400, // 設定適當的高度，避免高度無限制
              child: ListView.builder(
                itemCount: workshops!.length,
                itemBuilder: (context, index) {
                  final workshop = workshops![index];
                  return Container(
                    margin: const EdgeInsets.only(top: 5,bottom: 5),
                    child: Card(
                      color: Colors.grey.shade200,
                      child: ListTile(
                        title: Text(workshop.wstopic),
                        subtitle: Text('時間:${workshop.wsdate} ${workshop.wstime}\n演講者:${workshop.lectName??''} ${workshop.lecttitle??''}'),
                        isThreeLine: true,
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey.shade100,
                            foregroundColor: Colors.black
                          ),
                          onPressed: () => registerWorkshop(workshop.wsid,authProvider.useraccount),
                          child: const Text("報名"),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
