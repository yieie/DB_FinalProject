package com.example.demo.model;
import java.time.Year;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Work {
    @JsonProperty("workid")
    private String workid;
    @JsonProperty("workname")
    private String workname;
    @JsonProperty("worksummary")
    private String worksummary;
    @JsonProperty("worksdgs")
    private String worksdgs;
    @JsonProperty("workposter")
    private String workposter;
    @JsonProperty("workyturl")
    private String workyturl;
    @JsonProperty("workppturl")
    private String workppturl;
    @JsonProperty("workgithub")
    private String workgithub;
    @JsonProperty("workyear")
    private Year workyear;
    @JsonProperty("workintro")
    private String workintro;
    @JsonProperty("teamid")
    private String teamid;

    public String getWorkId() {
        return workid;
    }

    public void setWorkId(String workid) {
        this.workid = workid;
    }

    public String getWorkName() {
        return workname;
    }

    public void setWorkName(String workname) {
        this.workname = workname;
    }

    public String getWorkSummary() {
        return worksummary;
    }

    public void setWorkSummary(String worksummary) {
        this.worksummary = worksummary;
    }

    public String getWorkSdgs() {
        return worksdgs;
    }

    public void setWorkSdgs(String worksdgs) {
        this.worksdgs = worksdgs;
    }

    public String getWorkPoster() {
        return workposter;
    }

    public void setWorkPoster(String workposter) {
        this.workposter = workposter;
    }

    public String getWorkYtUrl() {
        return workyturl;
    }

    public void setWorkYtUrl(String workyturl) {
        this.workyturl = workyturl;
    }

    public String getWorkPptUrl() {
        return workppturl;
    }

    public void setWorkPptUrl(String workppturl) {
        this.workppturl = workppturl;
    }

    public String getWorkGithub() {
        return workgithub;
    }

    public void setWorkGithub(String workgithub) {
        this.workgithub = workgithub;
    }

    public Year getWorkYear() {
        return workyear;
    }

    public void setWorkYear(Year workyear) {
        this.workyear = workyear;
    }

    public String getWorkIntro() {
        return workintro;
    }

    public void setWorkIntro(String workintro) {
        this.workintro = workintro;
    }

    public String getTeamId() {
        return teamid;
    }

    public void setTeamId(String teamid) {
        this.teamid = teamid;
    }

    @Override
    public String toString() {
        return "Work{" +
                "workid='" + workid + '\'' +
                ", workname='" + workname + '\'' +
                ", worksummary='" + worksummary + '\'' +
                ", worksdgs='" + worksdgs + '\'' +
                ", workposter='" + workposter + '\'' +
                ", workyturl='" + workyturl + '\'' +
                ", workppturl='" + workppturl + '\'' +
                ", workgithub='" + workgithub + '\'' +
                ", workyear=" + workyear +
                ", workintro='" + workintro + '\'' +
                ", teamid='" + teamid + '\'' +
                '}';
    }
}
