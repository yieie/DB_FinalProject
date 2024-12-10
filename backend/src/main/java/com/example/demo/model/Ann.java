package com.example.demo.model;

import java.time.LocalDateTime;

public class Ann {
    private int annID;
    private String annTitle;
    private String annInfo;
    private String poster;
    private String fileName;
    private String fileType;
    private String fileData;
    private String adminID;
    private LocalDateTime annTime;

    public int getAnnID() {
        return annID;
    }

    public void setAnnID(int annID) {
        this.annID = annID;
    }

    public String getAnnTitle() {
        return annTitle;
    }

    public void setAnnTitle(String annTitle) {
        this.annTitle = annTitle;
    }

    public String getAnnInfo() {
        return annInfo;
    }

    public void setAnnInfo(String annInfo) {
        this.annInfo = annInfo;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public String getFileData() {
        return fileData;
    }

    public void setFileData(String fileData) {
        this.fileData = fileData;
    }

    public String getAdminID() {
        return adminID;
    }

    public void setAdminID(String adminID) {
        this.adminID = adminID;
    }

    public LocalDateTime getAnnTime() {
        return annTime;
    }

    public void setAnnTime(LocalDateTime annTime) {
        this.annTime = annTime;
    }

    @Override
    public String toString() {
        return "Ann{" +
                "annID=" + annID +
                ", annTitle='" + annTitle + '\'' +
                ", annInfo='" + annInfo + '\'' +
                ", poster='" + poster + '\'' +
                ", fileName='" + fileName + '\'' +
                ", fileType='" + fileType + '\'' +
                ", fileData='" + fileData + '\'' +
                ", adminID='" + adminID + '\'' +
                ", annTime=" + annTime +
                '}';
    }
}
