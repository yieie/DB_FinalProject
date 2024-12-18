import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db_finalproject/core/services/AuthProvider.dart';
import 'package:db_finalproject/presentation/widgets/Navbar.dart';
import 'package:db_finalproject/presentation/widgets/Sidebar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ContestDataUpload extends StatefulWidget {
  @override
  _ContestDataUploadState createState() => _ContestDataUploadState();
}

class _ContestDataUploadState extends State<ContestDataUpload> {
  File? _image;

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("選擇圖片失敗: $e"))
      );
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("請選擇一張圖片"))
      );
      return;
    }

    try {
      // Simulating an upload process
      await Future.delayed(Duration(seconds: 2));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("圖片上傳成功"))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("圖片上傳失敗 $e"))
      );
    }
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
                    "文件上傳",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  _image != null
                      ? Image.file(
                          _image!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                          child: Center(
                            child: Text("尚未選擇圖片"),
                          ),
                        ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: Text("選擇圖片"),
                      ),
                      ElevatedButton(
                        onPressed: _uploadImage,
                        child: Text("上傳"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Sidebar()
        ],
      ),
    );
  }
}
