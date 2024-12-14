class Score {
  String? Rate1;
  String? Rate2;
  String? Rate3;
  String? Rate4;
  String? totalrate;
  String teamid;
  String teamname;
  String teamtype;
  String? teamrank;
  String judgename;

  Score({
    this.Rate1,
    this.Rate2,
    this.Rate3,
    this.Rate4,
    this.totalrate,
    this.teamrank,
    required this.teamid,
    required this.teamname,
    required this.teamtype,
    required this.judgename
  });

  factory Score.fromJson(Map<String,dynamic> json){
    return Score(
      teamid: json['teamid'] as String, 
      teamname: json['teamname'] as String, 
      teamtype: json['teamtype'] as String, 
      judgename: json['judgename'] as String,
      Rate1: json['rate1'] as String?,
      Rate2: json['rate2'] as String?,
      Rate3: json['rate3'] as String?,
      Rate4: json['rate4'] as String?,
      totalrate: json['totalrate'] as String?,
      teamrank: json['teamrank'] as String?
    );
  }
}
