<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix = "sql" uri = "http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>


	<%
		request.setCharacterEncoding("EUC-KR");
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		String name = request.getParameter("name");
	
	%>
	
	<sql:setDataSource var = "dataSource" 
		url = "jdbc:oracle:thin:@localhost:1521:XE"
		driver = "oracle.jdbc.driver.OracleDriver"
		user = "hr2" password="1234"/>
		
	<sql:update dataSource = "${dataSource}" var = "resultSet">
		insert into member (id, name, pass) values (?,?,?)	
		<sql:param value = "<%= id %>"/>
		<sql:param value = "<%= name %>"/>
		<sql:param value = "<%= passwd %>"/>
	</sql:update>
	
	<c:import var = "url" url = "sql01.jsp"/>
	
	${url}
	
</body>
</html>