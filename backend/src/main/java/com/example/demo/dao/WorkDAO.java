package com.example.demo.dao;

import com.example.demo.model.Team;
import com.example.demo.config.DatabaseConnection;
import com.example.demo.model.Work;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.ArrayList;
import java.util.Locale;
import java.util.Map;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.HashMap;

public class WorkDAO {
    public Map<String, String> getWorkFiles(String workid){
        Map<String, String> files = new HashMap<>();
        String sql = "SELECT WorkIntro, WorkPoster FROM work WHERE WorkID = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, workid);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    files.put("workinto", rs.getString("WorkIntro"));
                    files.put("workposter", rs.getString("WorkPoster"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return files;
    }

    public void addWork(Work work) {
        String selectQuery = "SELECT WorkID FROM work ORDER BY WorkID DESC LIMIT 1";
        String insertQuery = "INSERT INTO work (WorkID, WorkName, WorkSummary, WorkSdgs, WorkYear) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement selectStmt = conn.prepareStatement(selectQuery);
             PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
    
            // 查詢當前最大的 WorkID
            String newWorkID = "work1"; // 默認值
            try (ResultSet rs = selectStmt.executeQuery()) {
                if (rs.next()) {
                    String currentWorkID = rs.getString("WorkID");
                    int currentNumber = Integer.parseInt(currentWorkID.replace("work", ""));
                    newWorkID = "work" + (currentNumber + 1); // 生成下一個 WorkID
                }
            }
    
            // 獲取當前年份
            int currentYear = LocalDate.now().getYear();
    
            // 插入新數據
            insertStmt.setString(1, newWorkID);
            insertStmt.setString(2, work.getWorkName());
            insertStmt.setString(3, work.getWorkSummary());
            insertStmt.setString(4, work.getWorkSdgs());
            insertStmt.setInt(5, currentYear); // 設置 WorkYear
            
            insertStmt.executeUpdate();
    
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    
}
