<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form method = "post" action = "insert05_process.jsp">  <!-- action = "insert01_process.jsp" DB에 저장할 것을 호출 -->
		<p> 아이디: <input type = "text" name = "id">			
		<p> 패스워드: <input type = "password" name = "passwd">
		<p> 이름: <input type = "text" name = "name">
		<p> 이메일: <input type = "text" name = "email">
		<p> <input type = "submit" value = "전송">
	</form>
		

	





</body>
</html>



<!-- 
	method = "post"
	 -- http 헤더 앞에 값을 넣어 전송, 보안이 강하다. 전송용량의 제한이 없다. 
	 -- 파일 전송할 때 사용
	
	method = "get"
	 -- http 헤더 뒤에 값을 넣어 전송, 버안에 취약하다. 전송용량의 제한을 갖고 있다. 
	 -- 게시판을 만들 때 사용(post도 가능함)
 -->
 
 