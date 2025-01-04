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
    private List<String> poster = new ArrayList<>();
    private byte[] posterData; // 保留，如果需要直接存 Poster 的 byte[]
    private List<String> fileName = new ArrayList<>();
    private List<String> fileUrl = new ArrayList<>();
    private String fileType;
    private byte[] fileData;
    private String adminID;
    private String filePath; // 後端用
    private String posterPath; // 後端用

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

    public List<String> getPoster() {
        return poster;
    }

    public void setPoster(List<String> poster) {
        this.poster = poster;
    }

    public byte[] getPosterData() {
        return posterData;
    }

    public void setPosterData(byte[] posterData) {
        this.posterData = posterData;
    }

    public List<String> getFileName() {
        return fileName;
    }

    public void setFileName(List<String> fileName) {
        this.fileName = fileName;
    }

    public List<String> getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(List<String> fileUrl) {
        this.fileUrl = fileUrl;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public byte[] getFileData() {
        return fileData;
    }

    public void setFileData(byte[] fileData) {
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

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getPosterPath() {
        return posterPath;
    }

    public void setPosterPath(String posterPath) {
        this.posterPath = posterPath;
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
