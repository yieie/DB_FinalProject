class TeamsStatus {
  int amounts; //隊伍總數
  int approved; //審核通過數量
  int notreview; //未審核數量
  int incomplete; //需補件數量
  int solved; //已補件

  TeamsStatus({
    required this.amounts, 
    required this.approved, 
    required this.notreview, 
    required this.incomplete,
    required this.solved
  });

  factory TeamsStatus.fromJson(Map<String,dynamic> json){
    return TeamsStatus(
      amounts: json['amounts'] as int, 
      approved: json['approved'] as int, 
      notreview: json['notreview'] as int, 
      incomplete: json['incomplete'] as int,
      solved: json['solved'] as int 
    );
  }
}