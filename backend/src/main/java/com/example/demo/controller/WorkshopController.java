package com.example.demo.controller;

import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import com.example.demo.model.Workshop;
import org.springframework.web.bind.annotation.PutMapping;
import com.example.demo.dao.WorkshopDAO;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.Map;


@RestController
@RequestMapping("/api/Workshop")
public class WorkshopController {
    private final WorkshopDAO workshopDAO = new WorkshopDAO();

    @GetMapping("/all")
    public ResponseEntity<List<Workshop>> getAllWorkshops() {
        List<Workshop> workshops = workshopDAO.getAllWorkshops();

        if (workshops != null) {
            return ResponseEntity.ok(workshops);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null); 
        }
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<Workshop> getWorkshopById(@PathVariable int id) {
        Workshop workshop = workshopDAO.getWorkshopById(id);
        if (workshop != null) {
            return ResponseEntity.ok(workshop);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null); 
        }
    }
    

    @PostMapping("/add")
    public ResponseEntity<Boolean> addWorkshop(@RequestBody Workshop workshop) {
        boolean isAdded = workshopDAO.addWorkshop(workshop);

        if (isAdded) {
            return ResponseEntity.status(HttpStatus.CREATED).body(true); // 成功回傳 true
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(false); // 失敗回傳 false
        }
    }

    @PutMapping("edit/{id}")
    public ResponseEntity<Boolean> putMethodName(@PathVariable int id, @RequestBody Workshop workshop) {
        // 取得前端傳來的資料
        System.out.println("id: " + id);

        boolean isUpdated = workshopDAO.updateWorkshop(workshop);

        if (isUpdated) {
            return ResponseEntity.status(HttpStatus.OK).body(true); // 成功回傳 true
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(false); // 失敗回傳 false
        }
    }

    //學生報名工作坊，送學生id到後端
    @PostMapping("/register/{wsid}")
    public ResponseEntity<Boolean> registerWorkshop(@PathVariable int wsid, @RequestBody Map<String, String> stuid) {
        boolean isRegistered = workshopDAO.registerWorkshop(wsid, stuid);
        //boolean isRegistered = true; // 假設報名成功，測試用
        System.out.println(wsid+"詭異"+stuid);
        if (isRegistered) {
            return ResponseEntity.status(HttpStatus.OK).body(true); // 成功回傳 true
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(false); // 失敗回傳 false
        }
    }
}