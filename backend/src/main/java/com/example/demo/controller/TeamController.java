package com.example.demo.controller;

import com.example.demo.model.Team;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
import java.util.HashMap;

@RestController
@RequestMapping("/api/Teams")
public class TeamController {
    @PostMapping("/Status")
    public ResponseEntity<Map<String, Object>> postTeamStatus(@RequestBody Map<String, Object> json) {
        int amounts = (int) json.getOrDefault("amounts", 0);//隊伍總數
        int approved = (int) json.getOrDefault("approved", 0);//審核通過數量
        int notreview = (int) json.getOrDefault("notreview", 0);//未審核數量
        int incomplete = (int) json.getOrDefault("incomplete", 0);//需補件數量
        int qualifying = (int) json.getOrDefault("qualifying", 0);//進初賽隊伍數量
        int finalround = (int) json.getOrDefault("finalround", 0);

        Map<String, Object> response = new HashMap<>();
        response.put("amounts", amounts);
        response.put("approved", approved);
        response.put("notreview", notreview);
        response.put("incomplete", incomplete);
        response.put("qualifying", qualifying);
        response.put("finalround", finalround);

        return ResponseEntity.ok(response);
    }
}
