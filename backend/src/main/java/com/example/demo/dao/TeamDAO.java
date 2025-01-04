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
                team.setWorkIntro(rs.getString("WorkIntro"));
                team.setTeamState(rs.getString("TeamState"));
                team.setWorkId(rs.getString("WorkID"));
                team.setWorkName("WorkName");
                team.setWorkSummary("WorkSummary");
                team.setWorkSdgs("WorkSDGs");
                team.setWorkPoster("WorkPoster");
                team.setWorkYtUrl("WorkYTURL");
                team.setWorkGithub("WorkGithub");
                team.setWorkYear("WorkYear");
                team.setWorkIntro("WorkIntro");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return team;
    }
}
