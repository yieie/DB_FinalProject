import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/data/Workshop.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'package:db_finalproject/admin/logic/WorkshopService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

class WorkshopDataFrame extends StatelessWidget {
  WorkshopDataFrame({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final scrSize = MediaQuery.of(context).size;
    final double screenWidth = scrSize.width;
    bool iswidthful = screenWidth > 1000;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Navbar(), // Navbar 應確保返回 PreferredSizeWidget
      body: Stack(
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
                        SizedBox(height: 20),
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
  @override
  _WorkshopDataState createState() => _WorkshopDataState();
}

class _WorkshopDataState extends State<WorkshopData> {
  List<Workshop>? workshops;

  WorkshopService _workshopService = WorkshopService();

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
              Padding(padding: EdgeInsets.only(left: 15)),
              Text(
                "工作坊管理頁",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              TextButton(
                onPressed:(){
                  html.window.open(
                    '/#/ws/add&edit', // 新視窗的網址
                    'AddWorkshop',      // 視窗名稱（用於管理視窗實例）
                    'width=1000,height=720,left=200,top=100', // 視窗屬性
                  );
                } ,
                child: Row(
                  children: [
                    Icon(Icons.add_box_outlined,color: Colors.black,),
                    Text("新增工作坊",style: TextStyle(fontSize: 16),)
                  ],
                )), 
            ]
          ),
          SizedBox(height: 20),
          workshops == null ? Center(child: CircularProgressIndicator()) : Expanded(
            child: ListView.builder(
              itemCount: workshops!.length,
              itemBuilder: (context, index) {
                final workshop = workshops![index];
                return Card(
                  color: Colors.grey.shade200,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(workshop.wstopic),
                    subtitle: Row(
                      children: [
                        Text('時間： ${workshop.wsdate} ${workshop.wstime}'),
                        Spacer(),
                        Text('講師： ${workshop.lectName}'),
                        Spacer()
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
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
  final wsid;
  AddNEditWorkshopForm({super.key,required this.wsid});

  @override
  _AddNEditWorkshopFormState createState() => _AddNEditWorkshopFormState();
}

class _AddNEditWorkshopFormState extends State<AddNEditWorkshopForm> {
  TextEditingController? _topicController;
  TimeOfDay? selectedTime;
  String formattime="";
  DateTime? selectedDate;
  TextEditingController? _lectnameController;
  TextEditingController? _lectphoneController;
  TextEditingController? _lectemailController;
  TextEditingController? _lecttitleController;
  TextEditingController? _lectaddrController;

  WorkshopService _workshopService = WorkshopService();
  Workshop workshop= Workshop(wsid: -1, wsdate: '', wstime: '', wstopic: '');
  // 儲存修改的資料
  Future<void> _saveChanges() async{
    setState(() {
      workshop=Workshop(
        wsid: int.parse(widget.wsid), 
        wsdate: "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}", 
        wstime: formattime, 
        wstopic: _topicController!.text,
        lectName: _lectnameController!.text,
        lectphone: _lectphoneController!.text,
        lectemail: _lectemailController!.text,
        lecttitle: _lecttitleController!.text,
        lectaddr: _lectaddrController!.text
      );
    });
    print(workshop.wsid);
    print(workshop.wsdate);
    print(workshop.wstime);
    print(workshop.wstopic);
    print(workshop.lectName);
    print(workshop.lectaddr);
    print(workshop.lectemail);
    print(workshop.lectphone);
    print(workshop.lecttitle);
    if(widget.wsid=='-1'){
      try{
        _workshopService.addWorkshop(workshop);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
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
            return AlertDialog(
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
            return AlertDialog(
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
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text("工作坊資料修改失敗"),
            );
          },
        );
      }
    }
    Future.delayed(Duration(seconds: 2), () {
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
      print(picked);
      setState(() {
        selectedDate = picked;
      });
      print(selectedDate);
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
      setState(() {});
    }
    catch(e){
      setState(() {});
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.wsid);
    if(widget.wsid != '-1'){
      fectchWorkshop();
    }

    _topicController = TextEditingController(text: workshop.wstopic);
    _lectnameController = TextEditingController(text: workshop.lectName??'');
    _lectphoneController = TextEditingController(text: workshop.lectphone??'');
    _lectemailController = TextEditingController(text: workshop.lectemail??'');
    _lecttitleController = TextEditingController(text: workshop.lecttitle??'');
    _lectaddrController = TextEditingController(text: workshop.lectaddr??'');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.wsid=='-1'?"新增工作坊":"修改工作坊",style: TextStyle(fontSize: 24),),
            TextField(
              controller: _topicController,
              decoration: InputDecoration(labelText: "主題"),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Text(
                  "日期：",
                  style: TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text("選擇日期"),
                ),
                SizedBox(width: 20,),
                Text(
                  selectedDate != null
                      ? "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}"
                      : workshop.wsdate,
                  style: TextStyle(fontSize: 16),
                ),
              ]
            ),
            SizedBox(height: 10),
            Container(height: 1,color: Colors.grey.shade500,),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "時間：",
                  style: TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: Text("選擇時間"),
                ),
                SizedBox(width: 20,),
                Text(
                  selectedTime != null
                      ? formattime
                      : workshop.wstime,
                  style: TextStyle(fontSize: 16),
                ),
              ]
            ),
            TextField(
              controller: _lectnameController,
              decoration: InputDecoration(labelText: "講師姓名"),
            ),
            TextField(
              controller: _lectemailController,
              decoration: InputDecoration(labelText: "講師Email"),
            ),
            TextField(
              controller: _lectphoneController,
              decoration: InputDecoration(labelText: "講師電話"),
            ),
            TextField(
              controller: _lecttitleController,
              decoration: InputDecoration(labelText: "講師頭銜"),
            ),
            TextField(
              controller: _lectaddrController,
              decoration: InputDecoration(labelText: "講師地址"),
            ),
            SizedBox(height: 20),
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