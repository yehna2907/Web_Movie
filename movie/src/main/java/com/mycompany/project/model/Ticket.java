package com.mycompany.project.model;

public class Ticket {
	
	private int tno;
	private String tid;
	private String tmoviename;
	private String tdate;
	private int tplace;
	private String ttime;
	private int tseatno;
	private int smovie;
	
	public int getSmovie() {
		return smovie;
	}
	public void setSmovie(int smovie) {
		this.smovie = smovie;
	}
	public int getTno() {
		return tno;
	}
	public void setTno(int tno) {
		this.tno = tno;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getTdate() {
		return tdate;
	}
	public void setTdate(String tdate) {
		this.tdate = tdate;
	}
	public String getTmoviename() {
		return tmoviename;
	}
	public void setTmoviename(String tmoviename) {
		this.tmoviename = tmoviename;
	}
	public int getTseatno() {
		return tseatno;
	}
	public void setTseatno(int tseatno) {
		this.tseatno = tseatno;
	}
	public int getTplace() {
		return tplace;
	}
	public void setTplace(int tplace) {
		this.tplace = tplace;
	}
	public String getTtime() {
		return ttime;
	}
	public void setTtime(String ttime) {
		this.ttime = ttime;
	}
}
