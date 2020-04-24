<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>본격! 게시판 - 게시글 리스트</title>
<style>
table, td, th {
	border: 1px solid green;
}

th {
	background-color: green;
	color: white;
}
</style>
</head>
<body>
	<h1>게시글 리스트</h1>
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>날짜</th>
			<th>조회수</th>
		</tr>

		<c:forEach items="${articleList}" var="article">
			<tr>
				<td>${article.idx }</td>
				<td><a href='content.jsp?idx=${article.idx }'>${article.title }</a></td>
				<td>${article.writer }</td>
				<td>${article.regdate }</td>
				<td>${article.count }</td>
			</tr>
		</c:forEach>
	</table>
	<a href="write.jsp">글쓰기</a>
</body>
</html>