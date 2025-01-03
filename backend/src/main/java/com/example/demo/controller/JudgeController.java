package com.example.demo.controller;

import org.springframework.web.bind.annotation.RestController;

import com.example.demo.dao.WorkshopDAO;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import com.example.demo.model.Judge;


@RestController
@RequestMapping("/api/Judge")
public class JudgeController {
    // private final JudgeDAO judgeDAO = new JudgeDAO();

    @PostMapping("/add")
    public ResponseEntity<Void> addJudge(@RequestBody Judge judge) {
        // boolean isAdded = judgeDAO.addJudge(judge);
        boolean isAdded = true; // 假設新增成功，測試用

        if(isAdded) {
            return ResponseEntity.status(HttpStatus.CREATED).build();
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
    }
}
