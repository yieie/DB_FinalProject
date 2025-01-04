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
    public Team getTeamStatus(){
        Team team= new Team();
        String sql1 = "SELECT COUNT(*) as count FROM team as t, work as w WHERE t.TeamID = w.TeamID";
        String sql2 = "SELECT t.TeamState, COUNT(*) as count FROM team as t, work as w WHERE t.TeamID = w.TeamID GROUP BY t.TeamState";
        try(Connection conn = DatabaseConnection.getConnection();
            PreparedStatement pstmt1 = conn.prepareStatement(sql1);
            PreparedStatement pstmt2 = conn.prepareStatement(sql2)) {
            ResultSet rs1 = pstmt1.executeQuery();
            if (rs1.next()) {
                team.setAmounts(rs1.getInt("count"));
            }
            
            ResultSet rs2 = pstmt2.executeQuery();
            int Notreview=0, Incomplete=0, Approved=0, Solved=0;
            // 處理結果
            while (rs2.next()) {
                String teamState = rs2.getString("TeamState");
                int count = rs2.getInt("count");  
                switch (teamState) {
                    case "報名待審核":
                        Notreview += count;
                        break;
                    case "待審核初賽資格":
                        Notreview += count;
                        break;
                    case "已審核":
                        Approved += count;
                        break;
                    case "初賽隊伍":
                        Approved += count;
                        break;
                    case "決賽隊伍":
                        Approved += count;
                        break;
                    case "需補件":
                        Incomplete += count;
                        break;
                    case "已補件":
                        Solved += count;
                        break;
                    default:
                        break;
                }
            }
            team.setNotreview(Notreview);
            team.setIncomplete(Incomplete);
            team.setApproved(Approved);
            //team.setSolved(Solved);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return team;
    }

    public List<Team> getBasicAllTeam(){
        List<Team> teams = new ArrayList<>();
        //要照階段排序 報名待審核 待審核初賽資格 已補件 需補件 已審核 初賽隊伍 決賽隊伍
        
        String sql = "SELECT * FROM team as t, work as w WHERE t.TeamID=w.TeamID" +
        "ORDER BY FIELD(t.TeamState, '報名待審核', '待審核初賽資格', '已補件', '需補件', '已審核', '初賽隊伍', '決賽隊伍')";
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
        String baseSql = "SELECT * FROM team as t, work as w WHERE t.TeamID=w.TeamID AND t.TeamID LIKE ?";
        StringBuilder sqlBuilder = new StringBuilder(baseSql);
    
        try (Connection conn = DatabaseConnection.getConnection()) {
            List<Object> parameters = new ArrayList<>();
    
            // 設置 TeamID 的年份參數，並添加通配符
            String teamYear = (String) constraint.get("teamyear");
            parameters.add(teamYear + "%"); // 添加必須參數（`teamyear`）
    
            // 動態添加條件
            if (!"全組別".equals(constraint.get("teamtype"))) {
                sqlBuilder.append(" AND t.TeamType = ?");
                parameters.add(constraint.get("teamtype")); // 添加參數
            }
            if (!"無".equals(constraint.get("teamstate"))) {
                sqlBuilder.append(" AND t.TeamState = ?");
                parameters.add(constraint.get("teamstate")); // 添加參數
            }
            if("無".equals(constraint.get("teamstate"))){
                sqlBuilder.append(" ORDER BY FIELD(t.TeamState, '報名待審核', '待審核初賽資格', '已補件', '需補件', '已審核', '初賽隊伍', '決賽隊伍')");
            }
            else if("全組別".equals(constraint.get("teamtype"))){
                sqlBuilder.append(" ORDER BY FIELD(t.TeamType, '創意發想組', '創業實作組')");
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

    public List<Team> getIdeaTeams(){
        List<Team> teams = new ArrayList<>();
        String sql = "SELECT * FROM team as t, work as w WHERE t.TeamID=w.TeamID and t.TeamType = '創意發想組'";
        try(Connection conn = DatabaseConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Team team = new Team();
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
                teams.add(team);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teams;
    }

    public List<Team> getBusinessTeams(){
        List<Team> teams = new ArrayList<>();
        String sql = "SELECT * FROM team as t, work as w WHERE t.TeamID=w.TeamID and t.TeamType = '創業實作組'";
        try(Connection conn = DatabaseConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Team team = new Team();
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
                teams.add(team);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teams;
    }
}
