package com.example.demo.controller;

import com.example.demo.model.Team;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/api/Teams")
public class TeamController {
    // private final TeamDAO teamDAO = new TeamDAO();
    
    @GetMapping("/Status")
    public ResponseEntity<Map<String, Object>> getTeamStatus() {

        // 資料庫查隊伍狀態，寫完DAO再取消註解
        
        // int amounts = teamDAO.getTotalTeams();//隊伍總數
        // int approved = teamDAO.getApprovedTeams();//審核通過數量
        // int notreview = teamDAO.getNotReviewedTeams();//未審核數量
        // int incomplete = teamDAO.getIncompleteTeams();//需補件數量
        // int qualifying = teamDAO.getQualifyingTeams();//進初賽隊伍數量
        // int finalround = teamDAO.getFinalRoundTeams();//進決賽隊伍數量

        Map<String, Object> response = new HashMap<>();
        // 假資料
        response.put("amounts", 100);
        response.put("approved", 50);
        response.put("notreview", 10);
        response.put("incomplete", 5);
        response.put("qualifying", 30);
        response.put("finalround", 20);

        // response.put("amounts", amounts);
        // response.put("approved", approved);
        // response.put("notreview", notreview);
        // response.put("incomplete", incomplete);
        // response.put("qualifying", qualifying);
        // response.put("finalround", finalround);

        return ResponseEntity.ok(response);
    }

    @GetMapping("Cond")
    public ResponseEntity<List<Map<String, Object>>> getBasicAllTeam() {
        // 前端要所有隊伍的基本資料
        // 寫完DAO再取消註解
        // List<Team> teams = teamDAO.getAllBasicTeams();

        
        // return teams.stream().map(team -> Map.of(
        //     "teamid", team.getTeamId(),
        //     "teamname", team.getTeamName(),
        //     "teamtype", team.getTeamType(),
        //     "workid", team.getWorkId(),
        //     "workintro", team.getWorkIntro(),
        //     "consent", team.getConsent(),
        //     "affidavit", team.getAffidavit()
        // )).collect(Collectors.toList());

        // 假資料
        Map<String, Object> response = new HashMap<>();
        response.put("teamid", "1");
        response.put("teamname", "team1");
        response.put("teamtype", "type1");
        response.put("state", "已審核");
        response.put("workid", "work1");
        response.put("workintro", "intro1");
        response.put("consent", "consent1");
        response.put("affidavit", "affidavit1");
        return ResponseEntity.ok(List.of(response));
    }
    
}
