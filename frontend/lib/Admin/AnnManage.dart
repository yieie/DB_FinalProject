import 'package:db_finalproject/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/AuthProvider.dart';
import 'package:db_finalproject/Sidebar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AnnManage extends StatefulWidget {
  @override
  _AnnManageState createState() => _AnnManageState();
}

class _AnnManageState extends State<AnnManage> {
  // 模擬的公告資料
  final List<Map<String, String>> _announcements = [
    {"ID": "A001", "Title": "公告標題 1", "Date": "2024-12-15", "Publisher": "管理員"},
    {"ID": "A002", "Title": "公告標題 2", "Date": "2024-12-10", "Publisher": "管理員"},
    {"ID": "A003", "Title": "公告標題 3", "Date": "2024-12-05", "Publisher": "管理員"},
  ];

  // 點擊修改公告，跳轉到修改頁面
  void _navigateToEditAnnounce(BuildContext context, Map<String, String> announcement) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAnnouncePage(announcement: announcement),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Navbar(),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: authProvider.isSidebarOpen ? 250 : 0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "公告管理頁",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _announcements.length,
                      itemBuilder: (context, index) {
                        final announcement = _announcements[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(announcement["Title"]!),
                            subtitle: Text("發布日期: ${announcement["Date"]!}"),
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => _navigateToEditAnnounce(context, announcement),
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
          Sidebar(),
        ],
      ),
    );
  }
}

class EditAnnouncePage extends StatefulWidget {
  final Map<String, String> announcement;

  EditAnnouncePage({required this.announcement});

  @override
  _EditAnnouncePageState createState() => _EditAnnouncePageState();
}

class _EditAnnouncePageState extends State<EditAnnouncePage> {
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _contentController = TextEditingController();
  File? _attachmentFile;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.announcement["Title"]!;
    _dateController.text = widget.announcement["Date"]!;
  }

  // 上傳附件檔案
  Future<void> _pickAttachment() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _attachmentFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to pick file: $e")));
    }
  }

  // 儲存修改的公告
  void _saveAnnouncement() {
    final updatedAnnouncement = {
      "ID": widget.announcement["ID"]!,
      "Title": _titleController.text,
      "Date": _dateController.text,
      "Publisher": widget.announcement["Publisher"]!,
    };
    // 更新公告資料 (這裡可以新增一個 API 呼叫來儲存資料)
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("公告已更新")));
    Navigator.pop(context, updatedAnnouncement); // 返回到公告管理頁
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("修改公告")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("標題"),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(border: OutlineInputBorder(), hintText: "輸入公告標題"),
              ),
              SizedBox(height: 16),
              Text("日期"),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(border: OutlineInputBorder(), hintText: "輸入公告日期"),
              ),
              SizedBox(height: 16),
              Text("內容"),
              TextField(
                controller: _contentController,
                maxLines: 5,
                decoration: InputDecoration(border: OutlineInputBorder(), hintText: "輸入公告內容"),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickAttachment,
                    child: Text(_attachmentFile == null ? "選擇附件" : "已選擇附件"),
                  ),
                  if (_attachmentFile != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        _attachmentFile!.path.split('/').last,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveAnnouncement,
                child: Text("儲存修改"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}