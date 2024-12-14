package com.example.demo.dao;

import com.example.demo.model.Ann;
import com.example.demo.config.DatabaseConnection;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;
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
        String sql = "INSERT INTO ann_annposter (AnnPoster, AnnID) " +
                "VALUES (?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, ann.getAnnTitle());
            pstmt.setString(2, ann.getAnnInfo());

            // 儲存海報並返回相對路徑
            String posterPath = saveFile(ann.getPoster(), ann.getPosterData());
            pstmt.setString(3, posterPath);

            pstmt.setString(4, ann.getFileName());
            pstmt.setString(5, ann.getFileType());
            pstmt.setString(6, ann.getAdminID());
            pstmt.setTimestamp(7, Timestamp.valueOf(ann.getAnnTime()));
            pstmt.executeUpdate();
            return true;
        } catch (SQLException | IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateAnnouncement(Ann ann) {
        String sql = "UPDATE ANN SET AnnTitle = ?, AnnInfo = ?, Poster = ?, File_Name = ?, File_Type = ?, AdminID = ?, AnnTime = ? WHERE AnnID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, ann.getAnnTitle());
            pstmt.setString(2, ann.getAnnInfo());

            // 儲存更新的海報並返回相對路徑
            String posterPath = saveFile(ann.getPoster(), ann.getPosterData());
            pstmt.setString(3, posterPath);

            pstmt.setString(4, ann.getFileName());
            pstmt.setString(5, ann.getFileType());
            pstmt.setString(6, ann.getAdminID());
            pstmt.setTimestamp(7, Timestamp.valueOf(ann.getAnnTime()));
            pstmt.setInt(8, ann.getAnnID());
            pstmt.executeUpdate();
            return true;
        } catch (SQLException | IOException e) {
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
