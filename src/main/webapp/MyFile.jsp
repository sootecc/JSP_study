<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h3>오늘은 JSP 첫 번째 날입니다.</h3> <br><br>
	
	<%@page import = "java.util.Date"%> <!-- jsp 코드를 알려줄 때 이렇게 사용한다 % 와 @사이에 공백이 들어가면 안된다.-->
	
	오늘의 날짜는 <%=new Date() %> 입니다.<!-- 얘네도 % 와 = 띄어 쓰면 안된다. -->
	
	
</body>
</html>