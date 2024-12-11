package com.example.demo.controller;

import com.example.demo.dao.AuthDAO;
import com.example.demo.model.Auth;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    private final AuthDAO authDAO = new AuthDAO();

    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody Auth auth) {
        String username = auth.getUsername();
        String password = auth.getPassword();

        boolean isAuthenticated = authDAO.authenticate(username, password);
        if (isAuthenticated) {
            return ResponseEntity.ok("Login successful");
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
