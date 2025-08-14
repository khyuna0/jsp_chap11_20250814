<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 처리</title>
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
		String sql = "INSERT INTO members(memberid, memberpw, membername, memberemail) VALUES ('"+ mid +"','"+ mpw +"','"+ mname +"','"+ memail +"')";
		
		Connection conn = null; // 커넥션 인터페이스 선언 후 null 로 초기값 설정
		Statement stmt = null; // sql 문 관리해주는 객체를 선언해주는 인터페이스로 stmt 선언
		
		try {
			Class.forName(drivername); // MYSQL 드라이버 클래스 불러오기
			conn = DriverManager.getConnection(url, username, password);
			// 커넥션이 메모리에 생성됨(DB와의 연결 커넥션 conn 생성)
			stmt = conn.createStatement(); // stmt 객체 생성
			
			int sqlResult = stmt.executeUpdate(sql); // sql문을 DB에서 실행
			// 성공하면 >1이 반환<, 실패하면 >1이 아닌 다른 값<이 반환됨 if-else로 성공 여부 판단 가능
			// 1 = 한 줄. db의 몇 행이 영향 받았나...
			System.out.println("sqlResult 값 : " + sqlResult);	
			
		} catch (Exception e) {
			out.println ("DB에러 발생. 회원가입 실패");
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
		
	%>
</body>
</html>