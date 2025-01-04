package com.example.demo.dao;

import com.example.demo.model.Ann;
import com.example.demo.config.DatabaseConnection;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class AnnDAO {

    private static final String UPLOAD_DIR = "uploads/";

    public List<Ann> getBasicAnnouncements() {
        List<Ann> announcements = new ArrayList<>();
        String sql = "SELECT AnnID, AnnTitle, AnnTime FROM ANN";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Ann ann = new Ann();
                ann.setAnnID(rs.getInt("AnnID"));
                ann.setAnnTitle(rs.getString("AnnTitle"));
                ann.setAnnTime(rs.getTimestamp("AnnTime").toLocalDateTime());
                announcements.add(ann);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return announcements;
    }

    public Ann getAnnById(int AnnID) {
        Ann ann = null;
        String sql = "SELECT * FROM ANN WHERE AnnID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, AnnID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    ann = new Ann();
                    ann.setAnnID(rs.getInt("AnnID"));
                    ann.setAnnTitle(rs.getString("AnnTitle"));
                    ann.setAnnInfo(rs.getString("AnnInfo"));
                    ann.setPoster(rs.getString("Poster"));
                    ann.setFileName(rs.getString("File_Name"));
                    ann.setFileType(rs.getString("File_Type"));
                    ann.setAdminID(rs.getString("AdminID"));
                    ann.setAnnTime(rs.getTimestamp("AnnTime").toLocalDateTime());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ann;
    }

    public boolean addAnnouncement(Ann ann) {
        String sql1 = "INSERT INTO ann (AnnTitle, AnnInfo, AnnTime, AdminID) VALUES (?, ?, ?, ?)";
        String sql2 = "INSERT INTO ann_annposter (AnnPoster, AnnID) VALUES (?, ?)";
        String sql3 = "INSERT INTO ann_annfile (AnnFileURL, AnnFileName, AnnID) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
             PreparedStatement pstmt2 = conn.prepareStatement(sql2);
             PreparedStatement pstmt3 = conn.prepareStatement(sql3)) {

            pstmt1.setString(1, ann.getAnnTitle());
            pstmt1.setString(2, ann.getAnnInfo());
            pstmt1.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
            pstmt1.setString(4, ann.getAdminID());
            
            pstmt1.executeUpdate();
            ResultSet rs = pstmt1.getGeneratedKeys();
            if (rs.next()) {
                int ann_ID = rs.getInt(1);
                pstmt2.setString(1, ann.getPosterPath());
                pstmt2.setInt(2, ann_ID);

                pstmt3.setString(1, ann.getFilePath());
                pstmt3.setString(2, ann.getFileName());
                pstmt3.setInt(3, ann_ID);

                pstmt2.executeUpdate();
                pstmt3.executeUpdate();
            }
            
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateAnnouncement(Ann ann) {
        String sql1 = "UPDATE ann SET AnnTitle = ?, AnnInfo = ?, AnnTime = ?, AdminID = ? WHERE AnnID = ?";
        String sql2 = "UPDATE ann_annposter SET AnnPoster = ? WHERE AnnID = ?";
        String sql3 = "UPDATE ann_annfile SET AnnFileURL = ?, AnnFileName = ? WHERE AnnID = ?";
    
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt1 = conn.prepareStatement(sql1);
             PreparedStatement pstmt2 = conn.prepareStatement(sql2);
             PreparedStatement pstmt3 = conn.prepareStatement(sql3)) {
    
            // 更新 `ann` 表
            pstmt1.setString(1, ann.getAnnTitle());
            pstmt1.setString(2, ann.getAnnInfo());
            pstmt1.setTimestamp(3, Timestamp.valueOf(ann.getAnnTime())); // 使用 AnnTime 的值
            pstmt1.setString(4, ann.getAdminID());
            pstmt1.setInt(5, ann.getAnnID());
            pstmt1.executeUpdate();
    
            // 更新 `ann_annposter` 表
            pstmt2.setString(1, ann.getPosterPath());  // 更新海報路徑
            pstmt2.setInt(2, ann.getAnnID());
            pstmt2.executeUpdate();
    
            // 更新 `ann_annfile` 表
            pstmt3.setString(1, ann.getFilePath());    // 更新檔案路徑
            pstmt3.setString(2, ann.getFileName());    // 更新檔案名稱
            pstmt3.setInt(3, ann.getAnnID());
            pstmt3.executeUpdate();
    
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    

    public String saveFile(String fileName, byte[] data) throws IOException {
        if (data == null || fileName == null) {
            return null;
        }
        String relativePath = UPLOAD_DIR + fileName;
        File dir = new File(UPLOAD_DIR);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        File file = new File(relativePath);
        try (FileOutputStream fos = new FileOutputStream(file)) {
            fos.write(data);
        }
        return relativePath; // 返回相對路徑
    }
}
