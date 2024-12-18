class TeamsStatus {
  int amounts; //隊伍總數
  int approved; //審核通過數量
  int notreview; //未審核數量
  int incomplete; //需補件數量
  int qualifying; //進初賽隊伍數量
  int finalround; //進決賽隊伍數量

  TeamsStatus({
    required this.amounts, 
    required this.approved, 
    required this.notreview, 
    required this.incomplete,
    required this.qualifying,
    required this.finalround
  });

  factory TeamsStatus.fromJson(Map<String,dynamic> json){
    return TeamsStatus(
      amounts: json['amount'] as int, 
      approved: json['approved'] as int, 
      notreview: json['notreview'] as int, 
      incomplete: json['incomplete'] as int, 
      qualifying: json['qualifying'] as int, 
      finalround: json['finalround'] as int
    );
  }
}