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
	
<%
	// 변수 초기화
	Connection conn = null;	//DB를 연결하는 객체 Connection
	String driver = "oracle.jdbc.driver.OracleDriver";	//Oracle Driver에 접속
	String url = "jdbc:oracle:thin:@localhost:1521:XE";	//XE 데이터베이스
	Class.forName(driver);	//오라클 드라이버 로드함 -> Class 는 JVM에서 동작할 클래스들의 정보를 묘사하는 일종의 메타 클래스
							//실행중인 자바 프로그램에서 클래스와 인터페이스를 표현(정보를 담는)클래스
							// Class의 static 메소드인 forName은 클래스의 이름을 매개변수로 받아서 Class 객체를 리턴해준다.
	conn = DriverManager.getConnection(url,"hr","hr");		//url, id, pw, conn 객체에 넣어줘야 한다.
%>
			


</body>
</html>