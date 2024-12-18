class Announcement{
  int id;
  String date;
  String title;
  String? info;
  String? imgamount;
  List<String>? imageurl;
  String? fileamount;
  List<String>? filename;
  List<String>? fileurl;

  Announcement({required this.id,required this.date,required this.title,
            this.info,this.imgamount,this.imageurl,
            this.fileamount,this.filename,this.fileurl});

  factory Announcement.fromBasicJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['annID'] as int,
      date: json['annTime'] as String,
      title: json['annTitle'] as String,
      imgamount: json['annAmount'] as String?,
      fileamount: json['fileAmount'] as String?
    );
  }

  factory Announcement.fromDetailJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['annID'] as int,
      date: json['annTime'] as String,
      title: json['annTitle'] as String,
      info: json['annInfo'] as String?,
      imageurl: json['poster'] as List<String>?,
      filename: json['fileName'] as List<String>?,
      fileurl: json['fileurl'] as List<String>?,
    );
  }
}