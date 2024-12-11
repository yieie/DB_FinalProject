//公告結構(還缺照片及文件變數，待補)
class AnnStruct{
  int id;
  String date;
  String title;
  String? info;
  String? imageurl;
  String? filename;
  String? filetype;
  String? filedata;

  AnnStruct({required this.id,required this.date,required this.title,
            this.info,this.imageurl,this.filename,this.filetype,this.filedata});

  factory AnnStruct.fromBasicJson(Map<String, dynamic> json){
    return AnnStruct(id: json['AnnID'], date: json['AnnDate'], title: json['AnnTitle']);
  }

  factory AnnStruct.fromDetailJson(Map<String, dynamic> json){
    return AnnStruct(id: json['AnnID'], date: json['AnnDate'], 
                    title: json['AnnTitle'], info: json['AnnInfo'], 
                    imageurl:  json['Poster'], filename: json['File_Name'], 
                    filetype:  json['File_Type'], filedata:  json['File_Data']);
  }
}