class Announcement{
  int id;
  String? date;
  String title;
  String? info;
  String? admin;
  String? imgamount;
  List<String>? imageurl;
  String? fileamount;
  List<String>? filename;
  List<String>? fileurl;

  Announcement({required this.id,this.date,required this.title,
            this.info,this.admin,this.imgamount,this.imageurl,
            this.fileamount,this.filename,this.fileurl});

  factory Announcement.fromJson(Map<String, dynamic> json){
    return Announcement(
      id: json['annid'] as int,
      date: json['anntime'] as String,
      title: json['anntitle'] as String,
      info: json['anninfo'] as String?,
      admin: json['admin'] as String?,
      imgamount: json['posteramount'] as String?,
      imageurl: (json['poster'] as List<dynamic>?)?.cast<String>(),
      fileamount: json['fileamount'] as String?,
      filename: (json['filename'] as List<dynamic>?)?.cast<String>(),
      fileurl: (json['fileurl'] as List<dynamic>?)?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'annid': id,
      'anndate': date,
      'anntitle': title,
      'anninfo': info,
      'annadmin': admin
    };
  }
}