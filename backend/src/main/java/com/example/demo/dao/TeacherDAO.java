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
    public boolean updateTeacher(String id, Teacher teacher) {
        String sql = "UPDATE teacher_judge SET TJEmail = ?, TJPassword=?, TJName = ?, TJSex = ?, TJPhone = ? WHERE TJEmail = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, teacher.getTrId());
            pstmt.setString(2, teacher.getTrPassword());
            pstmt.setString(3, teacher.getTrName());
            pstmt.setString(4, teacher.getTrSexual());
            pstmt.setString(5, teacher.getTrPhone());
            pstmt.setString(6, id);

            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
