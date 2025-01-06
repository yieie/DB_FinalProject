package com.example.demo.dao;
import com.example.demo.model.Teacher;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.example.demo.config.DatabaseConnection;

public class TeacherDAO {

    // 根據教師 email 查詢教師資料
    public Teacher getTeacherDetails(String id) {
        Teacher teacher = null;
        String sql = "SELECT * FROM teacher_judge AS tj LEFT JOIN teacher AS t ON tj.TJEmail = t.TJEmail WHERE tj.TJEmail = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                teacher = new Teacher();
                teacher.setTrId(rs.getString("TJEmail"));
                teacher.setTrName(rs.getString("TJName"));
                teacher.setTrPasswd(rs.getString("TJPassword"));
                teacher.setTrEmail(rs.getString("TJemail"));
                teacher.setTrSexual(rs.getString("TJSex"));
                teacher.setTrPhone(rs.getString("TJPhone"));
                teacher.setTrJobType(rs.getString("TrJobType"));
                teacher.setTrDepartment(rs.getString("TrDepartment"));
                teacher.setTrOrganization(rs.getString("TrOrganization"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teacher;
    }

    // 更新教師資料
    public boolean updateTeacher(String id, Map<String, String> data) {
        String sql = "UPDATE teacher_judge SET TJEmail = ?, TJName = ?, TJSex = ?, TJPhone = ? WHERE TJEmail = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, data.get("id"));
            pstmt.setString(2, data.get("name"));
            pstmt.setString(3, data.get("sexual"));
            pstmt.setString(4, data.get("phone"));
            pstmt.setString(5, data.get("id"));

            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addTeacher(Teacher teacher){
        String sql1 = "INSERT INTO teacher_judge (TJEmail, TJName, TJSex, TJPhone) VALUES (?, ?, ?, ?)";
        String sql2 = "INSERT INTO teacher (TJEmail, TrJobType, TrDepartment, TrOrganization) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt1 = conn.prepareStatement(sql1);
             PreparedStatement pstmt2 = conn.prepareStatement(sql2)) {

            // 更新 teacher_judge 資料表
            pstmt1.setString(1, teacher.getTrId());
            //pstmt1.setString(2, teacher.getTrPassword());
            pstmt1.setString(2, teacher.getTrName());
            pstmt1.setString(3, teacher.getTrSexual());
            pstmt1.setString(4, teacher.getTrPhone());

            // 更新 teacher 資料表
            pstmt2.setString(1, teacher.getTrId());
            pstmt2.setString(2, teacher.getTrJobType());
            pstmt2.setString(3, teacher.getTrDepartment());
            pstmt2.setString(4, teacher.getTrOrganization());

            // 執行更新語句
            pstmt1.executeUpdate();
            pstmt2.executeUpdate();

            return true;  // 更新成功
        } catch (SQLException e) {
            e.printStackTrace();
            return false;  // 發生錯誤，更新失敗
        }
    }

}
