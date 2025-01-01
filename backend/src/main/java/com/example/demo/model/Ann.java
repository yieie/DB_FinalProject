package com.example.demo.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Ann {
    private int annID;
    private String annTitle;
    private String annInfo;
    private String poster = "";
    private byte[] posterData; // 保留，如果需要直接存 Poster 的 byte[]
    private String fileName = "";
    private String fileType;
    private String fileData = "";
    private String adminID;

    // @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private LocalDateTime annTime;

    private List<FileData> files = new ArrayList<>();
    private List<FileData> images = new ArrayList<>();

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

    public byte[] getPosterData() {
        return posterData;
    }

    public void setPosterData(byte[] posterData) {
        this.posterData = posterData;
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

    public String getAnnTime() {
        if (annTime != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            return annTime.format(formatter);
        }
        return null;
    }

    public void setAnnTime(LocalDateTime annTime) {
        this.annTime = annTime;
    }

    public void addFile(String fileName, String fileType, String filePath) {
        this.files.add(new FileData(fileName, fileType, filePath));
    }

    public void addImage(String fileName, String fileType, String filePath) {
        this.images.add(new FileData(fileName, fileType, filePath));
    }

    public List<FileData> getFiles() {
        return files;
    }

    public List<FileData> getImages() {
        return images;
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
                ", annTime=" + getAnnTime() +
                '}';
    }

    private static class FileData {
        private String fileName;
        private String fileType;
        private String filePath;

        public FileData(String fileName, String fileType, String filePath) {
            this.fileName = fileName;
            this.fileType = fileType;
            this.filePath = filePath;
        }

        public String getFileName() {
            return fileName;
        }

        public String getFileType() {
            return fileType;
        }

        public String getFilePath() {
            return filePath;
        }
    }
}
