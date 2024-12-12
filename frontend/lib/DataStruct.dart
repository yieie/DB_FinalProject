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

  factory AnnStruct.fromBasicJson(Map<String, dynamic> json) {
    return AnnStruct(
      id: json['annID'] as int,
      date: json['annTime'] as String,
      title: json['annTitle'] as String,
    );
  }

  factory AnnStruct.fromDetailJson(Map<String, dynamic> json) {
    return AnnStruct(
      id: json['annID'] as int,
      date: json['annTime'] as String,
      title: json['annTitle'] as String,
      info: json['annInfo'] as String?,
      imageurl: json['poster'] as String?,
      filename: json['fileName'] as String?,
      filetype: json['fileType'] as String?,
      filedata: json['fileData'] as String?,
    );
  }
}