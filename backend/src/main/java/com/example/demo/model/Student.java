package com.example.demo.model;

public class Student {
    private String stuId;
    private String stuPasswd;
    private String stuName;
    private String stuSexual;
    private String stuPhone;
    private String stuEmail;
    private String stuDepartment;
    private String stuGrade;

    public String getStuId() {
        return stuId;
    }

    public void setStuId(String stuId) {
        this.stuId = stuId;
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

    public String getStuSexual() {
        return stuSexual;
    }

    public void setStuSexual(String stuSexual) {
        this.stuSexual = stuSexual;
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
                "stuId='" + stuId + '\'' +
                ", stuPasswd='" + stuPasswd + '\'' +
                ", stuName='" + stuName + '\'' +
                ", stuSexual='" + stuSexual + '\'' +
                ", stuPhone='" + stuPhone + '\'' +
                ", stuEmail='" + stuEmail + '\'' +
                ", stuDepartment='" + stuDepartment + '\'' +
                ", stuGrade='" + stuGrade + '\'' +
                '}';
    }
}
