<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form method = "post" action = "insert01_process.jsp">  <!-- action = "insert01_process.jsp" DB에 저장할 것을 호출 -->
		<p> 사원번호: <input type = "text" name = "eno">			
		<p> 사원이름: <input type = "text" name = "ename">
		<p> 직업: <input type = "text" name = "job">
		<p> 매니저번호: <input type = "text" name = "manager">
		<p> 입사일: <input type = "date" name = "hiredate">
		<p> 월급: <input type = "text" name = "salary">
		<p> 보너스: <input type = "text" name = "commission">
		<p> 부서번호: <input type = "text" name = "dno">
		<p> <input type = "submit" values = "전송">
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
 
 