<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import= "java.sql.*" %>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Oracle DB Connection</title>
</head>
<body>
	
<%	//insert, update, select, delete 할 때마다 써야하기 때문에 import 할 파일로 만드는 것이 좋다. 
	Connection conn = null;	
	String driver = "oracle.jdbc.driver.OracleDriver";	
	String url = "jdbc:oracle:thin:@localhost:1521:XE";	
	Class.forName(driver);	
	conn = DriverManager.getConnection(url,"hr2","1234");
%>
</body>
</html>