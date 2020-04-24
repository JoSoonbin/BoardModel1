<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.regex.Pattern" %>
<%@page import="java.sql.*" %>  <!-- DB를 조작하기 위한 라리브러리 import -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	if(title == "" || title == null)
		out.println("title이 null입니다.");
	
	if(writer == "" || writer == null)
		out.println("writer가 null입니다.");
	else if(!Pattern.matches("^[_0-9a-zA-Z-]+@[0-9a-zA-Z-]+(.[_0-9a-zA-Z-]+)*$", writer))
		out.println("이메일 형식이 아닙니다.");
	
	if(regdate == "" || regdate == null)
		out.println("regdate가 null입니다.");
	else if(!Pattern.matches("^[0-9]*$", regdate))
		out.println("숫자형식이 아닙니다.");
	
	if(content == "" || content == null)
		out.println("content가 null입니다.");
	
	try{
		String driverName = "oracle.jdbc.driver.OracleDriver";  // DB에 접속하기 위한 드라이버 로드
		String url = "jdbc:oracle:thin:@localhost:1521:XE";  	// 접속 URL정보와 포트번호(oracle포트), sid(oracle버전)
		
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(url, "hr", "hr");  // 계정정보 url, id, pw
		out.println("Oracle 데이터베이스 db에 성공적으로 접속했습니다.");
		
		// 쿼리 작성
		Statement stmt = con.createStatement();  // SQL 쿼리를 날리기 위한 Statement 객체 생성
		String sql = "INSERT INTO board" + 
						"(idx, title, writer, regdate, count, content)" + 
						"VALUES ( board_seq.nextval, '" + title + "', '" + writer + "', sysdate, " + count + " , '" + content + "')";
		stmt.executeUpdate(sql);  // 쿼리 실행
		
		
		con.close();
	} catch(Exception e) {
		out.println("Oracle 데이터베이스 db 접속에 문제가 있습니다. <hr>");
		out.println(e.getMessage());
		e.printStackTrace();
	} finally {
		out.print("<script>location.href='list.jsp';</script>");  // location.href : 현재 경로를 변경
	}
%>
<body>

</body>
</html>