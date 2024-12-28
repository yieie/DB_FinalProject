import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;
import 'dart:typed_data';

class UploadImgs extends StatefulWidget {
  final Function(List<PlatformFile>) onImagesChanged;

  UploadImgs({required this.onImagesChanged});
  @override
  _UploadImgsState createState() => _UploadImgsState();
}

class _UploadImgsState extends State<UploadImgs> {
  List<PlatformFile> _selectedImages = []; // 存放累積的圖片文件

  // 選擇一張圖片並添加到列表
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'jpg','png'], // 限制檔案類型
      allowMultiple: false, // 單次只選一個檔案
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedImages.add(result.files.first);
        widget.onImagesChanged(_selectedImages);
      });
    }
  }

  void clearFiles() {
    setState(() {
      _selectedImages.clear();
      widget.onImagesChanged(_selectedImages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade600)
      ),
      child:Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color:Colors.grey.shade600)
              )
            ),
            padding: EdgeInsets.only(top:5,bottom: 4,left: 15,right: 15),
            child: Row(
              children: [
                Text("選擇圖片",style: TextStyle(fontSize: 16),),
                Spacer(),
                ElevatedButton(
                  onPressed: pickImage,
                  child: Text('選擇圖片'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _selectedImages.isEmpty
                ? Center(child: Text('尚未選擇圖片'))
                : Scrollbar(
                  thumbVisibility: true,
                  child: GridView.builder(
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 每行顯示3張圖片
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 200,
                      ),
                      itemCount: _selectedImages.length,
                      itemBuilder: (context, index) {
                        final img=_selectedImages[index];
                        return Stack(
                          children: [
                            Image.memory(
                              img.bytes!,
                              // height: 100,
                              // width: 100,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedImages.removeAt(index); // 點擊刪除圖片
                                  });
                                },
                                child: Container(
                                  color: Colors.white54,
                                  child: Icon(Icons.close, color: Colors.black)
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                ),
          ),
        ],
      )
    );
  }
}
