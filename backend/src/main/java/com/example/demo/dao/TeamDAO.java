package com.example.demo.dao;

import com.example.demo.model.Team;
import com.example.demo.config.DatabaseConnection;

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


public class TeamDAO {
    public String convertTo24(String time12Hour) {

        // 去除首尾空格
        time12Hour = time12Hour.trim();
    
        // 檢查 AM 或 PM
        String amPm = time12Hour.substring(time12Hour.length() - 2).toUpperCase(); // 取得 AM/PM
        String timeWithoutAmPm = time12Hour.substring(0, time12Hour.length() - 2).trim(); // 去除 AM/PM 部分
    
        // 分割時間
        String[] timeParts = timeWithoutAmPm.split(":");
        int hour = Integer.parseInt(timeParts[0]);
        int minute = Integer.parseInt(timeParts[1]);
    
        // 根據 AM/PM 進行轉換
        if (amPm.equals("AM")) {
            if (hour == 12) {
                hour = 0; // 12 AM 轉為 00
            }
        } else if (amPm.equals("PM")) {
            if (hour != 12) {
                hour += 12; // PM 時間加 12，除非是 12 PM
            }
        }
    
        // 格式化為 24 小時制時間字串，並加上秒數部分
        return String.format("%02d:%02d:00", hour, minute);
    }

    public List<Team> getBasicAllTeam(){
        List<Team> teams = new ArrayList<>();
        String sql = "SELECT * FROM team as t, work as w WHERE t.TeamID=w.TeamID";
        try(Connection conn = DatabaseConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Team team = new Team();
                team.setTeamId(rs.getString("TeamID"));
                team.setTeamName(rs.getString("TeamName"));
                team.setTeamType(rs.getString("TeamType"));
                team.setAffidavit(rs.getString("Affidavit"));
                team.setConsent(rs.getString("Consent"));
                team.setWorkIntro(rs.getString("WorkIntro"));
                team.setTeamState(rs.getString("TeamState"));
                teams.add(team);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teams;
    }

    // 如果沒限制組別
    // 傳過去會是 “全組別”
    // 如果沒限制狀態
    // 傳過去會是 “無”
    // 一定有年
    public List<Team> getBasicTeamsWithConstraint(Map<String, Object> constraint) {
        List<Team> teams = new ArrayList<>();
        String baseSql = "SELECT * FROM team as t, work as w WHERE t.TeamID=w.TeamID and w.WorkYear = ?";
        StringBuilder sqlBuilder = new StringBuilder(baseSql);
    
        try (Connection conn = DatabaseConnection.getConnection()) {
            List<Object> parameters = new ArrayList<>();
            parameters.add(constraint.get("teamyear")); // 添加必須參數（`teamyear`）
    
            // 動態添加條件
            if (!"全組別".equals(constraint.get("teamtype"))) {
                sqlBuilder.append(" and t.TeamType = ?");
                parameters.add(constraint.get("teamtype")); // 添加參數
            }
            if (!"無".equals(constraint.get("teamstate"))) {
                sqlBuilder.append(" and t.TeamState = ?");
                parameters.add(constraint.get("teamstate")); // 添加參數
            }
    
            // 構建最終 SQL
            String sql = sqlBuilder.toString();
    
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                // 動態設置參數
                for (int i = 0; i < parameters.size(); i++) {
                    pstmt.setString(i + 1, (String) parameters.get(i));
                }
    
                // 執行查詢
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        Team team = new Team();
                        team.setTeamId(rs.getString("TeamID"));
                        team.setTeamName(rs.getString("TeamName"));
                        team.setTeamType(rs.getString("TeamType"));
                        team.setAffidavit(rs.getString("Affidavit"));
                        team.setConsent(rs.getString("Consent"));
                        team.setTeamState(rs.getString("TeamState"));
                        team.setWorkId(rs.getString("WorkID"));
                        team.setWorkIntro(rs.getString("WorkIntro"));
                        teams.add(team);
                    }
                }
            }
        } catch (SQLException e) {
            // 捕捉 SQL 錯誤並列印詳細錯誤信息
            System.err.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
    
        return teams;
    }
    
    public Team getTeamDetail(String teamid){
        Team team = null;
        String sql = "SELECT * FROM team as t, work as w WHERE t.TeamID=w.TeamID and t.TeamID = ?";
        try(Connection conn = DatabaseConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, teamid);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                team = new Team();
                team.setTeamId(rs.getString("TeamID"));
                team.setTeamName(rs.getString("TeamName"));
                team.setTeamType(rs.getString("TeamType"));
                team.setTeamRank(rs.getString("TeamRank"));
                team.setAffidavit(rs.getString("Affidavit"));
                team.setConsent(rs.getString("Consent"));
                team.setTeacherEmail(rs.getString("TeacherEmail")); 
                team.setTeamState(rs.getString("TeamState"));
                team.setWorkId(rs.getString("WorkID"));
                team.setWorkName(rs.getString("WorkName"));
                team.setWorkSummary(rs.getString("WorkSummary"));
                team.setWorkSdgs(rs.getString("WorkSDGs"));
                team.setWorkPoster(rs.getString("WorkPoster"));
                team.setWorkYtUrl(rs.getString("WorkYTURL"));
                team.setWorkGithub(rs.getString("WorkGithub"));
                team.setWorkYear(rs.getString("WorkYear"));
                team.setWorkIntro(rs.getString("WorkIntro"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return team;
    }

    public void updateTeamState(String teamid, String state){
        String sql = "UPDATE team SET TeamState = ? WHERE TeamID = ?";
        try(Connection conn = DatabaseConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, state);
            pstmt.setString(2, teamid);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
