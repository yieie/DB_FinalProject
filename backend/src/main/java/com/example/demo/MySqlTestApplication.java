package com.example.demo;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.beans.factory.annotation.Autowired;

@SpringBootApplication
public class MySqlTestApplication implements CommandLineRunner {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public static void main(String[] args) {
        SpringApplication.run(MySqlTestApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        try {
            // 測試簡單的查詢語句，看看是否成功連接到 MySQL
            String sql = "SELECT 1";
            Integer result = jdbcTemplate.queryForObject(sql, Integer.class);

            if (result != null && result == 1) {
                System.out.println("MySQL connection successful!");
            } else {
                System.out.println("Failed to connect to MySQL.");
            }
        } catch (Exception e) {
            System.out.println("Error connecting to MySQL: " + e.getMessage());
        }
    }
}
