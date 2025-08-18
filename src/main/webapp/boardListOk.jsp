<%@page import="com.khyuna0.member.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>    
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<style type="text/css">
	table {
		width: 600px;
		border-collapse: collapse;
	}
	th, td {
		border: 1px solid; #dddddd;
		padding: 10px;
		text-align: center;
	}
	th {
		background-color: #f5f5f5;

	}

</style>
<title>자유 게시판</title>
</head>
<body>
	<!-- 게시판 글 리스트 -->
	
	<h2>자유 게시판 목록</h2>
	<hr>
	<table>
		<thead>
		<tr>
			<th>No.</th>
			<th>제목</th>
			<th>글쓴이</th>
			<th>날짜</th>
		</tr>
		</thead>
		
		<c:forEach var="boardDto" items="${boardList}">
			<tr>
				<td>${boardDto.bnum}</td>
				<td>
				<!-- 게시판 글 제목이 40자 이상일때 40자 이상은 ...표시  -->
					<c:choose>
						<c:when test="${fn:length(boardDto.btitle) > 40}">
							<a href="#">${fn:substring(boardDto.btitle, 0, 40)}...</a>
						</c:when>
						<c:otherwise>
							${boardDto.btitle }
						</c:otherwise>
					</c:choose>
				</td>
				<td>${boardDto.memberid }</td>
				<td>${boardDto.bdate }</td>
			</tr>
		</c:forEach>
	</table>
	<br>
	
</body>
</html>