package com.example.demo.model;

public class Team {
    private String teamid;
    private String teamname;
    private String teamrank;
    private String teamtype;
    private String consent;
    private String affidavit;
    private String teamstate;
    private String teacheremail;
    private int amounts;
    private int approved;
    private int notreview;
    private int incomplete;
    private int qualifying;
    private int finalround;
    private String workid;
    private String workname;
    private String worksummary;
    private String worksdgs;
    private String workposter;
    private String workyturl;
    private String workgithub;
    private String workyear;
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

    public void setTeamType(String teamType) {
        this.teamtype = teamtype;
    }

    public String getConsent() {
        return consent;
    }

    public void setConsent(String consent) {
        this.consent = consent;
    }

    public String getAffidavit() {
        return affidavit;
    }

    public void setAffidavit(String affidavit) {
        this.affidavit = affidavit;
    }

    public String getTeamState() {
        return teamstate;
    }

    public void setTeamState(String teamstate) {
        this.teamstate = teamstate;
    }

    public String getTeacherEmail() {
        return teacheremail;
    }

    public void setTeacherEmail(String teacheremail) {
        this.teacheremail = teacheremail;
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
                + ", consent=" + consent + ", affidavit=" + affidavit + ", teamstate=" + teamstate + ", teacheremail="
                + teacheremail + ", amounts=" + amounts + ", approved=" + approved + ", notreview=" + notreview
                + ", incomplete=" + incomplete + ", qualifying=" + qualifying + ", finalround=" + finalround
                + ", workid=" + workid + ", workname=" + workname + ", worksummary=" + worksummary + ", worksdgs="
                + worksdgs + ", workposter=" + workposter + ", workyturl=" + workyturl + ", workgithub=" + workgithub
                + ", workyear=" + workyear + ", workintro=" + workintro + "]";
    }
}
