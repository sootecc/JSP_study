<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<form method = "post" action = "insert01_process.jsp"> 
		<p> ���̵� : <input type = "text" name = "id">
		<p> �н����� : <input type = "password" name = "passwd"> 
		<p> �̸� : <input type = "text" name = "name"> 
		<p> �̸��� : <input type = "text" name = "email">
		<p> <input type = "submit" values = "����"> 
	
	</form>

</body>
</html>

<!-- 
	method = "post" 
		-- http ��� �տ� ���� �־� ����, ������ ���ϴ�. ���ۿ뷮�� ������ ����. , ���������Ҷ� 
	
	method = "get"
		-- http ��� �ڿ� �ٿ��� ���� ����, ���ȿ� ��� �Ѵ�. ���۷��� ������ ������ �ִ�.  
		-- �Խ��ǿ��� ���. 

 -->