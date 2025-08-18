<%@page import="com.khyuna0.member.MemberDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 조회</title>
</head>
<body>
	<%	
		// DB에 삽입할 데이터 준비 완료
		request.setCharacterEncoding("utf-8");
		
		
		// DB 커넥션 준비
		String drivername = "com.mysql.jdbc.Driver"; // mysql jdbc 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; // MYSQL이 설치된 서버의 주소(ip)와 연결할 DB(스키마)이름
		String username = "root";
		String password = "12345";
		
		// sql문 만들기
		//String sql = "SELECT * FROM members WHERE memberid = '"+mid+"'";
		String sql = "SELECT * FROM members";
				
		Connection conn = null; // 커넥션 인터페이스 선언 후 null 로 초기값 설정
		Statement stmt = null; // sql 문 관리해주는 객체를 선언해주는 인터페이스로 stmt 선언
		ResultSet rs = null; // select문 실행 시 db에서 반환해주는 레코드 결과를 받아주는 자료 타입 rs 선언
		
		// 1명의 회원정보 DTO 객체들이 저장될 리스트 선언
		List<MemberDto> memberList = new ArrayList<MemberDto>();
		
		
		
		try {
			Class.forName(drivername); // MYSQL 드라이버 클래스 불러오기
			conn = DriverManager.getConnection(url, username, password);
			// 커넥션이 메모리에 생성됨(DB와의 연결 커넥션 conn 생성)
			stmt = conn.createStatement(); // stmt 객체 생성
			
			//int sqlResult = stmt.executeUpdate(sql); // sql문을 DB에서 실행
			rs = stmt.executeQuery(sql); 
			// select 문 실행하면 결과가 DB로부터 반환 -> 결과 (레코드 (행))를 받아주는 resultset 타입 객체로 받아야 함	 
			// String sid = null;
			
			while (rs.next()) {
				MemberDto memberDto = new MemberDto();
				
				memberDto.setMemberid(rs.getString("memberid"));
				memberDto.setMemberpw(rs.getString("memberpw"));
				memberDto.setMembername(rs.getString("membername"));
				memberDto.setMemberemail(rs.getString("memberemail"));
				memberDto.setMemberdate(rs.getString("memberdate"));
				
				memberList.add(memberDto);
			}
				
			for(MemberDto mdto : memberList ) {
				out.println(mdto.getMemberid() + "/"); // 아이디
				out.println(mdto.getMemberpw() + "/"); //비번
				out.println(mdto.getMembername() + "/");  // 이름
				out.println(mdto.getMemberemail() + "/"); // 이메일
				out.println(mdto.getMemberdate() + "/"); // 가입일
				
			}
			
			
		} catch (Exception e) {
			out.println ("DB에러 발생");
			e.printStackTrace();
		} finally { // 에러의 발생여부와 상관 없이 Connection 닫기 실행
			try {	
					if (rs != null) { // 제일 먼저 닫
						rs.close();
					}
					
					if(stmt != null ) { // stmt가 null 이 아니면 닫기. conn보다 먼저 닫아야 함!
						stmt.close();	
					}
					
					if(conn != null ) { // Connection이 null이 아닐 때만 닫기
						conn.close();
					}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	%>
</body>
</html>