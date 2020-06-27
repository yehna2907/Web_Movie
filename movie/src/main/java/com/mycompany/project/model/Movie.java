package com.mycompany.project.model;

public class Movie {
	private int mvno;
	private int mvfno;
	private int mvplace;
	private String mvstarttime;
	private String mvdate;
	
	public int getMvno() {
		return mvno;
	}
	public void setMvno(int mvno) {
		this.mvno = mvno;
	}
	public int getMvfno() {
		return mvfno;
	}
	public void setMvfno(int mvfno) {
		this.mvfno = mvfno;
	}
	public int getMvplace() {
		return mvplace;
	}
	public void setMvplace(int mvplace) {
		this.mvplace = mvplace;
	}
	public String getMvstarttime() {
		return mvstarttime;
	}
	public void setMvstarttime(String mvstarttime) {
		this.mvstarttime = mvstarttime;
	}
	public String getMvdate() {
		return mvdate;
	}
	public void setMvdate(String mvdate) {
		this.mvdate = mvdate;
	}
}
