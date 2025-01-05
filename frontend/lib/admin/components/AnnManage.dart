import 'package:db_finalproject/UploadFile.dart';
import 'package:db_finalproject/UploadImg.dart';
import 'package:db_finalproject/admin/logic/AdminAnnService.dart';
import 'package:db_finalproject/common/logic/AnnouncementService.dart';
import 'package:db_finalproject/data/Announcement.dart';
import 'package:db_finalproject/widgets/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/widgets/Sidebar.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:html' as html;

class AnnManage extends StatefulWidget {
  const AnnManage({super.key});

  @override
  State<AnnManage> createState() => _AnnManageState();
}

class _AnnManageState extends State<AnnManage> {
  final AnnouncementService _announcementService = AnnouncementService();
  // 模擬的公告資料
  List<Announcement> announcement=[];

  Future<void> fetchBasicAllAnnouncement() async{
    try{
      announcement = await _announcementService.getBasicAnnouncement();
      setState(() {});
    }catch(e){
      print(e);
      announcement=[
        Announcement(id: 1, date: '2024-12-15', title: '公告標題 1'),
        Announcement(id: 2, date: '2024-12-10', title: '公告標題 2'),
        Announcement(id: 3, date: '2024-12-05', title: '公告標題 3')
      ];
      setState(() {});
    }
  }

  @override
  void initState(){
    super.initState();
    fetchBasicAllAnnouncement();
  }


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Navbar(),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: authProvider.isSidebarOpen ? 250 : 0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children:[ 
                        const Padding(padding: EdgeInsets.only(left: 15)),
                        const Text(
                          "公告管理頁",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed:(){
                            html.window.open(
                              '/#/ann/add&edit', // 新視窗的網址
                              'AddAnnouncement',      // 視窗名稱（用於管理視窗實例）
                              'width=1000,height=720,left=200,top=100', // 視窗屬性
                            );
                          } ,
                          child: const Row(
                            children: [
                              Icon(Icons.add_box_outlined,color: Colors.black,),
                              Text("新增公告",style: TextStyle(fontSize: 16),)
                            ],
                          )), 
                      ]
                    ),
                    const SizedBox(height: 20),
                    announcement.isEmpty?const Center(child: CircularProgressIndicator()):
                    SizedBox(
                      width: double.maxFinite,
                      height: 720,
                      child: ListView.builder(
                        itemCount: announcement.length,
                        itemBuilder: (context, index) {
                          final ann = announcement[index];
                          return Card(
                            color: Colors.grey.shade200,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(ann.title),
                              subtitle: Text("發布日期: ${ann.date}"),
                              trailing: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  html.window.open(
                                    '/#/ann/add&edit?annid=${ann.id}', // 新視窗的網址
                                    'AddAnnouncement',      // 視窗名稱（用於管理視窗實例）
                                    'width=1000,height=720,left=200,top=100', // 視窗屬性
                                  );
                                } ,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Sidebar(),
        ],
      ),
    );
  }
}

class AddNEditAnnouncement extends StatefulWidget {
  final String annid;

  const AddNEditAnnouncement({super.key, required this.annid});

  @override
  State<AddNEditAnnouncement> createState() => _AddNEditAnnouncementState();
}

class _AddNEditAnnouncementState extends State<AddNEditAnnouncement> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  List<PlatformFile> _selectedFiles = [];
  List<PlatformFile> _selectedImgs = [];
  // File? _attachmentFile;
  final AdminAnnService _adminAnnService = AdminAnnService();
  final AnnouncementService _announcementService = AnnouncementService();
  Announcement ann=Announcement(id: -1, title: '');

  @override
  void initState() {
    super.initState();
    if(widget.annid != '-1'){
      fetchAnnDetail();
    }
  }

  Future<void> fetchAnnDetail() async{
    try{
      ann = await _announcementService.getDetailAnnouncemnet(int.parse(widget.annid));
      // print('Fetched ${ann!} announcements');
    }
    catch(e){
      print('Error: fectch Announments');
    }
  }

  void handleFilesChanged(List<PlatformFile> files) {
    setState(() {
      _selectedFiles = files;
    });
  }

  void handleImagesChanged(List<PlatformFile> files) {
    setState(() {
      _selectedImgs = files;
    });
  }

  // 儲存修改的公告
  void _saveAnnouncement(String admin) {
    setState(() {
      ann=Announcement(
        id: int.parse(widget.annid), 
        title: _titleController.text,
        info: _contentController.text,
        admin: admin
      );
    });
    
    if(widget.annid=='-1'){
      try{
        _adminAnnService.addAnnouncement(
          ann,
          _selectedFiles, 
          _selectedImgs);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              backgroundColor: Colors.white,
              title: Text("公告資料已新增，兩秒後關閉此視窗"),
            );
          },
        );
      }
      catch(e){
        _adminAnnService.editAnnouncement(
          ann,
          _selectedFiles, 
          _selectedImgs);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              backgroundColor: Colors.white,
              title: Text("公告資料新增失敗"),
            );
          },
        );
      }
      
    }
    else{
      try{
        _adminAnnService.editAnnouncement(
          Announcement(id: int.parse(widget.annid), title: _titleController.text, info: _contentController.text),
          _selectedFiles, 
          _selectedImgs);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              backgroundColor: Colors.white,
              title: Text("公告資料已修改，兩秒後關閉此視窗"),
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
              title: Text("公告資料修改失敗"),
            );
          },
        );
      }
    }
    Future.delayed(Duration(seconds: 2), () {
      html.window.close();
    });
  }


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.annid=='-1'?"新增公告":"修改公告",style: const TextStyle(fontSize: 24),),
              TextField(
                controller: _titleController..text= ann.title,
                decoration: const InputDecoration(labelText: "公告標題"),
              ),
              const SizedBox(height: 20,),
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: null,
                controller: _contentController..text = ann.info??'',
                decoration: const InputDecoration(
                  hintText: "公告內容",
                  border: OutlineInputBorder()
                  ),
              ),
              const SizedBox(height: 20,),
              UploadImgs(onImagesChanged: handleImagesChanged),
              const SizedBox(height: 20,),
              UploadFiles(onFilesChanged: handleFilesChanged),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()=>_saveAnnouncement(authProvider.useraccount),
                child: Text(widget.annid=='-1'?"新增公告":"修改公告"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}