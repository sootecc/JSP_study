<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>

<%@ page import = "java.sql.*, java.util.*, java.text.*" %>
<%request.setCharacterEncoding("EUC-KR");%>		<!-- form���� �Ѿ���� �ѱ� ó�� -->
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>form���� �Ѱ� ���� ���� DB�� insert �ϴ� ������</title>
</head>
<body>
<%@ include file = "db_conn_oracle.jsp" %> <!-- Connection ��ü -->
<%
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");
	String ymd = (new java.util.Date()).toLocaleString();	//���� �ý����� ������(�ѱ�)
			
	String sql = null;
	Statement st = null;
	int cnt = 0;  //insert, update, delete�� �� ����Ǿ����� Ȯ�� 
	
	try{
		sql = String.format("insert into guestboard2(name,email,inputdate, subject,content) values('%s','%s','%s','%s','%s')",na,em,ymd,sub,cont);
		st = conn.createStatement();
		cnt = st.executeUpdate(sql);		//insert, update, delete
		if(cnt>0)
			out.println("insert�� �� �Ǿ����ϴ�.");
		else
			out.println("insert ����");
		
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