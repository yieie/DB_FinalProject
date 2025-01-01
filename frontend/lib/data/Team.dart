class Team {
  String teamid;
  String teamname;
  String? rank;
  String teamtype;
  String? affidavit;
  String? consent;
  String? teacheremail;
  String? state;

  String? workid;
  String? workname;
  String? worksummary;
  String? worksdgs;
  String? workposter;
  String? workyturl;
  String? workgithub;
  String? workyear;
  String? workintro;

  Team({
    required this.teamid,
    required this.teamname,
    this.workid,
    this.rank,this.affidavit,
    this.consent,this.teacheremail,
    this.state,this.workname,
    this.worksummary,this.worksdgs,
    this.workposter,this.workyturl,
    this.workgithub,this.workyear,
    this.workintro, 
    required this.teamtype
  });

  factory Team.fromBasicJson(Map<String, dynamic> json){
    return Team(
      teamid: json['teamid'] as String,
      teamname: json['teamname'] as String,
      teamtype: json['teamtype'] as String,
      state: json['state'] as String,
      workid: json['workid'] as String?,
      workintro: json['workintro'] as String?,
      consent: json['consent'] as String?,
      affidavit: json['affidavit'] as String?
    );
  } 
}