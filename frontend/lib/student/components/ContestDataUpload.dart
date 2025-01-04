import 'package:db_finalproject/UploadFile.dart';
import 'package:db_finalproject/UploadImg.dart';
import 'package:db_finalproject/student/logic/SutTeamService.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadWorkData extends StatefulWidget {
  const UploadWorkData({super.key});

  @override
  State<UploadWorkData> createState() => _UploadWorkDataState();
}

class _UploadWorkDataState extends State<UploadWorkData> {
  final TextEditingController _yturl = TextEditingController();
  final TextEditingController _githuburl = TextEditingController();
  PlatformFile workposter=PlatformFile(name: '', size: 0);
  PlatformFile workintro=PlatformFile(name: '', size: 0);
  PlatformFile affidavit=PlatformFile(name: '', size: 0);
  PlatformFile consent=PlatformFile(name: '', size: 0);
  String cloud_poster='';
  String cloud_workintro='';
  String cloud_affidavit='';
  String cloud_consent='';

  String teamid='';
  String workid='';

  final StuTeamService _stuTeamService = StuTeamService();

  void handleImagesChanged(List<PlatformFile> files){
    workposter = files.first;
  }

  void handleFilesChanged(PlatformFile thisfile,List<PlatformFile> files){
    thisfile = files.first;
  }

  Future<void> fetchStuTeamNWorkId(String stuid) async{
    try{
      teamid = await _stuTeamService.getStudentTeamId(stuid);
      workid = await _stuTeamService.getStudentWorkId(stuid);
      setState(() {});
    }catch(e){
      print(e);
    }
  }

  Future<void> fetchStuteamNworkfile() async{
    try{
      List<String> response = await _stuTeamService.getStudentTeamfiles(teamid);
      cloud_affidavit = response[0];
      cloud_consent = response[1];
      response = await _stuTeamService.getStudentWorkfiles(workid);
      cloud_workintro = response[0];
      cloud_poster = response[1];
      setState(() {});
    }catch(e){
      print(e);
    }
  }

  Future<void> _saveChanges() async{
    try{
      await _stuTeamService.uploadWorkNTeamfileNurl(
          teamid, workid, [affidavit,consent], workintro, workposter, 
          {'workyturl': _yturl.text, 'workgithub': _githuburl});
    }catch(e){
      print(e);
    }
  }

  @override
  void initState(){
    Future.microtask(() {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.usertype == 'stu' && authProvider.useraccount != 'none') {
        fetchStuTeamNWorkId(authProvider.useraccount);
      }  
    });
    // if(teamid.contains('team')){
    //   fetchStuteamNworkfile();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final scrSize = MediaQuery.of(context).size;
    final double screenWidth = scrSize.width-250;
    bool iswidthful = screenWidth > 850 ? true : false;
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Navbar(),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: authProvider.isSidebarOpen ? 250 : 0),
            child: SizedBox(
              child: SingleChildScrollView(
                child:SafeArea(
                  child: Row(
                    children: [

                      if(iswidthful)
                        Flexible(flex: 1, child: Container(color: Colors.transparent)),
                      
                      Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 20)),

                          SizedBox(
                            height: 40,
                            width: screenWidth>850?850:screenWidth*0.9,
                            child: TextField(
                              controller: _yturl,
                              decoration: const InputDecoration(
                                labelText: '作品影片YT連結',
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(fontSize: 18)
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          SizedBox(
                            height: 40,
                            width: screenWidth>850?850:screenWidth*0.9,
                            child: TextField(
                              controller: _githuburl,
                              decoration: const InputDecoration(
                                labelText: '程式碼GitHub連結',
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(fontSize: 18)
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          if(cloud_poster.isNotEmpty)
                            Column(
                              children: [
                                Image.network('https://8080/api/$cloud_poster'),
                                ElevatedButton(
                                  onPressed: (){}, 
                                  child: const Text("刪除",style: TextStyle(fontSize: 16),)
                                )
                              ],
                          ),

                          SizedBox(
                            width: screenWidth>850?850:screenWidth*0.9,
                            child: UploadImgs(max: 1,title: '選擇作品海報', onImagesChanged: handleImagesChanged)
                          ),

                          const SizedBox(height: 20,),
                          SizedBox(
                            width: screenWidth>850?850:screenWidth*0.9,
                            child: UploadFiles(max: 1,title: '作品說明書上傳區', onFilesChanged: (files)=>handleFilesChanged(workintro, files),)
                          ),

                          const SizedBox(height: 20,),

                          SizedBox(
                            width: screenWidth>850?850:screenWidth*0.9,
                            child: UploadFiles(max: 1,title: '提案切結書上傳區', onFilesChanged: (files)=>handleFilesChanged(affidavit, files),)
                          ), 

                          const SizedBox(height: 20,),
                          SizedBox(
                            width: screenWidth>850?850:screenWidth*0.9,
                            child: UploadFiles(max: 1,title: '個資同意書上傳區', onFilesChanged: (files)=>handleFilesChanged(consent, files),)
                          ),   

                          const SizedBox(height: 20,),

                          ElevatedButton(
                            onPressed: _saveChanges, 
                            child: const Text("新增文件",style: TextStyle(fontSize: 16),)
                          )                    

                        ],
                      ),
                      

                      if(iswidthful)
                        Flexible(flex: 1, child: Container(color: Colors.transparent)),
                    ],
                  )
              )
              ),
            )
          ),
          Sidebar()
        ],
      ),
    );
  }
}
