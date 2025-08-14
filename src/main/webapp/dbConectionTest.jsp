<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC 연결 테스트</title>
</head>
<body>
	<%
		String drivername = "com.mysql.jdbc.Driver"; // mysql jdbc 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; // MYSQL이 설치된 서버의 주소(ip)와 연결할 DB(스키마)이름
		String username = "root";
		String password = "12345";
		Connection conn = null; // 커넥션 인터페이스 선언 후 null 로 초기값 설정
	%>
	
	<% 
		try {
			
			Class.forName(drivername); // MYSQL 드라이버 클래스 불러오기
			conn = DriverManager.getConnection(url, username, password);
			// 커넥션이 메모리에 생성됨(DB와의 연결 커넥션 conn 생성)
			
			out.println(conn); 
			// 커넥션이 에러 없이 생성된 경우 커넥션의 이름 출력
		} catch (Exception e) {
			out.println ("bd 커넥션 생성 실패");
			e.printStackTrace();
		} finally { // 에러의 발생여부와 상관 없이 Connection 닫기 실행
			try{
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