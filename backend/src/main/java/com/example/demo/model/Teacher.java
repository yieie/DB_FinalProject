package com.example.demo.model;
// service 層
public class Teacher {
    private String trId;
    private String trPasswd;
    private String trName;
    private String trJobType;
    private String trDepartment;
    private String trOrganization;
    
    public String getTrId() {
        return trId;
    }

    public void setTrId(String trId) {
        this.trId = trId;
    }

    public String getTrPasswd() {
        return trPasswd;
    }

    public void setTrPasswd(String trPasswd) {
        this.trPasswd = trPasswd;
    }

    public String getTrName() {
        return trName;
    }

    public void setTrName(String trName) {
        this.trName = trName;
    }

    public String getTrJobType() {
        return trJobType;
    }

    public void setTrJobType(String trJobType) {
        this.trJobType = trJobType;
    }

    public String getTrDepartment() {
        return trDepartment;
    }

    public void setTrDepartment(String trDepartment) {
        this.trDepartment = trDepartment;
    }

    public String getTrOrganization() {
        return trOrganization;
    }

    public void setTrOrganization(String trOrganization) {
        this.trOrganization = trOrganization;
    }

    @Override
    public String toString() {
        return "Teacher{" +
                "trId='" + trId + '\'' +
                ", trPasswd='" + trPasswd + '\'' +
                ", trName='" + trName + '\'' +
                ", trJobType='" + trJobType + '\'' +
                ", trDepartment='" + trDepartment + '\'' +
                ", trOrganization='" + trOrganization + '\'' +
                '}';
    }
}