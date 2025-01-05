package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonProperty;

// 'judgeid':email,
//       'judgepasswd': passwd,
//       'judgename':name,
//       'judgesexual':sexual,
//       'judgephone':phone,
//       'judgetitle':title
public class Judge {
    @JsonProperty("judgeid")
    private String judgeid;
    @JsonProperty("judgepasswd")
    private String judgepasswd;
    @JsonProperty("judgename")
    private String judgename;
    @JsonProperty("judgesexual")
    private String judgesexual;
    @JsonProperty("judgephone")
    private String judgephone;
    @JsonProperty("judgetitle")
    private String judgetitle;
    @JsonProperty("judgeemail")
    private String judgeemail;

    public void setJudgeid(String judgeid) {
        this.judgeid = judgeid;
    }

    public void setJudgepasswd(String judgepasswd) {
        this.judgepasswd = judgepasswd;
    }

    public void setJudgename(String judgename) {
        this.judgename = judgename;
    }

    public void setJudgesexual(String judgesexual) {
        this.judgesexual = judgesexual;
    }

    public void setJudgephone(String judgephone) {
        this.judgephone = judgephone;
    }

    public void setJudgetitle(String judgetitle) {
        this.judgetitle = judgetitle;
    }

    public String getJudgeid() {
        return judgeid;
    }

    public String getJudgepasswd() {
        return judgepasswd;
    }

    public String getJudgename() {
        return judgename;
    }

    public String getJudgesexual() {
        return judgesexual;
    }

    public String getJudgephone() {
        return judgephone;
    }

    public String getJudgetitle() {
        return judgetitle;
    }

    public String getJudgeemail() {
        return judgeemail;
    }

    public void setJudgeemail(String judgeemail) {
        this.judgeemail = judgeemail;
    }

    @Override
    public String toString() {
        return "Judge{" +
                "judgeid='" + judgeid + '\'' +
                ", judgepasswd='" + judgepasswd + '\'' +
                ", judgename='" + judgename + '\'' +
                ", judgesexual='" + judgesexual + '\'' +
                ", judgephone='" + judgephone + '\'' +
                ", judgetitle='" + judgetitle + '\'' +
                ", judgeemail='" + judgeemail + '\'' +
                '}';
    }
}
