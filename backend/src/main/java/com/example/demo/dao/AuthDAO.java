package com.example.demo.dao;

import com.example.demo.config.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AuthDAO {
    public boolean authenticate(String usertype, String username, String password) {
        // 根據 usertype 選擇對應的表和字段
        String tableName;
        String userIdField;
        String passwordField;

        switch (usertype.toLowerCase()) {
            case "admin":
                tableName = "admin";
                userIdField = "AdminID";
                passwordField = "AdminPasswd";
                break;
            case "stu":
                tableName = "student";
                userIdField = "StuID";
                passwordField = "StuPasswd";
                break;
            case "tr":
                tableName = "teacher";
                userIdField = "TJEmail";
                passwordField = "TJPassword"; // 這裡要和資料庫的欄位名稱一樣
                break;
            case "judge":
                tableName = "judge";
                userIdField = "TJEmail";
                passwordField = "TJPassword";  // 這裡要和資料庫的欄位名稱一樣
                break;
            default:
                throw new IllegalArgumentException("Invalid usertype: " + usertype);
        }

        // SQL 查詢語句
        String sql = String.format("SELECT %s FROM %s WHERE %s = ?", passwordField, tableName, userIdField);
        System.out.println(sql);

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // 設置查詢參數
            pstmt.setString(1, username);
            // 執行查詢
            ResultSet rs = pstmt.executeQuery();
                System.out.println(rs);
            if (rs.next()) {
                String storedPassword = rs.getString(passwordField);
                return password.equals(storedPassword);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // 若未找到用戶或發生錯誤，返回 false
        return false;
    }
}
