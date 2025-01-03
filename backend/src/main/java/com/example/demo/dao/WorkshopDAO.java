package com.example.demo.dao;

import com.example.demo.model.Workshop;
import com.example.demo.config.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Locale;
import java.text.SimpleDateFormat;
import java.text.ParseException;


public class WorkshopDAO {
    public String convertTo24(String time12Hour) {

        // 去除首尾空格
        time12Hour = time12Hour.trim();
    
        // 檢查 AM 或 PM
        String amPm = time12Hour.substring(time12Hour.length() - 2).toUpperCase(); // 取得 AM/PM
        String timeWithoutAmPm = time12Hour.substring(0, time12Hour.length() - 2).trim(); // 去除 AM/PM 部分
    
        // 分割時間
        String[] timeParts = timeWithoutAmPm.split(":");
        int hour = Integer.parseInt(timeParts[0]);
        int minute = Integer.parseInt(timeParts[1]);
    
        // 根據 AM/PM 進行轉換
        if (amPm.equals("AM")) {
            if (hour == 12) {
                hour = 0; // 12 AM 轉為 00
            }
        } else if (amPm.equals("PM")) {
            if (hour != 12) {
                hour += 12; // PM 時間加 12，除非是 12 PM
            }
        }
    
        // 格式化為 24 小時制時間字串，並加上秒數部分
        return String.format("%02d:%02d:00", hour, minute);
    }

    public Workshop getWorkshopById(int id){
        Workshop workshop = null;
        String sql = "SELECT w.WSID, WSDate, WSTime, WSTopic, LectName, LectTitle, LectPhone, LectEmail, LectAddress"+
        "FROM work_shop as w, lecturer as l WHERE w.WSID = ? and w.WSID = l.WSID";
        try(Connection conn = DatabaseConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id); 

            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) {
                workshop = new Workshop();
                workshop.setWsid(rs.getInt("WSID"));
                workshop.setWsdate(rs.getDate("WSDate").toString());
                workshop.setWstime(rs.getTime("WSTime").toString());
                workshop.setWstopic(rs.getString("WSTopic"));
                workshop.setLectName(rs.getString("LectName"));
                workshop.setLecttitle(rs.getString("LectTitle"));
                workshop.setLectphone(rs.getString("LectPhone"));
                workshop.setLectemail(rs.getString("LectEmail"));
                workshop.setLectaddr(rs.getString("LectAddress"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return workshop;
    }

    public boolean addWorkshop(Workshop workshop) {
        String workshopSql = "INSERT INTO work_shop (WSDate, WSTime, WSTopic) VALUES (?, ?, ?)";
        String lecturerSql = "INSERT INTO lecturer (LectName, LectTitle, LectPhone, LectEmail, LectAddress, WSID) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement workshopStmt = conn.prepareStatement(workshopSql, Statement.RETURN_GENERATED_KEYS);
            PreparedStatement lecturerStmt = conn.prepareStatement(lecturerSql)) {

            String sqlDate = workshop.getWsdate();
            workshopStmt.setDate(1, Date.valueOf(sqlDate));

            //12 to 24小時制轉換
            String time12Hour = workshop.getWstime(); // 去除首尾空格
            String time24Hour = convertTo24(time12Hour); // 轉換為 24 小時制
            workshopStmt.setTime(2, Time.valueOf(time24Hour));

            workshopStmt.setString(3, workshop.getWstopic());
            workshopStmt.executeUpdate();

            ResultSet rs = workshopStmt.getGeneratedKeys();
            if (rs.next()) {
                int wsid = rs.getInt(1); // 自動生成的 WSID
                // 插入 lecturers
                lecturerStmt.setString(1, workshop.getlectname());
                lecturerStmt.setString(2, workshop.getLecttitle());
                lecturerStmt.setString(3, workshop.getLectphone());
                lecturerStmt.setString(4, workshop.getLectemail());
                lecturerStmt.setString(5, workshop.getLectaddr());
                lecturerStmt.setInt(6, wsid);
                lecturerStmt.executeUpdate();
            }
            return true; // 成功執行
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
