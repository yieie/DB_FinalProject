package com.example.demo.model;

// sexual: json['stusexual'] as String, 
//       phone: json['stuphone'] as String, 
//       major: json['stumajor'] as String, 
//       grade: json['stugrade'] as String,
//       isLeader: json['stuisLeader'] as bool?,
//       teamid: json['teamid'] as String?,
//       stuIdCard: json['stuIdCard'] as String?
public class Student {
    private String stuid;
    private String stuname;
    private String stuemail;
    private String stusexual;
    private String stuphone;
    private String stumajor;
    private String stugrade;
    private Boolean stuisLeader;
    private String teamid;
    private String stuIdCard;

    public String getStuID() {
        return stuid;
    }

    public void setStuID(String stuid) {
        this.stuid = stuid;
    }

    public String getStuName() {
        return stuname;
    }

    public void setStuName(String stuname) {
        this.stuname = stuname;
    }

    public String getStuEmail() {
        return stuemail;
    }

    public void setStuEmail(String stuemail) {
        this.stuemail = stuemail;
    }

    public String getStuSex() {
        return stusexual;
    }

    public void setStuSex(String stusexual) {
        this.stusexual = stusexual;
    }

    public String getStuPhone() {
        return stuphone;
    }

    public void setStuPhone(String stuphone) {
        this.stuphone = stuphone;
    }

    public String getStuDepartment() {
        return stumajor;
    }

    public void setStuDepartment(String stumajor) {
        this.stumajor = stumajor;
    }

    public String getStuGrade() {
        return stugrade;
    }

    public void setStuGrade(String stugrade) {
        this.stugrade = stugrade;
    }

    public Boolean getStuRole() {
        return stuisLeader;
    }

    public void setStuRole(Boolean stuisLeader) {
        this.stuisLeader = stuisLeader;
    }

    public String getTeamId() {
        return teamid;
    }

    public void setTeamId(String teamid) {
        this.teamid = teamid;
    }

    public String getStuIdCard() {
        return stuIdCard;
    }

    public void setStuIdCard(String stuIdCard) {
        this.stuIdCard = stuIdCard;
    }

    @Override
    public String toString() {
        return "Student{" +
                "stuid='" + stuid + '\'' +
                ", stuname='" + stuname + '\'' +
                ", stuemail='" + stuemail + '\'' +
                ", stusexual='" + stusexual + '\'' +
                ", stuphone='" + stuphone + '\'' +
                ", stumajor='" + stumajor + '\'' +
                ", stugrade='" + stugrade + '\'' +
                ", stuisLeader=" + stuisLeader +
                ", teamid='" + teamid + '\'' +
                ", stuIdCard='" + stuIdCard + '\'' +
                '}';
    }
}
