<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import= "java.sql.*" %>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MYSQL DB Connection</title>
</head>
<body>
	
<%
	// 변수 초기화
	Connection conn = null;	//DB를 연결하는 객체 Connection
	String driver = "com.mysql.jdbc.Driver";	//MYSQL Driver에 접속
	String url = "jdbc:mysql://localhost:3306/mydb";	//XE 데이터베이스
	Boolean connect = false;		//접속 확인 변수

		Class.forName(driver);	//오라클 드라이버 로드함
		conn = DriverManager.getConnection(url,"root","1234");		//url, id, pw, conn 객체에 넣어줘야 한다.


%>
			

	

</body>
</html>