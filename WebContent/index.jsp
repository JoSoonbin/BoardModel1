<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.sql.*"%>
<%@page import="com.board.beans.Board"%>
<%@page import="java.util.ArrayList"%>
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
<%
	// 한글
	request.setCharacterEncoding("UTF-8");

	int idx = 1;
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String regdate = request.getParameter("regdate");
	int count = 10000;
	String content = request.getParameter("content");

	// 유효성 검사
	if (title == "" || title == null)
		out.println("title이 null입니다.");

	if (writer == "" || writer == null)
		out.println("writer가 null입니다.");
	else if (!Pattern.matches("^[_0-9a-zA-Z-]+@[0-9a-zA-Z-]+(.[_0-9a-zA-Z-]+)*$", writer))
		out.println("이메일 형식이 아닙니다.");

	if (regdate == "" || regdate == null)
		out.println("regdate가 null입니다.");
	else if (!Pattern.matches("^[0-9]*$", regdate))
		out.println("숫자형식이 아닙니다.");

	if (content == "" || content == null)
		out.println("content가 null입니다.");

	try {
		String driverName = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		ResultSet rs = null;

		Class.forName(driverName);
		Connection con = DriverManager.getConnection(url, "hr", "hr");
		out.println("Oracle Database Connection Success.");

		Statement stmt = con.createStatement();
		String sql = "select * from board order by idx desc";
		rs = stmt.executeQuery(sql);

		ArrayList<Board> articleList = new ArrayList<Board>();

		while (rs.next()) {
			Board article = new Board();
			article.setIdx(rs.getInt("idx"));
			article.setTitle(rs.getString("title"));
			article.setWriter(rs.getString("writer"));
			article.setRegdate(rs.getString("regdate"));
			article.setCount(rs.getInt("count"));
			articleList.add(article);
		}
		request.setAttribute("articleList", articleList); // 셋팅된 리스트를 뷰에 포워드

		con.close();
	} catch (Exception e) {
		out.println("Oracle Database Connection Somthing Problem. <hr>");
		out.println(e.getMessage());
		e.printStackTrace();
	}
%>
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