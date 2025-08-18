package com.khyuna0.member;

public class BoardDto {
	public int bnum;
	public String btitle;
	public String bcontents;
	public String memberid;
	public String bdate;
	public BoardDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BoardDto(int bnum, String btitle, String bcontents, String memberid, String bdate) {
		super();
		this.bnum = bnum;
		this.btitle = btitle;
		this.bcontents = bcontents;
		this.memberid = memberid;
		this.bdate = bdate;
	}
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public String getBtitle() {
		return btitle;
	}
	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}
	public String getBcontents() {
		return bcontents;
	}
	public void setBcontents(String bcontents) {
		this.bcontents = bcontents;
	}
	public String getMemberid() {
		return memberid;
	}
	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}
	public String getBdate() {
		return bdate;
	}
	public void setBdate(String bdate) {
		this.bdate = bdate;
	}
	

	
}
