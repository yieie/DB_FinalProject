package com.example.demo.dao;

import com.example.demo.model.Auth;
import com.example.demo.config.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class AuthDAO {
    public boolean authenticate(String username, String password) {
        String sql = "SELECT password FROM USERS WHERE username = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                String encodedPassword = rs.getString("password"); // 取出加密的密碼
                return new BCryptPasswordEncoder().matches(password, encodedPassword); // 比較加密密碼
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    

    public boolean register(Auth auth) {
        String sql = "INSERT INTO USERS (username, password) VALUES (?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, auth.getUsername());
            // pstmt.setString(2, auth.getPassword());
            pstmt.setString(2, new BCryptPasswordEncoder().encode(auth.getPassword()));
            pstmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
