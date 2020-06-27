package com.mycompany.project.model;

import java.sql.Date;

public class Review {
	private int rno;
	private int rfno;
	private String rid;
	private String rcontent;
	private double rscore;
	private Date rdate;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRcontent() {
		return rcontent;
	}
	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}
	public double getRscore() {
		return rscore;
	}
	public void setRscore(double rscore) {
		this.rscore = rscore;
	}
	public Date getRdate() {
		return rdate;
	}
	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getRfno() {
		return rfno;
	}
	public void setRfno(int rfno) {
		this.rfno = rfno;
	}
	
	@Override
	public boolean equals(Object obj) {
		return rid.equals(((Review) obj).getRid());
	}
}
