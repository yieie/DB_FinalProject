import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;
import 'dart:typed_data'; // 引入 Uint8List

class UploadImg extends StatefulWidget {
  @override
  _UploadImgState createState() => _UploadImgState();
}

class _UploadImgState extends State<UploadImg> {
  html.File? _imageFile;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // 讀取文件的位元組數據
      Uint8List bytes = await pickedFile.readAsBytes();

      // 正確構造 html.File
      setState(() {
        _imageFile = html.File([bytes], pickedFile.name, {'type': 'image/jpeg'});
      });

      print("選擇的文件名稱: ${pickedFile.name}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null)
              Image.network(html.Url.createObjectUrl(_imageFile!), height: 200, width: 200, fit: BoxFit.cover),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: Text('Pick an Image'),
            ),
          ],
        );
  }
}
