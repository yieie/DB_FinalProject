package com.example.demo.model;

public class Student {
    private String stuID;
    private String stuPasswd;
    private String stuName;
    private String stuSex;
    private String stuPhone;
    private String stuEmail;
    private String stuDepartment;
    private String stuGrade;

    public String getStuID() {
        return stuID;
    }

    public void setStuID(String stuID) {
        this.stuID = stuID;
    }

    public String getStuPasswd() {
        return stuPasswd;
    }

    public void setStuPasswd(String stuPasswd) {
        this.stuPasswd = stuPasswd;
    }

    public String getStuName() {
        return stuName;
    }

    public void setStuName(String stuName) {
        this.stuName = stuName;
    }

    public String getStuSex() {
        return stuSex;
    }

    public void setStuSex(String stuSex) {
        this.stuSex = stuSex;
    }

    public String getStuPhone() {
        return stuPhone;
    }

    public void setStuPhone(String stuPhone) {
        this.stuPhone = stuPhone;
    }

    public String getStuEmail() {
        return stuEmail;
    }

    public void setStuEmail(String stuEmail) {
        this.stuEmail = stuEmail;
    }

    public String getStuDepartment() {
        return stuDepartment;
    }

    public void setStuDepartment(String stuDepartment) {
        this.stuDepartment = stuDepartment;
    }

    public String getStuGrade() {
        return stuGrade;
    }

    public void setStuGrade(String stuGrade) {
        this.stuGrade = stuGrade;
    }

    @Override
    public String toString() {
        return "Student{" +
                "stuId='" + stuID + '\'' +
                ", stuPasswd='" + stuPasswd + '\'' +
                ", stuName='" + stuName + '\'' +
                ", stuSex='" + stuSex + '\'' +
                ", stuPhone='" + stuPhone + '\'' +
                ", stuEmail='" + stuEmail + '\'' +
                ", stuDepartment='" + stuDepartment + '\'' +
                ", stuGrade='" + stuGrade + '\'' +
                '}';
    }
}
