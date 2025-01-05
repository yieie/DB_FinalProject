package com.example.demo.dao;

import com.example.demo.model.Score;
import com.example.demo.config.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;

public class ScoreDAO {
    List<Score> getScoresWithConstraints(Score score){
        List<Score> scores = new ArrayList<>();
        Score score1 = new Score();
        
        return scores;
    }

    public void addScore(Map<String, Object> data, String teamid) {
        String sql = "INSERT INTO score (Rate1, Rate2, Rate3, Rate4, TeamID, JudgeEmail) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, (int) data.get("score1"));
            pstmt.setInt(2, (int) data.get("score2"));
            pstmt.setInt(3, (int) data.get("score3"));
            pstmt.setInt(4, (int) data.get("score4"));
            pstmt.setString(5, teamid);
            pstmt.setString(6, (String) data.get("judgeid"));
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
