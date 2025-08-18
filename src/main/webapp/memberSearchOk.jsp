<%@page import="java.sql.PreparedStatement"%>
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
		
		String mid = request.getParameter("sid"); // 조회할 아이디
		
		// DB 커넥션 준비
		String drivername = "com.mysql.jdbc.Driver"; // mysql jdbc 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; // MYSQL이 설치된 서버의 주소(ip)와 연결할 DB(스키마)이름
		String username = "root";
		String password = "12345";
		
		// sql문 만들기
		String sql = "SELECT * FROM members WHERE memberid = ?";
		// String sql = "SELECT * FROM members";
				
		Connection conn = null; // 커넥션 인터페이스 선언 후 null 로 초기값 설정
		PreparedStatement pstmt = null; // sql 문 관리해주는 객체를 선언해주는 인터페이스로 stmt 선언
		ResultSet rs = null; // select문 실행 시 db에서 반환해주는 레코드 결과를 받아주는 자료 타입 rs 선언
		
		
		try {
			Class.forName(drivername); // MYSQL 드라이버 클래스 불러오기
			conn = DriverManager.getConnection(url, username, password);
			// 커넥션이 메모리에 생성됨(DB와의 연결 커넥션 conn 생성)
			//stmt = conn.createStatement(); // stmt 객체 생성
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(); 
			
			pstmt.setString(1, mid);
			
			if (rs.next()) { // 참이면 레코드가 한개 이상 존재 -> 아이디가 존재
				
				do { 				
					String sid = rs.getString("memberid"); // 뽑으려는 레코드 필드 타입과 같은 타입으로 지정
					String spw = rs.getString("memberpw");
					String sname = rs.getString("membername");
					String semail = rs.getString("memberemail");
					String sdate = rs.getString("memberdate");
					
					out.println("*** 조회된 회원 정보 *** <br> ");
					out.println(sid + "/" + spw + "/" + sname + "/" + semail + "/" + sdate + "<br>");
				} while (rs.next());
			} else { // 거짓 -> 레코드가 없음 (0개)
				out.println("존재하지 않는 회원입니다.");
			}
					
				
			
		} catch (Exception e) {
			out.println ("DB에러 발생");
			e.printStackTrace();
		} finally { // 에러의 발생여부와 상관 없이 Connection 닫기 실행
			try {	
					if (rs != null) { // 제일 먼저 닫
						rs.close();
					}
					
					if(pstmt != null ) { // stmt가 null 이 아니면 닫기. conn보다 먼저 닫아야 함!
						pstmt.close();	
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