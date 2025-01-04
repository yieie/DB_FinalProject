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
        String sql2 = "SELECT * FROM ann_annposter WHERE AnnID = ?";
        String sql3 = "SELECT * FROM ann_annfile WHERE AnnID = ?";
        
        // 用來儲存poster和file的列表
        List<String> posterURLs = new ArrayList<>();
        List<String> fileURLs = new ArrayList<>();
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, AnnID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    ann = new Ann();
                    ann.setAnnID(rs.getInt("AnnID"));
                    ann.setAnnTitle(rs.getString("AnnTitle"));
                    ann.setAnnInfo(rs.getString("AnnInfo"));
                    ann.setAdminID(rs.getString("AdminID"));
                    ann.setAnnTime(rs.getTimestamp("AnnTime").toLocalDateTime());
                    
                    // 查詢對應的 poster 資料
                    try (PreparedStatement pstmt2 = conn.prepareStatement(sql2)) {
                        pstmt2.setInt(1, AnnID);
                        try (ResultSet rs2 = pstmt2.executeQuery()) {
                            while (rs2.next()) {
                                // 假設poster的URL存在名為 PosterURL 欄位
                                posterURLs.add(rs2.getString("PosterURL"));
                            }
                        }
                    }
                    
                    // 查詢對應的 file 資料
                    try (PreparedStatement pstmt3 = conn.prepareStatement(sql3)) {
                        pstmt3.setInt(1, AnnID);
                        try (ResultSet rs3 = pstmt3.executeQuery()) {
                            while (rs3.next()) {
                                // 假設file的URL存在名為 FileURL 欄位
                                fileURLs.add(rs3.getString("FileURL"));
                            }
                        }
                    }
                    
                    // 將收集到的資料設置到 Ann 物件
                    ann.setPoster(posterURLs);  
                    ann.setFileUrl(fileURLs);     
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ann;
    }
    

    public boolean addAnnouncement(Ann ann) {
        String sql1 = "INSERT INTO ann (AnnTitle, AnnInfo, AnnTime, AdminID) VALUES (?, ?, ?, ?)";  // 新增公告
        String sql2 = "INSERT INTO ann_annposter (AnnPoster, AnnID) VALUES (?, ?)"; // 新增多個Poster
        String sql3 = "INSERT INTO ann_annfile (AnnFileURL, AnnFileName, AnnID) VALUES (?, ?, ?)"; // 新增多個File
    
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
             PreparedStatement pstmt2 = conn.prepareStatement(sql2);
             PreparedStatement pstmt3 = conn.prepareStatement(sql3)) {
    
            // 插入公告基本資料
            pstmt1.setString(1, ann.getAnnTitle());
            pstmt1.setString(2, ann.getAnnInfo());
            pstmt1.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
            pstmt1.setString(4, ann.getAdminID());
            pstmt1.executeUpdate();
    
            // 獲取生成的 AnnID
            ResultSet rs = pstmt1.getGeneratedKeys();
            if (rs.next()) {
                int ann_ID = rs.getInt(1);  // 獲取生成的公告ID
    
                // 處理 Poster (假設 Ann 類別有 getPosters() 方法返回 Poster 的 List)
                List<String> posters = ann.getPoster();  // 多個 Poster 路徑
                for (String poster : posters) {
                    pstmt2.setString(1, poster);  // 設定 Poster 路徑
                    pstmt2.setInt(2, ann_ID);     // 關聯到剛剛插入的公告
                    pstmt2.executeUpdate();
                }
    
                List<String> fileUrls = ann.getFileUrl();  // 多個 File URL
                List<String> fileNames = ann.getFileName(); // 多個 File 名稱
                for (int i = 0; i < fileUrls.size(); i++) {
                    pstmt3.setString(1, fileUrls.get(i));  // 設定 File URL
                    pstmt3.setString(2, fileNames.get(i)); // 設定 File 名稱
                    pstmt3.setInt(3, ann_ID);              // 關聯到剛剛插入的公告
                    pstmt3.executeUpdate();
                }
            }
            
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    

    public boolean updateAnnouncement(Ann ann) {
        // 更新公告的基本資料
        String sql1 = "UPDATE ann SET AnnTitle = ?, AnnInfo = ?, AnnTime = ?, AdminID = ? WHERE AnnID = ?";
        
        // 更新海報資料
        String sql2 = "UPDATE ann_annposter SET AnnPoster = ? WHERE AnnID = ?";
        
        // 更新檔案資料
        String sql3 = "UPDATE ann_annfile SET AnnFileURL = ?, AnnFileName = ? WHERE AnnID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt1 = conn.prepareStatement(sql1);
             PreparedStatement pstmt2 = conn.prepareStatement(sql2);
             PreparedStatement pstmt3 = conn.prepareStatement(sql3)) {
        
            // 更新公告的基本資料
            pstmt1.setString(1, ann.getAnnTitle());
            pstmt1.setString(2, ann.getAnnInfo());
            pstmt1.setTimestamp(3, Timestamp.valueOf(ann.getAnnTime())); // 使用 AnnTime 的值
            pstmt1.setString(4, ann.getAdminID());
            pstmt1.setInt(5, ann.getAnnID());
            pstmt1.executeUpdate();
        
            // 更新 `ann_annposter` 表
            List<String> posters = ann.getPoster();  // 多個 Poster 路徑
            for (String poster : posters) {
                pstmt2.setString(1, poster);  // 更新海報路徑
                pstmt2.setInt(2, ann.getAnnID()); // 使用 AnnID 來關聯
                pstmt2.executeUpdate();
            }
        
            // 更新 `ann_annfile` 表
            List<String> fileUrls = ann.getFileUrl();  // 多個檔案的 URL
            List<String> fileNames = ann.getFileName(); // 多個檔案的名稱
            for (int i = 0; i < fileUrls.size(); i++) {
                pstmt3.setString(1, fileUrls.get(i));  // 更新檔案 URL
                pstmt3.setString(2, fileNames.get(i)); // 更新檔案名稱
                pstmt3.setInt(3, ann.getAnnID());      // 使用 AnnID 來關聯
                pstmt3.executeUpdate();
            }
        
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
