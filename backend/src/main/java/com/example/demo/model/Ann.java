package com.example.demo.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;

public class Ann {
    @JsonProperty("annid")
    private int annid;
    @JsonProperty("anntitle")
    private String anntitle;
    @JsonProperty("anninfo")
    private String anninfo;
    @JsonProperty("poster")
    private List<String> poster = new ArrayList<>();
    @JsonProperty("posterdata")
    private byte[] posterdata; // 保留，如果需要直接存 Poster 的 byte[]
    @JsonProperty("filename")
    private List<String> filename = new ArrayList<>();
    @JsonProperty("fileurl")
    private List<String> fileurl = new ArrayList<>();
    @JsonProperty("filetype")
    private String filetype;
    @JsonProperty("filedata")
    private byte[] filedata;
    @JsonProperty("adminid")
    private String adminid;
    @JsonProperty("filepath")
    private List<String> filepath = new ArrayList<>(); // 後端用
    @JsonProperty("posterpath")
    private List<String> posterpath = new ArrayList<>(); // 後端用

    // @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private LocalDateTime anntime;

    private List<FileData> files = new ArrayList<>();
    private List<FileData> images = new ArrayList<>();

    public int getAnnID() {
        return annid;
    }

    public void setAnnID(int annid) {
        this.annid = annid;
    }

    public String getAnnTitle() {
        return anntitle;
    }

    public void setAnnTitle(String anntitle) {
        this.anntitle = anntitle;
    }

    public String getAnnInfo() {
        return anninfo;
    }

    public void setAnnInfo(String anninfo) {
        this.anninfo = anninfo;
    }

    public List<String> getPoster() {
        return poster;
    }

    public void setPoster(List<String> poster) {
        this.poster = poster;
    }

    public byte[] getPosterData() {
        return posterdata;
    }

    public void setPosterData(byte[] posterdata) {
        this.posterdata = posterdata;
    }

    public List<String> getFileName() {
        return filename;
    }

    public void setFileName(List<String> filename) {
        this.filename = filename;
    }

    public List<String> getFileUrl() {
        return fileurl;
    }

    public void setFileUrl(List<String> fileurl) {
        this.fileurl = fileurl;
    }

    public String getFileType() {
        return filetype;
    }

    public void setFileType(String filetype) {
        this.filetype = filetype;
    }

    public byte[] getFileData() {
        return filedata;
    }

    public void setFileData(byte[] filedata) {
        this.filedata = filedata;
    }

    public String getAdminID() {
        return adminid;
    }

    public void setAdminID(String adminid) {
        this.adminid = adminid;
    }

    public String getAnnTime() {
        if (anntime != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            return anntime.format(formatter);
        }
        return null;
    }

    public void setAnnTime(LocalDateTime anntime) {
        this.anntime = anntime;
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

    public List<String> getFilePath() {
        return filepath;
    }

    public void setFilePath(List<String> filepath) {
        this.filepath = filepath;
    }

    public List<String> getPosterPath() {
        return posterpath;
    }

    public void setPosterPath(List<String> posterpath) {
        this.posterpath = posterpath;
    }

    @Override
    public String toString() {
        return "Ann{" +
                "annID=" + annid +
                ", annTitle='" + anntitle + '\'' +
                ", annInfo='" + anninfo + '\'' +
                ", poster='" + poster + '\'' +
                ", fileName='" + filename + '\'' +
                ", fileType='" + filetype + '\'' +
                ", fileData='" + filedata + '\'' +
                ", adminID='" + adminid + '\'' +
                ", annTime=" + anntime +
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
