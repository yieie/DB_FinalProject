package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;

// sexual: json['stusexual'] as String, 
//       phone: json['stuphone'] as String, 
//       major: json['stumajor'] as String, 
//       grade: json['stugrade'] as String,
//       isLeader: json['stuisLeader'] as bool?,
//       teamid: json['teamid'] as String?,
//       stuIdCard: json['stuIdCard'] as String?
public class Student {
    @JsonProperty("stuid")
    private String stuid;
    @JsonProperty("stuname")
    private String stuname;
    @JsonProperty("stuemail")
    private String stuemail;
    @JsonProperty("stusexual")
    private String stusexual;
    @JsonProperty("stuphone")
    private String stuphone;
    @JsonProperty("stumajor")
    private String stumajor;
    @JsonProperty("stugrade")
    private String stugrade;
    @JsonProperty("stuisleader")
    private Boolean stuisLeader;
    @JsonProperty("teamid")
    private String teamid;
    @JsonProperty("stuIdCard")
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
