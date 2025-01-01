import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';

/*類似Adminmainpage中的隊伍資料，有更多功能，可以去查看隊伍的學生、老師、實際作品的檔案*/

class ContestData extends StatefulWidget{
  @override
  _ContestDataState createState() => _ContestDataState();
}

class _ContestDataState extends State<ContestData> {

 @override
  Widget build(BuildContext context){
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Navbar(),
      body:Stack(
        
        children:
        [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: authProvider.isSidebarOpen ? 250 : 0),
            child: selectBar()
          ),
          Sidebar()
        ]
      )
    );

  }
}

class selectBar extends StatefulWidget{
  final years=["2024","2023","2022","2021","2020","2019","2018","2017","2016","2015","2014","2013","2012"];
  final teamtype=["全組別","創意發想組","創業實作組"];
  final teamstaus=["無","待審核","已審核","需補件","已補件","初賽隊伍","決賽隊伍"];
  String _selectedyears="2024";
  String _selectedteamtype="全組別";
  String _selectedteamstatus="無";

  @override
  _selectedBarState createState() => _selectedBarState();
}

class _selectedBarState extends State<selectBar>{

  Future<void> _search() async{
    
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Text("年份",style: TextStyle(fontSize: 16),),
        SizedBox(width: 10,),
        DropdownButton(
          value: widget._selectedyears,
          icon: Icon(Icons.keyboard_arrow_down),
          dropdownColor: Colors.white,
          onChanged: (String? value) {
            print(value);
            setState((){
              widget._selectedyears = value!;
            });
          },
          items: widget.years.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
        Spacer(),
        Text("隊伍組別",style: TextStyle(fontSize: 16)),
        SizedBox(width: 10,),
        DropdownButton(
          value: widget._selectedteamtype,
          icon: Icon(Icons.keyboard_arrow_down),
          dropdownColor: Colors.white,
          onChanged: (String? value) {
            print(value);
            setState((){
              widget._selectedteamtype = value!;
            });
          },
          items: widget.teamtype.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
        Spacer(),
        Text("隊伍狀態",style: TextStyle(fontSize: 16)),
        SizedBox(width: 10,),
        DropdownButton(
          value: widget._selectedteamstatus,
          icon: Icon(Icons.keyboard_arrow_down),
          dropdownColor: Colors.white,
          onChanged: (String? value) {
            print(value);
            setState((){
              widget._selectedteamstatus = value!;
            });
          },
          items: widget.teamstaus.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
        Spacer(),
        ElevatedButton(
          onPressed: (){},
          child: Text("查詢"),
        ),
        Spacer()
      ],
    );
  }
}