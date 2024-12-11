import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:db_finalproject/ApiService.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'Navbar.dart';
import 'ApiService.dart';
import 'DataStruct.dart';


class AnnDetailPage extends StatefulWidget{
  final int AnnID;
  
  AnnDetailPage({required this.AnnID});

  @override
  _AnnDetailPageState createState()=> _AnnDetailPageState();
}

class _AnnDetailPageState extends State<AnnDetailPage>{
  final ApiService _apiService = ApiService();
  late AnnStruct AnnDetail;

  @override
  void initState() {
    super.initState();
    /*
      這裡測試連後端時要記得註解&解註解
    */
    AnnDetail = AnnStruct(id: 1,date:'2024-12-11', title: '我是測試資料1', info:'嗨嗨嗨嗨嗨嗨嗨嗨嗨嗨嗨',imageurl: '這是假的照片url',filename: '這是測試的檔案名稱',filedata: '123',filetype: '123');
    // fetchAnnDetails(widget.AnnID);
  }

  Future<void> fetchAnnDetails(int id) async {
    AnnStruct test1=AnnStruct(id: 1,date:'2024-12-11', title: '我是測試資料1', info:'嗨嗨嗨嗨嗨嗨嗨嗨嗨嗨嗨',imageurl: '這是假的照片url',filename: '這是測試的檔案名稱',filedata: '123',filetype: '123');
    try {
      AnnDetail = await _apiService.getAnnDetail(id);
      setState((){});
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
        child: Row(
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
                        child: Text(AnnDetail.date),
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

                  //還沒有實際照片檔案可以測試，所以先印出url
                  if(AnnDetail.imageurl!=null)
                    Container(
                      child: Text(AnnDetail.imageurl!),
                    ),
                    // Image.file(File(AnnDetail.imageurl!)),

                  //還沒有實際文件檔案可以測試，所以先印出文件名稱
                  if(AnnDetail.filename!=null && AnnDetail.filetype!=null && AnnDetail.filedata!=null)
                    Container(
                      child: Text(AnnDetail.filename!),
                    )
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