package com.example.demo.controller;

import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import com.example.demo.model.Workshop;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.Map;


@RestController
@RequestMapping("/api/Workshop")
public class WorkshopController {
    private static final Map<Integer, Workshop> workshopDatabase = new HashMap<>();
    static {
        // 假資料，測試用
        Workshop workshop1 = new Workshop();
        workshop1.setWsid(1);
        workshop1.setWsdate("2024-12-30");
        workshop1.setWstime("10:00 AM");
        workshop1.setWstopic("Spring Boot Workshop");
        workshop1.setLectName("John Doe");
        workshop1.setLecttitle("Professor");
        workshop1.setLectphone("123456789");
        workshop1.setLectemail("john.doe@example.com");
        workshop1.setLectaddr("123 Main St.");
        workshopDatabase.put(workshop1.getWsid(), workshop1);
    }


    @GetMapping("/{id}")
    public ResponseEntity<Workshop> getWorkshopById(@PathVariable int id) {
        // Workshop workshop = workshopDAO.getWorkshopById(id);
        Workshop workshop = workshopDatabase.get(id); // 假資料，測試用
        if (workshop != null) {
            return ResponseEntity.ok(workshop);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null); 
        }
    }
    

    @PostMapping("/add")
    public ResponseEntity<Boolean> addWorkshop(@RequestBody Workshop workshop) {
        // boolean isAdded = workshopDAO.addWorkshop(workshop);

        // boolean isAdded = workshopDAO.addWorkshop(workshop);
        boolean isAdded = true; // 假設新增成功，測試用

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

        // boolean isUpdated = workshopDAO.updateWorkshop(workshop);
        boolean isUpdated = true; // 假設更新成功，測試用

        if (isUpdated) {
            return ResponseEntity.status(HttpStatus.OK).body(true); // 成功回傳 true
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(false); // 失敗回傳 false
        }
    }
}
