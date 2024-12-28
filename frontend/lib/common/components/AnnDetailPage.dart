import 'dart:io';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:db_finalproject/core/services/ApiService.dart';
import 'package:db_finalproject/data/Announcement.dart';
import 'package:db_finalproject/common/logic/AnnouncementService.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';


class AnnDetailPage extends StatefulWidget{
  final int AnnID;
  
  AnnDetailPage({required this.AnnID});

  @override
  _AnnDetailPageState createState()=> _AnnDetailPageState();
}

class _AnnDetailPageState extends State<AnnDetailPage>{
  bool _isLoading = true;
  final AnnouncementService _announcementService = AnnouncementService();
  late Announcement AnnDetail;

  @override
  void initState() {
    super.initState();
    /*
      這裡測試連後端時要記得註解&解註解
    */
    // AnnDetail = Announcement(id: 1,date:'2024-12-11', title: '我是測試資料1', info:'嗨嗨嗨嗨嗨嗨嗨嗨嗨嗨嗨',imageurl: '這是假的照片url',filename: '這是測試的檔案名稱',filedata: '123',filetype: '123');
    fetchAnnDetails(widget.AnnID);
  }

  Future<void> fetchAnnDetails(int id) async {
    Announcement test1=Announcement(id: 1,date:'2024-12-11', title: '我是測試資料1', info:'嗨嗨嗨嗨嗨嗨嗨嗨嗨嗨嗨');
    try {
      await Future.delayed(Duration(seconds: 2));
      AnnDetail = await _announcementService.getDetailAnnouncemnet(id);
      setState((){
        _isLoading = false;
      });
      // 更新 UI 或處理邏輯
      print('Fetched ${AnnDetail!} announcements');
    } catch (e) {
      print('Error: $e');
      setState((){
        AnnDetail = test1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scrSize = MediaQuery.of(context).size;
    final double screenWidth = scrSize.width;
    bool iswidthful = scrSize.width > 1000 ? true : false;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Navbar(),
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator()) // 顯示加載指示器
            :Row(
          children: [

            if(iswidthful)
              Flexible(flex: 1, child: Container(color: Colors.transparent)),
            
            SizedBox(
              
              width: iswidthful?1000:screenWidth,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        alignment: Alignment.bottomLeft,
                        child: 
                          Text(
                            AnnDetail.title,
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                          )
                      ),
                      Spacer(),
                      Container(
                        height: 50,
                        alignment: Alignment.bottomRight,
                        child: Text(AnnDetail.date!),
                      ),

                      
                    ],
                  ),
                  Container(
                    height: 2,
                    color: Colors.black26,
                  ),
                  Container(
                    padding: EdgeInsets.only(top:10),
                    alignment: Alignment.topLeft,
                    child: Text(AnnDetail.info!),
                  ),

                  // if(AnnDetail.imageurl!=null)
                    // Image.network('http://localhost:8081/images/testpic1.png'),

                  //還沒有實際文件檔案可以測試，所以先印出文件名稱
                  // if(AnnDetail.filename!=null && AnnDetail.filetype!=null && AnnDetail.filedata!=null)
                  //   Container(
                  //     child: Text(AnnDetail.filename!),
                  //   )
                ],
              ),
            ),
            

            if(iswidthful)
              Flexible(flex: 1, child: Container(color: Colors.transparent)),
          ],
        )
      )
    );
  }
}