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


@RestController
@RequestMapping("/api/Score")
public class ScoreController {
    // private ScoreDAO scoreDAO = new ScoreDAO();

    //拿所有評分資料，會限制年份、組別(全組別、創意發想組、創業實作組)
    //如果rank不為空，回傳資料以rank排序
    //評分資料與資料庫內結構不同，要去Score.dart看實際需要回傳什麼
    @PostMapping("/Constraints")
    public ResponseEntity<List<Score>> getScoresWithConstraints(@RequestBody Map<String, Object> constraint) {
        // Score scores = scoreDAO.getScoresWithConstraints(constraint);

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
    
}
