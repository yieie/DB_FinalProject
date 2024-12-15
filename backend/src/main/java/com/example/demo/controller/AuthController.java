package com.example.demo.controller;

import com.example.demo.dao.AuthDAO;
import com.example.demo.model.Auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.security.SecureRandom;
import com.example.demo.service.EmailService;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    private final AuthDAO authDAO = new AuthDAO();

    @Autowired
    private EmailService emailService;

    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody Auth auth) {
        String username = auth.getUsername();
        String password = auth.getPassword();

        boolean isAuthenticated = authDAO.authenticate(username, password);
        if (isAuthenticated) {
            // 測試mail用的，之後刪掉
            // String randomPassword = generateRandomPassword(8);
            // // 發送亂數密碼到教師的 Gmail
            // String emailBody = "初始密碼： " + randomPassword + "\n\n" +
            //         "請使用以上資訊登入系統，並建議您登入後立即更改密碼。\n\n" +
            //         "祝好！";

            // emailService.sendEmail("allen6010101@gmail.com", "教師帳號創建成功", emailBody);


            return ResponseEntity.ok("Login successful");
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
    }

    // 生亂數密碼
    // private String generateRandomPassword(int length) {
    //     String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    //     SecureRandom random = new SecureRandom();
    //     StringBuilder password = new StringBuilder();

    //     for (int i = 0; i < length; i++) {
    //         password.append(chars.charAt(random.nextInt(chars.length())));
    //     }
    //     return password.toString();
    // }
}
