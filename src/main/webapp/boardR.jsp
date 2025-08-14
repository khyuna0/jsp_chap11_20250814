<%@page import="java.util.ArrayList"%>
<%@page import="com.khoyuna0.member.BoardDto"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
</head>
<body>
	<%	
		// DB에 삽입할 데이터 준비 완료
		request.setCharacterEncoding("utf-8");
		
		String btitle = request.getParameter("btitle"); // 아이디
		String bcontents = request.getParameter("bcontents"); // 비밀번호
		String memberid = request.getParameter("memberid"); // 이름
		
		// DB 커넥션 준비
		String drivername = "com.mysql.jdbc.Driver"; // mysql jdbc 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; // MYSQL이 설치된 서버의 주소(ip)와 연결할 DB(스키마)이름
		String username = "root";
		String password = "12345";
		
		// sql문 만들기
		
		
		String sql = "SELECT * FROM board";
		
				
		Connection conn = null; // 커넥션 인터페이스 선언 후 null 로 초기값 설정
		Statement stmt = null; // sql 문 관리해주는 객체를 선언해주는 인터페이스로 stmt 선언
		ResultSet rs = null; // select문 실행 시 db에서 반환해주는 레코드 결과를 받아주는 자료 타입 rs 선언
		
		// 1명의 회원정보 DTO 객체들이 저장될 리스트 선언
		List<BoardDto> memberList = new ArrayList<BoardDto>();
		
		try {
			Class.forName(drivername);
			conn = DriverManager.getConnection(url, username, password);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql); 
			
			
		if  (rs.next()) {
			do {
				BoardDto bdto = new BoardDto();
				bdto.setBnum(rs.getInt("bnum"));
				bdto.setBtitle(rs.getString("btitle"));
				bdto.setBcontents(rs.getString("bcontents"));
				bdto.setMemberid(rs.getString("memberid"));
				bdto.setBdate(rs.getString("bdate"));
				memberList.add(bdto);
			}
				while (rs.next()); 
			
				for(BoardDto b : memberList ) {
					out.println(b.getBnum() + "/");
					out.println(b.getBtitle() + "/");
					out.println(b.getBcontents() + "/");
					out.println(b.getMemberid() + "/");
					out.println(b.getBdate() + "<br>");
				}
		} else {
			out.println("글없음");
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