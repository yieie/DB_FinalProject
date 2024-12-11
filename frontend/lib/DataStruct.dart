//公告結構(還缺照片及文件變數，待補)
class AnnStruct{
  String date;
  String title;
  String info;

  AnnStruct(this.date,this.title,this.info);

  factory AnnStruct.fromJson(Map<String, dynamic> json){
    return AnnStruct(json['date'], json['title'], json['info']);
  }
}