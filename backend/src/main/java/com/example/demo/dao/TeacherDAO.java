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

    // 根據教師 email 查詢教師資料
    public Teacher getTeacherByEmail(String email) {
        Teacher teacher = null;
        String sql = "SELECT * FROM teacher_judge WHERE TJEmail = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                teacher = new Teacher();
                teacher.setTrId(rs.getString("tr_id"));
                teacher.setTrName(rs.getString("tr_name"));
                teacher.setTrEmail(rs.getString("tr_email"));
                teacher.setTrSexual(rs.getString("tr_sexual"));
                teacher.setTrPhone(rs.getString("tr_phone"));
                teacher.setTrJobType(rs.getString("tr_job_type"));
                teacher.setTrDepartment(rs.getString("tr_department"));
                teacher.setTrOrganization(rs.getString("tr_organization"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teacher;
    }

    // 根據教師 ID 查詢詳細資料
    public Teacher getTeacherDetails(String id) {
        Teacher teacher = null;
        String sql = "SELECT tr_id, tr_name, tr_email, tr_sexual, tr_phone, tr_job_type, tr_department, tr_organization FROM teacher WHERE tr_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                teacher = new Teacher();
                teacher.setTrId(rs.getString("tr_id"));
                teacher.setTrName(rs.getString("tr_name"));
                teacher.setTrEmail(rs.getString("tr_email"));
                teacher.setTrSexual(rs.getString("tr_sexual"));
                teacher.setTrPhone(rs.getString("tr_phone"));
                teacher.setTrJobType(rs.getString("tr_job_type"));
                teacher.setTrDepartment(rs.getString("tr_department"));
                teacher.setTrOrganization(rs.getString("tr_organization"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teacher;
    }

    // 註冊新教師
    public boolean registerTeacher(Teacher teacher) {
        String sql = "INSERT INTO teacher (tr_id, tr_name, tr_email, tr_sexual, tr_phone, tr_job_type, tr_department, tr_organization) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, teacher.getTrId());
            pstmt.setString(2, teacher.getTrName());
            pstmt.setString(3, teacher.getTrEmail());
            pstmt.setString(4, teacher.getTrSexual());
            pstmt.setString(5, teacher.getTrPhone());
            pstmt.setString(6, teacher.getTrJobType());
            pstmt.setString(7, teacher.getTrDepartment());
            pstmt.setString(8, teacher.getTrOrganization());

            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 更新教師資料
    public boolean updateTeacher(String id, Teacher teacher) {
        String sql = "UPDATE teacher SET tr_name = ?, tr_email = ?, tr_sexual = ?, tr_phone = ?, tr_job_type = ?, tr_department = ?, tr_organization = ? WHERE tr_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, teacher.getTrName());
            pstmt.setString(2, teacher.getTrEmail());
            pstmt.setString(3, teacher.getTrSexual());
            pstmt.setString(4, teacher.getTrPhone());
            pstmt.setString(5, teacher.getTrJobType());
            pstmt.setString(6, teacher.getTrDepartment());
            pstmt.setString(7, teacher.getTrOrganization());
            pstmt.setString(8, id);

            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 查詢所有教師資料
    public List<Teacher> getAllTeachers() {
        List<Teacher> teachers = new ArrayList<>();
        String sql = "SELECT tr_id, tr_name, tr_email, tr_sexual, tr_phone, tr_job_type, tr_department, tr_organization FROM teacher";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Teacher teacher = new Teacher();
                teacher.setTrId(rs.getString("tr_id"));
                teacher.setTrName(rs.getString("tr_name"));
                teacher.setTrEmail(rs.getString("tr_email"));
                teacher.setTrSexual(rs.getString("tr_sexual"));
                teacher.setTrPhone(rs.getString("tr_phone"));
                teacher.setTrJobType(rs.getString("tr_job_type"));
                teacher.setTrDepartment(rs.getString("tr_department"));
                teacher.setTrOrganization(rs.getString("tr_organization"));
                teachers.add(teacher);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teachers;
    }
}
