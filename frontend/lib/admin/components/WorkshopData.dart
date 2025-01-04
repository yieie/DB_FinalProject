import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/data/Workshop.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'package:db_finalproject/admin/logic/WorkshopService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

class WorkshopDataFrame extends StatelessWidget {
  const WorkshopDataFrame({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final scrSize = MediaQuery.of(context).size;
    final double screenWidth = scrSize.width;
    bool iswidthful = screenWidth > 1000;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Navbar(), // Navbar 應確保返回 PreferredSizeWidget
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: authProvider.isSidebarOpen ? 250 : 0),
            child: SafeArea(
              child: Row(
                children: [
                  if (iswidthful)
                    Flexible(flex: 1, child: Container(color: Colors.transparent)),

                  const Expanded(
                    flex: 5, // 調整比例使內容區域大小正確
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        WorkshopData(), // 呼叫子小部件顯示數據
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
      ),
    );
  }
}

class WorkshopData extends StatefulWidget {
  const WorkshopData({super.key});

  @override
  State<WorkshopData> createState() => _WorkshopDataState();
}

class _WorkshopDataState extends State<WorkshopData> {
  List<Workshop>? workshops;

  final WorkshopService _workshopService = WorkshopService();

  Future<void> fetchAllWorkshop() async{
    try{
      workshops = await _workshopService.getAllWorkshop();
      setState(() {});
    }catch(e){
      print(e);
      workshops = [
        Workshop(wsid: 1, wsdate: "2024-12-25", wstime: "9:00", wstopic: "創造力", lectName: "王老師"),
        Workshop(wsid: 2, wsdate: "2024-12-25", wstime: "10:00", wstopic: "實現力", lectName: "李教授"),
      ];
    }
  }

  @override
  void initState(){
    super.initState();
    fetchAllWorkshop();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          
          Row(
            children:[ 
              const Padding(padding: EdgeInsets.only(left: 15)),
              const Text(
                "工作坊管理頁",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                onPressed:(){
                  html.window.open(
                    '/#/ws/add&edit', // 新視窗的網址
                    'AddWorkshop',      // 視窗名稱（用於管理視窗實例）
                    'width=1000,height=720,left=200,top=100', // 視窗屬性
                  );
                } ,
                child: const Row(
                  children: [
                    Icon(Icons.add_box_outlined,color: Colors.black,),
                    Text("新增工作坊",style: TextStyle(fontSize: 16),)
                  ],
                )), 
            ]
          ),
          const SizedBox(height: 20),
          workshops == null ? const Center(child: CircularProgressIndicator()) : Expanded(
            child: ListView.builder(
              itemCount: workshops!.length,
              itemBuilder: (context, index) {
                final workshop = workshops![index];
                return Card(
                  color: Colors.grey.shade200,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(workshop.wstopic),
                    subtitle: Row(
                      children: [
                        Text('時間： ${workshop.wsdate} ${workshop.wstime}'),
                        const Spacer(),
                        Text('講師： ${workshop.lectName}'),
                        const Spacer()
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        html.window.open(
                          '/#/ws/add&edit?wsid=${workshop.wsid}', // 新視窗的網址
                          'EditWorkshop',      // 視窗名稱（用於管理視窗實例）
                          'width=1000,height=720,left=200,top=100', // 視窗屬性
                        );
                      },
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



class AddNEditWorkshopForm extends StatefulWidget {
  final String wsid;
  const AddNEditWorkshopForm({super.key,required this.wsid});

  @override
  State<AddNEditWorkshopForm> createState() => _AddNEditWorkshopFormState();
}

class _AddNEditWorkshopFormState extends State<AddNEditWorkshopForm> {
  final _topicController = TextEditingController();
  TimeOfDay? selectedTime;
  String formattime="";
  DateTime? selectedDate;
  final _lectnameController = TextEditingController();
  final _lectphoneController = TextEditingController();
  final _lectemailController = TextEditingController();
  final _lecttitleController = TextEditingController();
  final _lectaddrController = TextEditingController();

  final WorkshopService _workshopService = WorkshopService();
  Workshop workshop= Workshop(wsid: -1, wsdate: '', wstime: '', wstopic: '');
  // 儲存修改的資料
  Future<void> _saveChanges() async{
    setState(() {
      workshop=Workshop(
        wsid: int.parse(widget.wsid), 
        wsdate: "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}", 
        wstime: formattime, 
        wstopic: _topicController.text,
        lectName: _lectnameController.text,
        lectphone: _lectphoneController.text,
        lectemail: _lectemailController.text,
        lecttitle: _lecttitleController.text,
        lectaddr: _lectaddrController.text
      );
    });
    if(widget.wsid=='-1'){
      try{
        _workshopService.addWorkshop(workshop);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              backgroundColor: Colors.white,
              title: Text("工作坊資料已新增，兩秒後關閉此視窗"),
            );
          },
        );
      }
      catch(e){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              backgroundColor: Colors.white,
              title: Text("工作坊資料新增失敗"),
            );
          },
        );
      }
      
    }
    else{
      try{
        _workshopService.editWorkshop(workshop);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              backgroundColor: Colors.white,
              title: Text("工作坊資料已修改，兩秒後關閉此視窗"),
            );
          },
        );
      }
      catch(e){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              backgroundColor: Colors.white,
              title: Text("工作坊資料修改失敗"),
            );
          },
        );
      }
    }
    Future.delayed(const Duration(seconds: 2), () {
      html.window.close();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // 預設日期
      firstDate: DateTime(2000),  // 可選的最早日期
      lastDate: DateTime(2100),  // 可選的最晚日期
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        formattime=formatTimeOfDay(selectedTime!);
      });
    }
  }


  String formatTimeOfDay(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  Future<void> fectchWorkshop() async{
    try{
      workshop = await _workshopService.getWorkshop(widget.wsid);
    }
    catch(e){
      print('Error: fectch Announments');
    }
  }

  @override
  void initState() {
    super.initState();
    if(widget.wsid != '-1'){
      fectchWorkshop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.wsid=='-1'?"新增工作坊":"修改工作坊",style: const TextStyle(fontSize: 24),),
            TextField(
              controller: _topicController..text=workshop.wstopic,
              decoration: const InputDecoration(labelText: "主題"),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                const Text(
                  "日期：",
                  style: TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text("選擇日期"),
                ),
                const SizedBox(width: 20,),
                Text(
                  selectedDate != null
                      ? "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}"
                      : workshop.wsdate,
                  style: const TextStyle(fontSize: 16),
                ),
              ]
            ),
            const  SizedBox(height: 10),
            Container(height: 1,color: Colors.grey.shade500,),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "時間：",
                  style: TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: const Text("選擇時間"),
                ),
                const SizedBox(width: 20,),
                Text(
                  selectedTime != null
                      ? formattime
                      : workshop.wstime,
                  style: const TextStyle(fontSize: 16),
                ),
              ]
            ),
            TextField(
              controller: _lectnameController..text=workshop.lectName??'',
              decoration: const InputDecoration(labelText: "講師姓名"),
            ),
            TextField(
              controller: _lectemailController..text=workshop.lectemail??'',
              decoration: const InputDecoration(labelText: "講師Email"),
            ),
            TextField(
              controller: _lectphoneController..text=workshop.lectphone??'',
              decoration: const InputDecoration(labelText: "講師電話"),
            ),
            TextField(
              controller: _lecttitleController..text=workshop.lecttitle??'',
              decoration: const InputDecoration(labelText: "講師頭銜"),
            ),
            TextField(
              controller: _lectaddrController..text=workshop.lectaddr??'',
              decoration: const InputDecoration(labelText: "講師地址"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text(widget.wsid=='-1'?"新增工作坊":"修改工作坊"),
            ),
          ],
        ),
      ),
    );
  }
}