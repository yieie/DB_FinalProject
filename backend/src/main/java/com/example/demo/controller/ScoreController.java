package com.example.demo.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.Score;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;



@RestController
@RequestMapping("/api/Score")
public class ScoreController {
    // private ScoreDAO scoreDAO = new ScoreDAO();

    @PostMapping("/Constraints")
    public ResponseEntity<List<Score>> getScoresWithConstraints(@RequestBody Score score) {
        //Score score = scoreDAO.getScoresWithConstraints(score);

        List<Score> scores = new ArrayList<>();
        Score score1 = new Score();
        score1.setTeamId("1");
        score1.setTeamName("team1");
        score1.setTeamType("type1");
        score1.setJudgeName("judge1");
        score1.setRate1("1");
        score1.setRate2("2");
        score1.setRate3("3");
        score1.setRate4("4");
        score1.setTotalRate("10");
        score1.setTeamRank("1");
        scores.add(score1);
        return ResponseEntity.ok(scores);
    }
    
    //新增評分，data內含分數1~4以及評分的judgeid
    /*data格式
    *{
    * 'judgeid':judgeid,
    * 'score1':scores[0],
    * 'score2':scores[1],
    * 'score3':scores[2],
    * 'score4':scores[3]
    *}
    */
    @PostMapping("/add/{teamid}")
    public ResponseEntity<Void> addScore(@RequestBody Map<String, Object> data, @PathVariable String teamid) {
        // scoreDAO.addScore(data, teamid);
        System.out.println(data);
        return ResponseEntity.ok().build();
    }

    @GetMapping("path")
    public String getMethodName(@RequestParam String param) {
        return new String();
    }
    
}
