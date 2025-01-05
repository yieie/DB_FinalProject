package com.example.demo.controller;

import com.example.demo.dao.AuthDAO;
import com.example.demo.model.Auth;
import com.example.demo.model.Student;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;

import com.example.demo.service.EmailService;


@RestController
@RequestMapping("/api/auth")
public class AuthController {
    private final AuthDAO authDAO = new AuthDAO();

    @Autowired
    private EmailService emailService;

    // @PostMapping("/login")
    // public ResponseEntity<String> login(@RequestBody Auth auth) {
    //     String usertype = auth.getUsertype();
    //     String username = auth.getUsername();
    //     String password = auth.getPassword();

    //     System.out.println(usertype);
    //     System.out.println(username);
    //     System.out.println(password);

    //     boolean isAuthenticated = authDAO.authenticate(usertype, username, password);
    //     // boolean isAuthenticated = true;
    //     if (isAuthenticated) {
    //         // 測試mail用的，之後刪掉
    //         // String randomPassword = generateRandomPassword(8);
    //         // // 發送亂數密碼到教師的 Gmail
    //         // String emailBody = "初始密碼： " + randomPassword + "\n\n" +
    //         //         "請使用以上資訊登入系統，並建議您登入後立即更改密碼。\n\n" +
    //         //         "祝好！";

    //         // emailService.sendEmail("allen6010101@gmail.com", "教師帳號創建成功", emailBody);


    //         return ResponseEntity.ok(usertype);
    //     }
    //     return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login failed");
    // }
    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> login(@RequestBody Auth auth) {
        String usertype = auth.getUsertype();
        String username = auth.getUsername();
        String password = auth.getPassword();

        System.out.println(usertype);
        System.out.println(username);
        System.out.println(password);

        boolean isAuthenticated = authDAO.authenticate(usertype, username, password);

        // 登入成功
        if (isAuthenticated) {
            Map<String, Object> response = new HashMap<>();
            response.put("usertype", usertype);
            response.put("username", username);
            response.put("message", "登入成功");
            return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(response);
        }

        // 登入失敗
        Map<String, Object> errorResponse = new HashMap<>();
        errorResponse.put("error", "InvalidCredentials");
        errorResponse.put("message", "帳號或密碼錯誤");
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorResponse);
    }


    // 只有學生要註冊
    @PostMapping("/register")
    public ResponseEntity<String> register(@RequestBody Map<String, Object> data) {
        String stuId = (String) data.get("id");
        String stuPasswd = (String) data.get("passwd");
        String stuName = (String) data.get("name");
        String stuEmail = (String) data.get("mail");
        String stuSex = (String) data.get("sexual");
        String stuPhone = (String) data.get("phone");
        String stuDepartment = (String) data.get("major");
        String stuGrade = (String) data.get("grade");

        System.out.println(stuId);
        System.out.println(stuPasswd);
        System.out.println(stuName);
        System.out.println(stuEmail);
        System.out.println(stuSex);
        System.out.println(stuPhone);
        System.out.println(stuDepartment);
        System.out.println(stuGrade);

        // boolean isRegistered = authDAO.register(stuId, stuPasswd, stuName, stuSex, stuPhone, stuEmail, stuDepartment, stuGrade);
        boolean isRegistered = true;
        if (isRegistered) {
            return ResponseEntity.ok("Register successful");
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Register failed");

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
