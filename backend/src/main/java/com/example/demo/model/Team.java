package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Team {
    @JsonProperty("teamid")
    private String teamid;
    @JsonProperty("teamname")
    private String teamname;
    @JsonProperty("teamrank")
    private String teamrank;
    @JsonProperty("teamtype")
    private String teamtype;
    @JsonProperty("teamconsent")
    private String teamconsent;
    @JsonProperty("teamaffidavit")
    private String teamaffidavit;
    @JsonProperty("teamstate")
    private String teamstate;
    @JsonProperty("teamteacheremail")
    private String teamteacheremail;
    @JsonProperty("amounts")
    private int amounts;
    @JsonProperty("approved")
    private int approved;
    @JsonProperty("notreview")
    private int notreview;
    @JsonProperty("incomplete")
    private int incomplete;
    @JsonProperty("qualifying")
    private int qualifying;
    @JsonProperty("finalround")
    private int finalround;
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
    @JsonProperty("workgithub")
    private String workgithub;
    @JsonProperty("workyear")
    private String workyear;
    @JsonProperty("workintro")
    private String workintro;

    public String getTeamId() {
        return teamid;
    }

    public void setTeamId(String teamid) {
        this.teamid = teamid;
    }

    public String getTeamName() {
        return teamname;
    }

    public void setTeamName(String teamname) {
        this.teamname = teamname;
    }

    public String getTeamRank() {
        return teamrank;
    }

    public void setTeamRank(String teamrank) {
        this.teamrank = teamrank;
    }

    public String getTeamType() {
        return teamtype;
    }

    public void setTeamType(String teamtype) {
        this.teamtype = teamtype;
    }

    public String getConsent() {
        return teamconsent;
    }

    public void setConsent(String teamconsent) {
        this.teamconsent = teamconsent;
    }

    public String getAffidavit() {
        return teamaffidavit;
    }

    public void setAffidavit(String teamaffidavit) {
        this.teamaffidavit = teamaffidavit;
    }

    public String getTeamState() {
        return teamstate;
    }

    public void setTeamState(String teamstate) {
        this.teamstate = teamstate;
    }

    public String getTeacherEmail() {
        return teamteacheremail;
    }

    public void setTeacherEmail(String teamteacheremail) {
        this.teamteacheremail = teamteacheremail;
    }

    public int getAmounts() {
        return amounts;
    }

    public void setAmounts(int amounts) {
        this.amounts = amounts;
    }

    public int getApproved() {
        return approved;
    }

    public void setApproved(int approved) {
        this.approved = approved;
    }

    public int getNotreview() {
        return notreview;
    }

    public void setNotreview(int notreview) {
        this.notreview = notreview;
    }

    public int getIncomplete() {
        return incomplete;
    }

    public void setIncomplete(int incomplete) {
        this.incomplete = incomplete;
    }

    public int getQualifying() {
        return qualifying;
    }

    public void setQualifying(int qualifying) {
        this.qualifying = qualifying;
    }

    public int getFinalround() {
        return finalround;
    }

    public void setFinalround(int finalround) {
        this.finalround = finalround;
    }

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

    public String getWorkGithub() {
        return workgithub;
    }

    public void setWorkGithub(String workgithub) {
        this.workgithub = workgithub;
    }

    public String getWorkYear() {
        return workyear;
    }

    public void setWorkYear(String workyear) {
        this.workyear = workyear;
    }

    public String getWorkIntro() {
        return workintro;
    }

    public void setWorkIntro(String workintro) {
        this.workintro = workintro;
    }

    @Override
    public String toString() {
        return "Team [teamid=" + teamid + ", teamname=" + teamname + ", teamrank=" + teamrank + ", teamtype=" + teamtype
                + ", teamconsent=" + teamconsent + ", teamaffidavit=" + teamaffidavit + ", teamstate=" + teamstate + ", teamteacheremail="
                + teamteacheremail + ", amounts=" + amounts + ", approved=" + approved + ", notreview=" + notreview
                + ", incomplete=" + incomplete + ", qualifying=" + qualifying + ", finalround=" + finalround
                + ", workid=" + workid + ", workname=" + workname + ", worksummary=" + worksummary + ", worksdgs="
                + worksdgs + ", workposter=" + workposter + ", workyturl=" + workyturl + ", workgithub=" + workgithub
                + ", workyear=" + workyear + ", workintro=" + workintro + "]";
    }
}
