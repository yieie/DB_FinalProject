package com.example.demo.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.Work;
import com.example.demo.model.Workshop;
import org.springframework.web.bind.annotation.PutMapping;
import com.example.demo.dao.WorkshopDAO;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
@RequestMapping("/api/Work")
public class WorkController {
    // private final WorkDAO = new WorkDAO();

    @GetMapping("/{workid}/files")
    public ResponseEntity<Map<String, String>> getWorkFiles(@PathVariable String workid) {
        // 從資料庫拿作品的檔案
        // Map<String, String> files = WorkDAO.getWorkFiles(workid);
        Map<String, String> files = new HashMap<>();
        files.put("ppt", "http://ppt.com");
        files.put("poster", "http://poster.com");
        return ResponseEntity.ok(files);
    }

    @PostMapping("/add")
    public ResponseEntity<Void> addWork(@RequestBody Work work) {
        // WorkDAO.addWork(work);
        // 有這些會新增
        System.out.println(work.getWorkName());
        System.out.println(work.getWorkSummary());
        System.out.println(work.getWorkSdgs());
        return ResponseEntity.ok().build();
    }
}
