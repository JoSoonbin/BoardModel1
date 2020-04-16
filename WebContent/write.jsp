<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성폼</title>
</head>
<body>
	<form action="index.jsp" method="post" onsubmit="return formCheck();">
		제목 : <input type="text" name="title" /><br /> 
		작성자 : <input type="text" name="writer" /><br /> 
		날짜 : <input type="text" name="regdate" /><br /> 
		content : <textarea rows="10" cols="20" name="content"></textarea><br /> 
		<input type="submit" />
	</form>

	<!-- Javascript 입력값 유효성 검사 -->
	<script>
		function formCheck() {
			var title = document.forms[0].title.value;
			var writer = document.forms[0].writer.value;
			var regdate = document.forms[0].regdate.value;
			var content = document.forms[0].content.value;
			
			if (title == null || title == "") {
				alert('제목을 입력하세요');
				document.forms[0].title.focus();
				return false;
			}

			// 작성자 : 정규식 - 이메일 형식
			if (writer == null || writer == "") {
				alert('작성자를 입력하세요');
				document.forms[0].writer.focus();
				return false;
			} else if(!isEmail(writer)) {
				alert('이메일 형식으로 입력하세요');
				document.forms[0].writer.focus();
				return false;
			}

			if (content == null || content == "") {
				alert('내용을 입력하세요');
				document.forms[0].content.focus();
				return false;
			}

			if (regdate == null || regdate == "") {
				alert('날짜를 입력하세요');
				document.forms[0].regdate.focus();
				return false;
			} else if(!isDate(regdate)) {
				alert('숫자 형식(6자리)으로 입력하세요');
				document.forms[0].regdate.focus();
				return false;
			}
		}
		
		// 이메일 체크 정규식
		function isEmail(asValue) {
			var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			return regExp.test(asValue);
		}
		
		// 날짜 체크
		function isDate(asValue) {
			var regDate = /^\d{6}$/i;
			return regDate.test(asValue);
		}
	</script>
</body>
</html>