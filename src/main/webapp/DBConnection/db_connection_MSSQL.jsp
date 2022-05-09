<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import= "java.sql.*" %>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MSSQL DB Connection</title>
</head>
<body>
	
<%
	// 변수 초기화
	Connection conn = null;	//DB를 연결하는 객체 Connection
	String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";	//MSSQL Driver에 접속하기 위한
	String url = "jdbc:sqlserver://localhost:1433;DatabaseName = myDB";	//데이터베이스 /포트 다음에 세미콜론 주의
	Boolean connect = false;		//접속 확인 변수
	
	

	try{
		Class.forName(driver);	//오라클 드라이버 로드함
		conn = DriverManager.getConnection(url,"sa","1234");		//url, id, pw, conn 객체에 넣어줘야 한다.
	
		connect = true;
		conn.close();	
	}
	catch(Exception e){
		connect = false;
		e.printStackTrace();
	}

%>
			

<%
	if(connect == true){
		out.println("MSSQL DB에 잘 연결되었습니다.");
	}else{
		out.println("MSSQL DB연결에 실패하였습니다.");
	}
%>


	
	
	
	
	
	

</body>
</html>