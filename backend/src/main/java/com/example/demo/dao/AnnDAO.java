package com.example.demo.dao;

import com.example.demo.model.Ann;
import com.example.demo.config.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AnnDAO {
    public List<Ann> getAllAnnouncements() {
        List<Ann> announcements = new ArrayList<>();
        String sql = "SELECT * FROM ANN";
        try(Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while(rs.next()) {
                Ann ann = new Ann();
                ann.setAnnID(rs.getInt("AnnID"));
                ann.setAnnTitle(rs.getString("AnnTitle"));
                ann.setAnnInfo(rs.getString("AnnInfo"));
                ann.setPoster(rs.getString("Poster"));
                ann.setFileName(rs.getString("File_Name"));
                ann.setFileType(rs.getString("File_Type"));
                ann.setFileData(rs.getString("File_Data"));
                ann.setAdminID(rs.getString("AdminID"));
                ann.setAnnTime(rs.getTimestamp("AnnTime").toLocalDateTime());
                announcements.add(ann);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return announcements;
    }

    public boolean addAnnouncement(Ann ann) {
        String sql = "INSERT INTO ANN (AnnTitle, AnnInfo, Poster, File_Name, File_Type, File_Data, AdminID, AnnTime) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try(Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, ann.getAnnTitle());
            pstmt.setString(2, ann.getAnnInfo());
            pstmt.setString(3, ann.getPoster());
            pstmt.setString(4, ann.getFileName());
            pstmt.setString(5, ann.getFileType());
            pstmt.setString(6, ann.getFileData());
            pstmt.setString(7, ann.getAdminID());
            pstmt.setTimestamp(8, Timestamp.valueOf(ann.getAnnTime()));
            pstmt.executeUpdate();
            return true;
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
