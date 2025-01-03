package com.example.demo.model;
// service 層
// id: json['trid'] as String, 
// name: json['trname'] as String, 
// email: json['trid'] as String, //在資料庫裏面email只存在id欄位，在前端為了方便呼叫會多email欄位
// sexual: json['trsexual'] as String, 
// phone: json['trphone'] as String,
// trJobType: json['trjobtype'] as String?,
// trDepartment: json['trdepartment'] as String?,
// trOriganization: json['trorganization'] as String?
public class Teacher {
    private String trid;
    private String trname;
    private String tremail;
    private String trsexual;
    private String trphone;
    private String trjobtype;
    private String trdepartment;
    private String trorganization;

    public String getTrId() {
        return trid;
    }

    public void setTrId(String trid) {
        this.trid = trid;
    }

    public String getTrName() {
        return trname;
    }

    public void setTrName(String trname) {
        this.trname = trname;
    }

    public String getTrEmail() {
        return tremail;
    }

    public void setTrEmail(String tremail) {
        this.tremail = tremail;
    }

    public String getTrSexual() {
        return trsexual;
    }

    public void setTrSexual(String trsexual) {
        this.trsexual = trsexual;
    }

    public String getTrPhone() {
        return trphone;
    }

    public void setTrPhone(String trphone) {
        this.trphone = trphone;
    }

    public String getTrJobType() {
        return trjobtype;
    }

    public void setTrJobType(String trjobtype) {
        this.trjobtype = trjobtype;
    }

    public String getTrDepartment() {
        return trdepartment;
    }

    public void setTrDepartment(String trdepartment) {
        this.trdepartment = trdepartment;
    }

    public String getTrOrganization() {
        return trorganization;
    }

    public void setTrOrganization(String trorganization) {
        this.trorganization = trorganization;
    }

    @Override
    public String toString() {
        return "Teacher{" +
                "trid='" + trid + '\'' +
                ", trname='" + trname + '\'' +
                ", tremail='" + tremail + '\'' +
                ", trsexual='" + trsexual + '\'' +
                ", trphone='" + trphone + '\'' +
                ", trjobtype='" + trjobtype + '\'' +
                ", trdepartment='" + trdepartment + '\'' +
                ", trorganization='" + trorganization + '\'' +
                '}';
    }
}