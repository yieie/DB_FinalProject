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
        String query = "INSERT INTO works (WorkName, WorkSummary, WorkSdgs) VALUES (?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            // 設定插入的欄位
            stmt.setString(1, work.getWorkName());
            stmt.setString(2, work.getWorkSummary());
            stmt.setString(3, work.getWorkSdgs());
            
            // 執行插入操作
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
}
