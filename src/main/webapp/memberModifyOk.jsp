<%@page import="com.khoyuna0.member.MemberDto"%>
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
<title>회원 수정 처리</title>
</head>
<body>
	<%	
		// DB에 삽입할 데이터 준비 완료
		request.setCharacterEncoding("utf-8");
		
		String mid = request.getParameter("mid"); // 아이디
		String mpw = request.getParameter("mpw"); // 비밀번호
		String mname = request.getParameter("mname"); // 이름
		String memail = request.getParameter("memail"); //이메일
		
		// DB 커넥션 준비
		String drivername = "com.mysql.jdbc.Driver"; // mysql jdbc 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; // MYSQL이 설치된 서버의 주소(ip)와 연결할 DB(스키마)이름
		String username = "root";
		String password = "12345";
		
		// sql문 만들기
		String sql = " UPDATE members SET memberpw = '"+ mpw +"', membername = '"+ mname +"', memberemail = '"+ memail +"' WHERE memberid = '"+ mid +"'";
		
		Connection conn = null; // 커넥션 인터페이스 선언 후 null 로 초기값 설정
		Statement stmt = null; // sql 문 관리해주는 객체를 선언해주는 인터페이스로 stmt 선언
		
		try {
			Class.forName(drivername); // MYSQL 드라이버 클래스 불러오기
			conn = DriverManager.getConnection(url, username, password);
			// 커넥션이 메모리에 생성됨(DB와의 연결 커넥션 conn 생성)
			stmt = conn.createStatement(); // stmt 객체 생성
			
			int sqlResult = stmt.executeUpdate(sql); // sql문을 DB에서 실행
			//System.out.println("sqlResult 값 : " + sqlResult);	
			
		} catch (Exception e) {
			out.println ("DB에러 발생. 회원 정보 수정 실패");
			e.printStackTrace();
		} finally { // 에러의 발생여부와 상관 없이 Connection 닫기 실행
			try {
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
		
		String sql2 = "SELECT * FROM members WHERE memberid = '"+mid+"'";
		// String sql = "SELECT * FROM members";
				
		Connection conn2 = null; // 커넥션 인터페이스 선언 후 null 로 초기값 설정
		Statement stmt2 = null; // sql 문 관리해주는 객체를 선언해주는 인터페이스로 stmt 선언
		ResultSet rs2 = null; // select문 실행 시 db에서 반환해주는 레코드 결과를 받아주는 자료 타입 rs 선언
		MemberDto memberDto2 = new MemberDto(); // dto 객체 선언
		
		try {
			Class.forName(drivername); // MYSQL 드라이버 클래스 불러오기
			conn2 = DriverManager.getConnection(url, username, password);
			// 커넥션이 메모리에 생성됨(DB와의 연결 커넥션 conn 생성)
			stmt2 = conn2.createStatement(); // stmt 객체 생성
			
			//int sqlResult = stmt.executeUpdate(sql); // sql문을 DB에서 실행
			rs2 = stmt2.executeQuery(sql2); 

			if (rs2.next()) { 
				
				do { 				
					String sid = rs2.getString("memberid");
					String spw = rs2.getString("memberpw");
					String sname = rs2.getString("membername");
					String semail = rs2.getString("memberemail");
					String sdate = rs2.getString("memberdate");
					
					memberDto2.setMemberid(mid);
					memberDto2.setMemberpw(spw);
					memberDto2.setMembername(sname);
					memberDto2.setMemberemail(semail);
					memberDto2.setMemberdate(sdate);
					
					
					
				} while (rs2.next());
			} else { // 거짓 -> 레코드가 없음 (0개)
				response.sendRedirect("memberModify.jsp");
			}
			
		} catch (Exception e) {
			out.println ("회원 조회 실패" + "<br><br>");
			e.printStackTrace();
		} finally { // 에러의 발생여부와 상관 없이 Connection 닫기 실행
			try {	
					if (rs2 != null) { // 제일 먼저 닫
						rs2.close();
					}
					
					if(stmt2 != null ) { // stmt가 null 이 아니면 닫기. conn보다 먼저 닫아야 함!
						stmt2.close();	
					}
					
					if(conn2 != null ) { // Connection이 null이 아닐 때만 닫기
						conn2.close();
					}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
			request.setAttribute("memberDto", memberDto2); 
			// 조회된 회원 정보가 들어있는 memberDto requset 객체에 set
			
		
	%>
	<h2>수정된 회원정보</h2>
	<hr>
	아이디 : ${memberDto.memberid}<br><br>
	비밀번호 : ${memberDto.memberpw}<br><br>
	이름 : ${memberDto.membername}<br><br>
	이메일 : ${memberDto.memberemail}<br><br>
	
</body>
</html>