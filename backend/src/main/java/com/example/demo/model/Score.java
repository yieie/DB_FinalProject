package com.example.demo.model;

// teamid: json['teamid'] as String, 
//       teamname: json['teamname'] as String, 
//       teamtype: json['teamtype'] as String, 
//       judgename: json['judgename'] as String,
//       Rate1: json['rate1'] as String?,
//       Rate2: json['rate2'] as String?,
//       Rate3: json['rate3'] as String?,
//       Rate4: json['rate4'] as String?,
//       totalrate: json['totalrate'] as String?,
//       teamrank: json['teamrank'] as String?

public class Score {
    private String teamid;
    private String teamname;
    private String teamtype;
    private String judgename;
    private String rate1;
    private String rate2;
    private String rate3;
    private String rate4;
    private String totalrate;
    private String teamrank;

    public Score() {
    }

    public String getTeamId() {
        return teamid;
    }

    public void setTeamId(String teamid) {
        this.teamid = teamid;
    }

    public String getTeamName() {
        return teamname;
    }

    public void setTeamName(String teamname) {
        this.teamname = teamname;
    }

    public String getTeamType() {
        return teamtype;
    }

    public void setTeamType(String teamtype) {
        this.teamtype = teamtype;
    }

    public String getJudgeName() {
        return judgename;
    }

    public void setJudgeName(String judgename) {
        this.judgename = judgename;
    }

    public String getRate1() {
        return rate1;
    }

    public void setRate1(String rate1) {
        this.rate1 = rate1;
    }

    public String getRate2() {
        return rate2;
    }

    public void setRate2(String rate2) {
        this.rate2 = rate2;
    }

    public String getRate3() {
        return rate3;
    }

    public void setRate3(String rate3) {
        this.rate3 = rate3;
    }

    public String getRate4() {
        return rate4;
    }

    public void setRate4(String rate4) {
        this.rate4 = rate4;
    }

    public String getTotalRate() {
        return totalrate;
    }

    public void setTotalRate(String totalrate) {
        this.totalrate = totalrate;
    }

    public String getTeamRank() {
        return teamrank;
    }

    public void setTeamRank(String teamrank) {
        this.teamrank = teamrank;
    }

    @Override
    public String toString() {
        return "Score{" +
                "teamid='" + teamid + '\'' +
                ", teamname='" + teamname + '\'' +
                ", teamtype='" + teamtype + '\'' +
                ", judgename='" + judgename + '\'' +
                ", rate1='" + rate1 + '\'' +
                ", rate2='" + rate2 + '\'' +
                ", rate3='" + rate3 + '\'' +
                ", rate4='" + rate4 + '\'' +
                ", totalrate='" + totalrate + '\'' +
                ", teamrank='" + teamrank + '\'' +
                '}';
    }
}
