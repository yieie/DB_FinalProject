package com.example.demo.dao;

import com.example.demo.model.Judge;
import com.example.demo.model.Teacher;
import com.example.demo.config.DatabaseConnection;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class JudgeDAO {
    public boolean addJudge(Judge judge) {
        String sql1 = "INSERT INTO teacher_judge (TJEmail, TJPassword, TJName, TJSex, TJPhone) VALUES (?, ?, ?, ?, ?)";
        String sql2 = "INSERT INTO judge (JudgeTitle, TJEmail) VALUES (?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt1 = conn.prepareStatement(sql1);
             PreparedStatement pstmt2 = conn.prepareStatement(sql2)) {

            String email = judge.getJudgeid(); // 假設 getJudgeid() 返回的是 Email
            String password = email.substring(0, email.indexOf('@')); // 提取 @ 前的部分
            pstmt1.setString(1, judge.getJudgeid());
            pstmt1.setString(2, password);
            pstmt1.setString(3, judge.getJudgename());
            pstmt1.setString(4, judge.getJudgesexual());
            pstmt1.setString(5, judge.getJudgephone());

            pstmt2.setString(1, judge.getJudgetitle());
            pstmt2.setString(2, judge.getJudgeid());

            pstmt1.executeUpdate();
            pstmt2.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Judge getJudgeDetails(String id) {
        Judge judge = null;
        String sql = "SELECT * FROM teacher_judge AS tj LEFT JOIN judge AS d ON tj.TJEmail = d.TJEmail WHERE tj.TJEmail = ?";

        try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                judge = new Judge();
                judge.setJudgeid(rs.getString("TJEmail"));
                judge.setJudgepasswd(rs.getString("TJPassword"));
                judge.setJudgename(rs.getString("TJName"));
                judge.setJudgeemail(rs.getString("TJEmail"));
                judge.setJudgesexual(rs.getString("TJSex"));
                judge.setJudgephone(rs.getString("TJPhone"));
                judge.setJudgetitle(rs.getString("JudgeTitle"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return judge;
    }

    
    public boolean updateJudge(Judge judge) {
        String sql1 = "UPDATE teacher_judge SET TJPassword = ?, TJName = ?, TJSex = ?, TJPhone = ? WHERE TJEmail = ?";
        String sql2 = "UPDATE judge SET JudgeTitle = ? WHERE TJEmail = ?";
        try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement pstmt1 = conn.prepareStatement(sql1);
            PreparedStatement pstmt2 = conn.prepareStatement(sql2)) {

            // 更新 teacher_judge 資料表
            pstmt1.setString(1, judge.getJudgepasswd());
            pstmt1.setString(2, judge.getJudgename());
            pstmt1.setString(3, judge.getJudgesexual());
            pstmt1.setString(4, judge.getJudgephone());
            pstmt1.setString(5, judge.getJudgeid());  // 根據 Email (JudgeID) 更新

            // 更新 judge 資料表
            pstmt2.setString(1, judge.getJudgetitle());
            pstmt2.setString(2, judge.getJudgeid());  // 根據 Email (JudgeID) 更新

            // 執行更新語句
            pstmt1.executeUpdate();
            pstmt2.executeUpdate();

            return true;  // 更新成功
        } catch (SQLException e) {
            e.printStackTrace();
            return false;  // 發生錯誤，更新失敗
        }
    }

    public List<Judge> getAllJudges(){
        List<Judge> judges = new ArrayList<>();
        String sql1 = "SELECT * FROM judge";
        String sql2 = "SELECT * FROM teacher_judge WHERE TJEmail = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt1 = conn.prepareStatement(sql1);
             PreparedStatement pstmt2 = conn.prepareStatement(sql2);
             ResultSet rs1 = pstmt1.executeQuery()) {
            
            while (rs1.next()) {
                Judge judge = new Judge();
                judge.setJudgetitle(rs1.getString("JudgeTitle"));
                judge.setJudgeid(rs1.getString("TJEmail"));
                judge.setJudgeemail(rs1.getString("TJEmail"));

                pstmt2.setString(1, judge.getJudgeid());
                try (ResultSet rs2 = pstmt2.executeQuery()) {
                    if (rs2.next()) {
                        judge.setJudgename(rs2.getString("TJName"));
                        judge.setJudgesexual(rs2.getString("TJSex"));
                        judge.setJudgephone(rs2.getString("TJPhone"));
                    }
                }

                judges.add(judge);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return judges;
    }
}
