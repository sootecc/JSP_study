<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>

<%@ page import = "java.sql.*, java.util.*, java.text.*" %>
<%request.setCharacterEncoding("EUC-KR");%>		<!-- form에서 넘어오는 한글 처리 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>form에서 넘겨 받은 값을 DB에 insert 하는 페이지</title>
</head>
<body>
<%@ include file = "db_conn_oracle.jsp" %> <!-- Connection 객체 -->
<%
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");
	String ymd = (new java.util.Date()).toLocaleString();	//현재 시스템의 로케일(한국)
			
	String sql = null;
	Statement st = null;
	int cnt = 0;  //insert, update, delete가 잘 적용되었는지 확인 
	
	try{
		sql = String.format("insert into guestboard2(name,email,inputdate, subject,content) values('%s','%s','%s','%s','%s')",na,em,ymd,sub,cont);
		st = conn.createStatement();
		cnt = st.executeUpdate(sql);		//insert, update, delete
		if(cnt>0)
			out.println("insert가 잘 되었습니다.");
		else
			out.println("insert 실패");
		
	}catch(Exception e){
		out.println(e.getMessage());
	}finally{
		if(st!=null)
			st.close();
		if(conn!= null)
			conn.close();
	}
	
	
%>
	

</body>
</html>

<jsp:forward page = "dbgb_show.jsp"></jsp:forward>