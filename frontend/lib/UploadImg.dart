import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadImgs extends StatefulWidget {
  final int max;
  final String title;
  final Function(List<PlatformFile>) onImagesChanged;

  const UploadImgs({super.key, this.max = 100, this.title="選擇照片",required this.onImagesChanged});
  @override
  State<UploadImgs> createState() => _UploadImgsState();
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
            padding: const EdgeInsets.only(top:5,bottom: 4,left: 15,right: 15),
            child: Row(
              children: [
                Text(widget.title ,style: TextStyle(fontSize: 16),),
                const Spacer(),
                ElevatedButton(
                  onPressed: (){
                    if(_selectedImages.length < widget.max){
                      pickImage();
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("照片已達最高上限")));
                    }
                  },
                  child:const  Text('選擇圖片'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _selectedImages.isEmpty
                ?const  Center(child: Text('尚未選擇圖片'))
                : Scrollbar(
                  thumbVisibility: true,
                  child: GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  child: const Icon(Icons.close, color: Colors.black)
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
