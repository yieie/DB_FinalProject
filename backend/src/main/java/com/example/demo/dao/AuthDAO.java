package com.example.demo.dao;

import com.example.demo.model.Auth;
import com.example.demo.config.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AuthDAO {
    public boolean authenticate(String username, String password) {
        System.out.println("username: " + username);
        String sql = "SELECT COUNT(*) FROM USERS WHERE username = ? AND password = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            System.out.println("pstmt: " + pstmt);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
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
            pstmt.setString(1, String.valueOf(auth.getUsername()));
            pstmt.setString(2, auth.getPassword());
            pstmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
