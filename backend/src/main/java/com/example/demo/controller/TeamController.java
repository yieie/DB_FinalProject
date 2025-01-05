package com.example.demo.controller;

import com.example.demo.model.Team;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.example.demo.dao.TeamDAO;


@RestController
@RequestMapping("/api/Teams")
public class TeamController {
    private final TeamDAO teamDAO = new TeamDAO();
    
    @GetMapping("/Status")
    public ResponseEntity<Team> getTeamStatus() {
        // 資料庫查隊伍狀態，寫完DAO再取消註解
        Team team = teamDAO.getTeamStatus();
        return ResponseEntity.ok(team);
    }

    @GetMapping("Cond")
    public ResponseEntity<List<Team>> getBasicAllTeam() {
        // 前端要所有隊伍的基本資料 要照階段排序
        List<Team> teams = teamDAO.getBasicAllTeam();

        return ResponseEntity.ok(teams);
    }

    //拿所有隊伍的基本資料，但有限制，限制年份、組別(全組別，創意發想組，創業實作組)、隊伍狀態。
    //若無限制隊伍狀態，請同getBasicAllteam()排序
    //若無限制組別，請將同組別資料都一群先輸出，如創意發想組先，接創業實作組，或相反也可。
    @PostMapping("/Cond/Constraint")
    public ResponseEntity<List<Team>> getBasicAllTeamWithConstraint(@RequestBody Map<String, Object> constraint) {
        // 前端要所有隊伍的基本資料，但有限制，資料庫注意一下constraint
        // map key
        // 'teamyear'
        // 'teamtype'
        // 'teamstate'
        List<Team> teams = teamDAO.getBasicTeamsWithConstraint(constraint);
        
        return ResponseEntity.ok(teams);
    }
    
    @GetMapping("/{teamid}")
    public ResponseEntity<Team> getDetailTeam(@PathVariable String teamid) {
        Team team = teamDAO.getTeamDetail(teamid);

        //假資料
        // Team team = new Team();
        // team.setTeamId("1");
        // team.setTeamName("team1");
        // team.setTeamType("type1");
        // team.setTeamRank("rank1");
        // team.setAffidavit("affidavit1");
        // team.setConsent("consent1");
        // team.setTeacherEmail("teacher1@gmail");
        // team.setTeamState("已審核");
        // team.setWorkId("work1");
        // team.setWorkName("workname1");
        // team.setWorkSummary("summary1");
        // team.setWorkSdgs("sdgs1");
        // team.setWorkPoster("poster1");
        // team.setWorkYtUrl("yturl1");
        // team.setWorkGithub("github1");
        // team.setWorkYear("year1");
        // team.setWorkIntro("intro1");

        return ResponseEntity.ok(team);
    }

    //修改隊伍狀態
    @PostMapping("/{teamid}/edit")
    public ResponseEntity<Void> editTeamState(@PathVariable String teamid, @RequestBody Map<String, String> request) {
        String state = request.get("state");
        teamDAO.updateTeamState(teamid, state);

        // Map key
        // 'state'
        return ResponseEntity.ok().build();
    }

    //拿創意發想組的所有隊伍
    //只需要隊伍ID、隊伍名稱、作品名稱、隊伍類型
    @GetMapping("/idea")
    public ResponseEntity<List<Team>> getIdeaTeams() {
        List<Team> teams = teamDAO.getIdeaTeams();

        // 假資料
        // Team team = new Team();
        // team.setTeamId("1");
        // team.setTeamName("team1");
        // team.setTeamType("type1");
        // team.setTeamRank("rank1");
        // team.setAffidavit("affidavit1");
        // team.setConsent("consent1");
        // team.setTeacherEmail("teacher1@gmail");
        // team.setTeamState("已審核");
        // team.setWorkId("work1");
        // team.setWorkName("work1");
        // team.setWorkSummary("summary1");
        // team.setWorkSdgs("sdgs1");
        // team.setWorkPoster("poster1");
        // team.setWorkYtUrl("yturl1");
        // team.setWorkGithub("github1");
        // team.setWorkYear("year1");
        // team.setWorkIntro("intro1");
        
        // return ResponseEntity.ok(teams);
        return ResponseEntity.ok(teams);
    }

    @GetMapping("/business")
    public ResponseEntity<List<Team>> getBusinessTeams() {
        List<Team> teams = teamDAO.getBusinessTeams();

        // 假資料
        // Team team = new Team();
        // team.setTeamId("2");
        // team.setTeamName("team2");
        // team.setTeamType("type2");
        // team.setTeamRank("rank2");
        // team.setAffidavit("affidavit2");
        // team.setConsent("consent2");
        // team.setTeacherEmail("teacher2@gmail");
        // team.setTeamState("未審核");
        // team.setWorkId("work2");
        // team.setWorkName("work2");
        // team.setWorkSummary("summary2");
        // team.setWorkSdgs("sdgs2");
        // team.setWorkPoster("poster2");
        // team.setWorkYtUrl("yturl2");
        // team.setWorkGithub("github2");
        // team.setWorkYear("year2");
        // team.setWorkIntro("intro2");
        
        // return ResponseEntity.ok(teams);
        return ResponseEntity.ok(teams);
    }
    
    //拿學生切結書(affidavit)、同意書(consent)的後端url
    @GetMapping("/{teamid}/files")
    public ResponseEntity<Map<String, String>> getTeamFiles(@PathVariable String teamid) {
        // Map<String, String> files = teamDAO.getTeamFiles(teamid);

        // 假資料
        Map<String, String> files = new HashMap<>();
        files.put("affidavit", "affidavit1");
        files.put("consent", "consent1");

        return ResponseEntity.ok(files);
    }

    // 給teamname teamtype
    @PostMapping("/add")
    public ResponseEntity<Void> addTeam(@RequestBody Team team) {
        // teamDAO.addTeam(team);
        // 有這些會改
        System.out.println(team.getTeamName());
        System.out.println(team.getTeamType());
        return ResponseEntity.ok().build();
    }

    //拿老師的指導隊伍
    //只需要拿隊伍ID、名稱、狀態、組別
    @GetMapping("/trTeam/{trid}/{year}")
    public ResponseEntity<List<Team>> getTeacherTeams(@PathVariable String trid, @PathVariable String year) {
        List<Team> teams = teamDAO.getTeacherTeams(trid, year);

        // 假資料
        // List<Team> teams = new ArrayList<>();
        // Team team = new Team();
        // team.setTeamId("1");
        // team.setTeamName("team1");
        // team.setTeamType("type1");
        // team.setTeamState("已審核");
        // teams.add(team);
        return ResponseEntity.ok(teams);
    }

    //拿隊伍資訊，只需要隊伍ID、名稱、狀態、組別、作品名稱
    //只需要拿隊伍狀態為初賽隊伍 or 決賽
    @GetMapping("/incontest")
    public ResponseEntity<List<Team>> getInContestTeams() {
        // List<Team> teams = teamDAO.getInContestTeams();

        // 假資料
        Team team = new Team();
        team.setTeamId("3");
        team.setTeamName("team3");
        team.setTeamType("type3");
        team.setTeamState("未審核");
        team.setWorkName("work3");
        
        // return ResponseEntity.ok(teams);
        return ResponseEntity.ok(List.of(team));
    }
}
