<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>본격! 게시판 - 게시글 삭제</title>
</head>

<%
	String idx = request.getParameter("idx");
	try{
		String driverName = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(url, "hr", "hr");
		out.println("Oracle Database Connection Success.");
		
		Statement stmt = con.createStatement();
		String sql = "delete from board where idx="+idx;
		stmt.executeUpdate(sql);
		con.close();
	} catch(Exception e) {
		out.println("Oracle Datebase Connection Something Problem. <hr>");
		out.println(e.getMessage());
		e.printStackTrace();
	}
%>

<script>
	alert("게시글이 삭제되었습니다.");
	location.href = "redirect.jsp";
</script>

<body>

</body>
</html>