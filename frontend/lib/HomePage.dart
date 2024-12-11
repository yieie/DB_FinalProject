import 'package:carousel_slider/carousel_slider.dart';
import 'package:db_finalproject/AnnDetailPage.dart';
import 'package:db_finalproject/ApiService.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'Navbar.dart';
import 'ApiService.dart';
import 'DataStruct.dart';
import 'AnnDetailPage.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrSize = MediaQuery.of(context).size;
    final double screenWidth = scrSize.width;
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: const Navbar(),
          body: CarouselSlidePage(width: screenWidth)
    );
  }
}

class CarouselSlidePage extends StatelessWidget{
  CarouselSlidePage({required this.width});
  final double width;
  
  @override
  Widget build(BuildContext context) {
    bool iswidthful = width > 1000 ? true : false;
    return  SafeArea(
        child: Row(
          children: [

            if(iswidthful)
              Flexible(flex: 1, child: Container(color: Colors.transparent)),
            
            Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 20)),

                SizedBox(
                  width: iswidthful?1000:width,
                  child: CarouselSlide(
                    didSelected: (int index) {
                      print("didTapped $index");
                    },
                   ),
                ),

                Padding(padding: EdgeInsets.only(top: 20)),

                SizedBox(
                  width:iswidthful?1000:width,
                  child: LatestAnn(),
                )

              ],
            ),
            

            if(iswidthful)
              Flexible(flex: 1, child: Container(color: Colors.transparent)),
          ],
        )
    );
  }
}

class CarouselSlide extends StatelessWidget {
  CarouselSlide({
    super.key,
    required this.didSelected
  });
  final Function(int index) didSelected;

  @override
  Widget build(BuildContext context){
    return CarouselSlider(
      options:CarouselOptions(
        aspectRatio: 30/12,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
      ),
      items: List<Widget>.generate(5,(int index){
        return GestureDetector(
          onTap: () => didSelected(index),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(color: Colors.transparent),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      color: Colors.primaries[
                          Random().nextInt(Colors.primaries.length)]),
                ),
                Positioned(
                  child: Text(
                    "$index",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

//最新公告，表格上只會顯示data、title，其他資訊要點進去才看得到(還沒寫)
class LatestAnn extends StatefulWidget{
  const LatestAnn({super.key});

  @override
  _LastestAnnState createState() => _LastestAnnState();
}

class _LastestAnnState extends State<LatestAnn>{
  final ApiService _apiService = ApiService();
  List<AnnStruct> AnnList = [];

  Future<void> fetchAnnouncements() async {
    AnnStruct test1=AnnStruct(id: 1,date: '2024-12-11',title: '我是測試資料1');
    AnnStruct test2=AnnStruct(id: 2,date: '2024-12-10',title: '我是測試資料1');
    try {
      AnnList = await _apiService.getAnnBasic();
      setState((){});
      // 更新 UI 或處理邏輯
      print('Fetched ${AnnList!.length} announcements');
    } catch (e) {
      print('Error: $e');
      setState((){
        AnnList = [test1,test2];
      });
    }
  }

   @override
  void initState() {
    super.initState();
    fetchAnnouncements(); // 在初始化時開始異步加載資料
  }

  @override
  Widget build(BuildContext context) {
    bool _hoveredRowIndex=false;
    // print("AnnList:");
    // print(AnnList.isNotEmpty ? AnnList.first.date : "No data");
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 10,bottom: 10),
          child: Text(
            "最新消息",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          height: 2,
          color: Colors.black26,
        ),
        AnnList.isEmpty
            ? Center(child: CircularProgressIndicator()) // 顯示載入中
            : Table(
                children: AnnList.map((item) => TableRow(children: [
                    InkWell(
                        onHover: (hovering){
                          setState(() {
                            _hoveredRowIndex = hovering;
                          });
                        },
                        onTap: () {
                          print(item.title);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnnDetailPage(AnnID: item.id),
                            ),
                          );

                        } ,
                        child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top:16.0,left: 10.0,right:32.0,bottom: 16.0),
                                child: Text(
                                  item.date,
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w100),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  item.title,
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                                  ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.only(right:16.0),
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                      ),
                ])).toList(),
              ),
      ],
    );
  }
}