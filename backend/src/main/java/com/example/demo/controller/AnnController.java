package com.example.demo.controller;

import com.example.demo.dao.AnnDAO;
import com.example.demo.model.Ann;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/Ann")
public class AnnController {
    private final AnnDAO annDAO = new AnnDAO();

    @GetMapping("/list")
    public ResponseEntity<List<Ann>> getAllAnnouncements() {
        List<Ann> announcements = annDAO.getAllAnnouncements();
        return ResponseEntity.ok(announcements);
    }

    @PostMapping("/add")
    public ResponseEntity<String> addAnnouncement(@RequestBody Ann ann) {
        boolean isAdded = annDAO.addAnnouncement(ann);
        if(isAdded) {
            return ResponseEntity.status(HttpStatus.CREATED).body("Announcement added successfully");
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to add announcement");
        }
    }
}
