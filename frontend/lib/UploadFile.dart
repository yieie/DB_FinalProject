import 'dart:math';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadFiles extends StatefulWidget {
  int max;
  String title;
  final Function(List<PlatformFile>) onFilesChanged;
  UploadFiles({super.key,this.max=5 ,this.title="選擇文件" ,required this.onFilesChanged});
  @override
  State<UploadFiles> createState() => _UploadFilesState();
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
              padding: const EdgeInsets.only(top:5,bottom: 4,left: 15,right: 15),
              child: Row(
                children: [
                  Text(widget.title ,style: TextStyle(fontSize: 16),),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: (){
                      if(_selectedFiles.length < widget.max){
                        selectSingleFile();
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("檔案已達最高上限")));
                      }
                    },
                    child: const Text('選擇檔案'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: clearFiles,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('清除所有檔案'),
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
                          leading: const Icon(Icons.insert_drive_file),
                          title: Text(file.name),
                          subtitle: Text('大小: ${(file.size / 1024).toStringAsFixed(2)} KB'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _selectedFiles.removeAt(index); // 刪除指定檔案
                              });
                            },
                          ),
                        );
                      },
                    )
                  :const  Center(child: Text('尚未選擇任何檔案')),
            ),
            
          ],
        ),
    );
  }
}
