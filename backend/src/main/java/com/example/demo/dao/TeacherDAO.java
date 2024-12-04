package com.example.demo.dao;
import com.example.demo.model.Teacher;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import com.example.demo.config.DatabaseConnection;


public class TeacherDAO {
    public void addTeacher(Teacher teacher) {
        String sql = "INSERT INTO TEACHER (TEACHER_ID, TeacherName, JobType, Department, Organization) VALUES (?, ?, ?, ?, ?)";
        
        try(Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, String.valueOf(teacher.getTeacherId()));
            pstmt.setString(2, teacher.getTeacherName());
            pstmt.setInt(3, teacher.getJobType());
            pstmt.setString(4, teacher.getDepartment());
            pstmt.setString(5, teacher.getOrganization());
            
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Teacher getTeacherById(String teacherId) {
        String sql = "SELECT * FROM TEACHER WHERE TEACHER_ID = ?";
        Teacher teacher = null;
        
        try(Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) { // prepared statement 表示一個SQL語句，可以用?來代替參數
            
            pstmt.setString(1, teacherId); 
            ResultSet rs = pstmt.executeQuery();
            
            if(rs.next()) {
                teacher = new Teacher();
                teacher.setTeacherId(rs.getInt("TEACHER_ID"));
                teacher.setTeacherName(rs.getString("TeacherName"));
                teacher.setJobType(rs.getInt("JobType"));
                teacher.setDepartment(rs.getString("Department"));
                teacher.setOrganization(rs.getString("Organization"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return teacher;
    }

    public List<Teacher> getAllTeachers() {
        List<Teacher> teachers = new ArrayList<>();
        String sql = "SELECT * FROM TEACHER";
        
        try(Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while(rs.next()) {
                Teacher teacher = new Teacher();
                teacher.setTeacherId(rs.getInt("TEACHER_ID"));
                teacher.setTeacherName(rs.getString("TeacherName"));
                teacher.setJobType(rs.getInt("JobType"));
                teacher.setDepartment(rs.getString("Department"));
                teacher.setOrganization(rs.getString("Organization"));
                teachers.add(teacher);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        
        return teachers;
    }

    public void updateTeacher(Teacher teacher) {
        String sql = "UPDATE TEACHER SET TeacherName = ?, JobType = ?, Department = ?, Organization = ? WHERE TEACHER_ID = ?";
        
        try(Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, teacher.getTeacherName());
            pstmt.setInt(2, teacher.getJobType());
            pstmt.setString(3, teacher.getDepartment());
            pstmt.setString(4, teacher.getOrganization());
            pstmt.setString(5, String.valueOf(teacher.getTeacherId()));
            
            pstmt.executeUpdate();
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteTeacher(String teacherId) {
        String sql = "DELETE FROM TEACHER WHERE TEACHER_ID = ?";
        
        try(Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, teacherId);
            pstmt.executeUpdate();
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }
}