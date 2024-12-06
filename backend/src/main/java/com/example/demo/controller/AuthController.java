package com.example.demo.controller;

import com.example.demo.dao.AuthDAO;
import com.example.demo.model.Auth;
import com.example.demo.security.JwtUtils;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import java.util.Date;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    private AuthDAO authDAO = new AuthDAO();
    @Value("${jwt.secret}")
    private String SECRET_KEY;


    @Autowired
    private JwtUtils jwtUtils;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Auth auth) {
        boolean isAuthenticated = authDAO.authenticate(auth.getUsername(), auth.getPassword());
        if (isAuthenticated) {
            String token = jwtUtils.generateToken(auth.getUsername());
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
