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
import com.example.demo.model.Teacher;
import com.example.demo.dao.JudgeDAO;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;



@RestController
@RequestMapping("/api/Judge")
public class JudgeController {
    private final JudgeDAO judgeDAO = new JudgeDAO();

    @PostMapping("/add")
    public ResponseEntity<Void> addJudge(@RequestBody Judge judge) {
        boolean isAdded = judgeDAO.addJudge(judge);
        
        if(isAdded) {
            return ResponseEntity.status(HttpStatus.CREATED).build();
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
    }

    @GetMapping("/detailsData/{id}")
    public ResponseEntity<Judge> getJudgeDetails(@PathVariable String id) {
        //Judge judge = judgeDAO.getJudgeDetails(id);
        Judge judge = new Judge();
        // judge.setJudgeid(id);
        judge.setJudgename("王小明");
        judge.setJudgeemail("mail.com");
        judge.setJudgesexual("男");
        judge.setJudgephone("0912345678");
        judge.setJudgetitle("教授");

        return ResponseEntity.ok(judge);
    }
    
    //更新使用者資料
    @PostMapping("/{id}/update")
    public ResponseEntity<Void> updateJudge(@PathVariable String id, @RequestBody Map<String, String> data) {
        // teamDAO.updateJudge(data);
        // 有這些會改
        // 'passwd': passwd,
        // 'name': name,
        // 'sexual': sexual,
        // 'phone': phone
        System.out.println(data.get("id"));
        System.out.println(data.get("passwd"));
        System.out.println(data.get("name"));
        System.out.println(data.get("email"));
        System.out.println(data.get("sexual"));
        System.out.println(data.get("phone"));
        return ResponseEntity.ok().build();
    }

    @GetMapping("/all")
    public ResponseEntity<List<Judge>> getAllJudges() {
        // List<Judge> judges = judgeDAO.getAllJudges();

        Judge judge1 = new Judge();
        judge1.setJudgeid("1");
        judge1.setJudgename("王小明");
        judge1.setJudgeemail("mail.com");
        judge1.setJudgesexual("男");
        judge1.setJudgephone("0912345678");
        judge1.setJudgetitle("教授");
        List<Judge> judges = List.of(judge1);
        return ResponseEntity.ok(judges);
    } 
}
