package com.example.demo.dao;

import com.example.demo.model.Score;


import com.example.demo.config.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;

public class ScoreDAO {
    public List<Score> getScoresWithConstraints(Map<String, Object> constraint) {
        List<Score> scores = new ArrayList<>();
        String baseSql = "SELECT * FROM score AS s " +
                         "LEFT JOIN team AS t ON s.TeamID = t.TeamID " +
                         "LEFT JOIN teacher_judge AS tj ON s.JudgeEmail = tj.TJEmail " + 
                         "WHERE t.TeamID LIKE ?";
        StringBuilder sqlBuilder = new StringBuilder(baseSql);
    
        try (Connection conn = DatabaseConnection.getConnection()) {
            List<Object> parameters = new ArrayList<>();
    
            // 設置 TeamID 的年份參數，並添加通配符
            String teamYear = (String) constraint.get("year");
            parameters.add(teamYear + "%"); // 添加年份條件參數
    
            // 動態添加 teamtype 條件
            if (!"全組別".equals(constraint.get("teamtype"))) {
                sqlBuilder.append(" AND t.TeamType = ?");
                parameters.add(constraint.get("teamtype")); // 添加組別條件參數
            }

            sqlBuilder.append(" ORDER BY t.TeamRank DESC");
            // 構建最終 SQL
            String sql = sqlBuilder.toString();
    
            // 準備 SQL 語句
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                for (int i = 0; i < parameters.size(); i++) {
                    pstmt.setObject(i + 1, parameters.get(i)); // 設置參數
                }
    
                // 執行查詢
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        // 將每一筆資料封裝為 Score 物件
                        Score score = new Score();
                        int r1 = rs.getInt("Rate1");
                        int r2 = rs.getInt("Rate2");
                        int r3 = rs.getInt("Rate3");
                        int r4 = rs.getInt("Rate4");
                        int totalRate = r1 + r2 + r3 + r4;
                        
                        score.setTeamType(rs.getString("TeamType"));
                        score.setTeamId(rs.getString("TeamID"));
                        score.setTeamName(rs.getString("TeamName"));
                        score.setJudgeName(rs.getString("TJName"));
                        score.setRate1(String.valueOf(r1));
                        score.setRate2(String.valueOf(r2));
                        score.setRate3(String.valueOf(r3));
                        score.setRate4(String.valueOf(r4));
                        score.setTotalRate(String.valueOf(totalRate));
                        score.setTeamRank(rs.getString("TeamRank"));
                        //System.out.println("隊伍"+score);
                        scores.add(score); // 加入到結果清單
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
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
