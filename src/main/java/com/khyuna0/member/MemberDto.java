package com.khyuna0.member;

public class MemberDto {
	private String memberid; // 회원아이디
	private String memberpw; // 비밀번호
	private String membername; // 이름
	private String memberemail; // 이메일
	private String memberdate; // 가입일
	
	public MemberDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MemberDto(String memberid, String memberpw, String membername, String memberemail, String memberdate) {
		super();
		this.memberid = memberid;
		this.memberpw = memberpw;
		this.membername = membername;
		this.memberemail = memberemail;
		this.memberdate = memberdate;
	}
	public String getMemberid() {
		return memberid;
	}
	public void setMemberid(String memberid) {
		this.memberid = memberid;
	}
	public String getMemberpw() {
		return memberpw;
	}
	public void setMemberpw(String memberpw) {
		this.memberpw = memberpw;
	}
	public String getMembername() {
		return membername;
	}
	public void setMembername(String membername) {
		this.membername = membername;
	}
	public String getMemberemail() {
		return memberemail;
	}
	public void setMemberemail(String memberemail) {
		this.memberemail = memberemail;
	}
	public String getMemberdate() {
		return memberdate;
	}
	public void setMemberdate(String memberdate) {
		this.memberdate = memberdate;
	}
	
}
