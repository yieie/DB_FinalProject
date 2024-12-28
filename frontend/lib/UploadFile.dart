import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadFiles extends StatefulWidget {
  final Function(List<PlatformFile>) onFilesChanged;
  UploadFiles({required this.onFilesChanged});
  @override
  _UploadFilesState createState() => _UploadFilesState();
}

class _UploadFilesState extends State<UploadFiles> {
  List<PlatformFile> _selectedFiles = []; // 用於存儲所有已選檔案

  // 單次選擇一個檔案並添加到列表
  Future<void> selectSingleFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['docx', 'pdf'], // 限制檔案類型
      allowMultiple: false, // 單次只選一個檔案
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFiles.add(result.files.first);
         widget.onFilesChanged(_selectedFiles);
      });
    }
  }

  // 清除檔案列表
  void clearFiles() {
    setState(() {
      _selectedFiles.clear();
      widget.onFilesChanged(_selectedFiles);
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
                    onPressed: selectSingleFile,
                    child: Text('選擇檔案'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: clearFiles,
                    child: Text('清除所有檔案'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ],
              ),
            ),
            // 顯示所有已選檔案
            Expanded(
              child: _selectedFiles.isNotEmpty
                  ? ListView.builder(
                      itemCount: _selectedFiles.length,
                      itemBuilder: (context, index) {
                        final file = _selectedFiles[index];
                        return ListTile(
                          leading: Icon(Icons.insert_drive_file),
                          title: Text(file.name),
                          subtitle: Text('大小: ${(file.size / 1024).toStringAsFixed(2)} KB'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _selectedFiles.removeAt(index); // 刪除指定檔案
                              });
                            },
                          ),
                        );
                      },
                    )
                  : Center(child: Text('尚未選擇任何檔案')),
            ),
            
          ],
        ),
    );
  }
}
