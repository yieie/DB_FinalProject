package com.example.demo.dao;

import com.example.demo.model.Ann;
import com.example.demo.model.Student;
import com.example.demo.config.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;

public class StudentDAO {
    public List<Student> getTeamStudents(String teamid) {
    // 查詢資料庫，根據 teamid 取得所有屬於該隊伍的學生
    String query = "SELECT StuID, StuName, StuSex, StuPhone, StuEmail, StuDepartment, StuGrade, StuIDCard, IsLeader, TeamID FROM students WHERE TeamID = ?";
    
    List<Student> students = new ArrayList<>();
    
    // 假設使用 JDBC 來查詢資料庫
    try (Connection conn = DatabaseConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(query)) {
        
        stmt.setString(1, teamid);
        ResultSet rs = stmt.executeQuery();
        
        while (rs.next()) {
            Student student = new Student();
            student.setStuID(rs.getString("StuID"));
            student.setStuName(rs.getString("StuName"));
            student.setStuSex(rs.getString("StuSex"));
            student.setStuPhone(rs.getString("StuPhone"));
            student.setStuEmail(rs.getString("StuEmail"));
            student.setStuDepartment(rs.getString("StuDepartment"));
            student.setStuGrade(rs.getString("StuGrade"));
            student.setStuIdCard(rs.getString("StuIDCard"));
            student.setStuRole(rs.getBoolean("IsLeader")); // 假設 IsLeader 代表是否是隊長
            student.setTeamId(rs.getString("TeamID"));
            students.add(student);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return students;
    }

    public Student getStudentDetails(String id) {
        String query = "SELECT StuID, StuName, StuSex, StuPhone, StuEmail, StuDepartment, StuGrade, StuIDCard, IsLeader, TeamID FROM students WHERE StuID = ?";
        
        Student student = null;
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, id); // 使用傳入的 id 來查詢資料
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                student = new Student();
                student.setStuID(rs.getString("StuID"));
                student.setStuName(rs.getString("StuName"));
                student.setStuSex(rs.getString("StuSex"));
                student.setStuPhone(rs.getString("StuPhone"));
                student.setStuEmail(rs.getString("StuEmail"));
                student.setStuDepartment(rs.getString("StuDepartment"));
                student.setStuGrade(rs.getString("StuGrade"));
                student.setStuIdCard(rs.getString("StuIDCard"));
                student.setStuRole(rs.getBoolean("IsLeader"));
                student.setTeamId(rs.getString("TeamID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return student;
    }
    
    public void updateStudent(String id, Map<String, String> data) {
        // 從 Map 中獲取需要更新的欄位資料
        String passwd = data.get("passwd");
        String name = data.get("name");
        String email = data.get("email");
        String sexual = data.get("sexual");
        String phone = data.get("phone");
    
        // SQL 更新語句，根據學生 ID 來更新資料
        String query = "UPDATE students SET StuPasswd = ?, StuName = ?, StuEmail = ?, StuSex = ?, StuPhone = ? WHERE StuID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            // 設定參數值
            stmt.setString(1, passwd);
            stmt.setString(2, name);
            stmt.setString(3, email);
            stmt.setString(4, sexual);
            stmt.setString(5, phone);
            stmt.setString(6, id);
            
            // 執行更新操作
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public String getStudentTeamId(String stuid) {
        String teamid = "無";
        
        String query = "SELECT TeamID FROM students WHERE StuID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            // 設定查詢條件
            stmt.setString(1, stuid);
            
            // 執行查詢
            ResultSet rs = stmt.executeQuery();
            
            // 如果查詢結果不為空，則取得 TeamID
            if (rs.next()) {
                teamid = rs.getString("TeamID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return teamid; // 回傳隊伍 ID 或 '無'
    }
    
    public String getStudentWorkId(String stuid) {
        String workid = "無"; // 預設為 '無'
        
        String query = "SELECT WorkID FROM students WHERE StuID = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            // 設定查詢條件
            stmt.setString(1, stuid);
            
            // 執行查詢
            ResultSet rs = stmt.executeQuery();
            
            // 如果查詢結果不為空，則取得 WorkID
            if (rs.next()) {
                workid = rs.getString("WorkID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return workid; // 回傳工作 ID 或 '無'
    }
    
}



