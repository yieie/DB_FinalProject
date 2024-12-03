package com.example.demo;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.HashMap;

@SpringBootApplication
public class DemoApplication implements CommandLineRunner {

    @Autowired
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

    @Configuration
    public class WebConfig implements WebMvcConfigurer {
        @Override
        public void addCorsMappings(CorsRegistry registry) {
            registry.addMapping("/api/**")
                .allowedOrigins("*")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(true);
        }
    }

    @Override
    public void run(String... args) throws Exception {
        try {
            String sql = "SELECT 1";
            Integer result = namedParameterJdbcTemplate.queryForObject(sql, new HashMap<>(), Integer.class);
            if (result != null && result == 1) {
                System.out.println("MySQL connection successful!");
            }
        } catch (Exception e) {
            System.out.println("Error connecting to MySQL: " + e.getMessage());
        }
    }
}