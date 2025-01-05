package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Workshop {
    private int wsid;
    private String wsdate;
    private String wstime;
    private String wstopic;
    // @JsonProperty("lectname")
    private String lectname;
    private String lecttitle;
    private String lectphone;
    private String lectemail;
    private String lectaddr;

    public void setWsid(int wsid) {
        this.wsid = wsid;
    }

    public void setWsdate(String wsdate) {
        this.wsdate = wsdate;
    }

    public void setWstime(String wstime) {
        this.wstime = wstime;
    }

    public void setWstopic(String wstopic) {
        this.wstopic = wstopic;
    }

    public void setLectName(String lectname) {
        this.lectname = lectname;
    }

    public void setLecttitle(String lecttitle) {
        this.lecttitle = lecttitle;
    }

    public void setLectphone(String lectphone) {
        this.lectphone = lectphone;
    }

    public void setLectemail(String lectemail) {
        this.lectemail = lectemail;
    }

    public void setLectaddr(String lectaddr) {
        this.lectaddr = lectaddr;
    }

    public int getWsid() {
        return wsid;
    }

    public String getWsdate() {
        return wsdate;
    }

    public String getWstime() {
        return wstime;
    }

    public String getWstopic() {
        return wstopic;
    }

    public String getLectname() {
        return lectname;
    }

    public String getLecttitle() {
        return lecttitle;
    }

    public String getLectphone() {
        return lectphone;
    }

    public String getLectemail() {
        return lectemail;
    }

    public String getLectaddr() {
        return lectaddr;
    }

    @Override
    public String toString() {
        return "Workshop{" +
                "wsid=" + wsid +
                ", wsdate='" + wsdate + '\'' +
                ", wstime='" + wstime + '\'' +
                ", wstopic='" + wstopic + '\'' +
                ", lectname='" + lectname + '\'' +
                ", lecttitle='" + lecttitle + '\'' +
                ", lectphone='" + lectphone + '\'' +
                ", lectemail='" + lectemail + '\'' +
                ", lectaddr='" + lectaddr + '\'' +
                '}';
    }
}
