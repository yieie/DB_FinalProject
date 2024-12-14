package com.example.demo.dao;

import com.example.demo.model.Ann;
import com.example.demo.config.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    public boolean authenticate(String stuId, String stuPasswd) {
        String sql = "SELECT StuPasswd FROM student WHERE StuID = ?";
        try(Connection conn = DatabaseConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, stuId); //將第一個問號設為controller傳進來的stuId
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) {
                String storedPassword = rs.getString("StuPasswd");
                return stuPasswd.equals(storedPassword);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean register(String stuId, String stuPasswd, String stuName, String stuSex, String stuPhone, String stuEmail, String stuDepartment, String stuGrade) {
        String sql = "INSERT INTO student(StuID, StuPasswd, StuName, StuSex, StuPhone, StuEmail, StuDepartment, StuGrade) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
        try(Connection conn = DatabaseConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, stuId);
            pstmt.setString(2, stuPasswd);
            pstmt.setString(3, stuName);
            pstmt.setString(4, stuSex);
            pstmt.setString(5, stuPhone);
            pstmt.setString(6, stuEmail);
            pstmt.setString(7, stuDepartment);
            pstmt.setString(8, stuGrade);
            pstmt.executeUpdate();
            return true; 
        } catch (SQLException e) {
            e.printStackTrace();
            return false; //插入失敗
        }
    }
}



