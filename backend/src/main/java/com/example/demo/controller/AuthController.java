package com.example.demo.controller;

import com.example.demo.dao.AuthDAO;
import com.example.demo.model.Auth;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    private AuthDAO authDAO = new AuthDAO();
    private static final String SECRET_KEY = "V1p1Wk9vVXo1aDFMSzdETXJPaDFmckpCUlh4c01Hc0M=";

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Auth auth) {
        System.out.println("Received request: " + auth.toString());
        boolean isAuthenticated = authDAO.authenticate(auth.getUsername(), auth.getPassword());
        if (isAuthenticated) {
            String token = Jwts.builder()
                    .setSubject(auth.getUsername())
                    .setIssuedAt(new Date())
                    .setExpiration(new Date(System.currentTimeMillis() + 1000 * 60 * 60)) // 1 小時
                    .signWith(SignatureAlgorithm.HS256, SECRET_KEY)
                    .compact();
            return ResponseEntity.ok(token);
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
    }

    @PostMapping("/register")
    public ResponseEntity<Auth> register(@RequestBody Auth auth) {
        boolean isRegistered = authDAO.register(auth);
        if (isRegistered) {
            return ResponseEntity.status(HttpStatus.CREATED).body(auth);
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
    }
}
