class Workshop{
  int wsid;
  String wsdate;
  String wstime;
  String wstopic;

  String? lectName;
  String? lecttitle;
  String? lectphone;
  String? lectemail;
  String? lectaddr;

  Workshop({
    required this.wsid,
    required this.wsdate,
    required this.wstime,
    required this.wstopic,
    this.lectName,
    this.lecttitle,
    this.lectphone,
    this.lectemail,
    this.lectaddr
  });

  factory Workshop.fromJson(Map<String, dynamic> json){
    return Workshop(
      wsid: json['wsid'] as int, 
      wsdate: json['wsdate'] as String, 
      wstime: json['wstime'] as String, 
      wstopic: json['wstopic'] as String,
      lectName: json['lectname'] as String?,
      lecttitle: json['lecttitle'] as String?,
      lectphone: json['lectphone'] as String?,
      lectemail: json['lectemail'] as String?,
      lectaddr: json['lectaddr'] as String?
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'wsid':wsid,
      'wsdate':wsdate,
      'wstime':wstime,
      'wstopic':wstopic,
      'lectname':lectName,
      'lecttitle':lecttitle,
      'lectphone':lectphone,
      'lectemail':lectemail,
      'lectaddr':lectaddr
    };
  }
}