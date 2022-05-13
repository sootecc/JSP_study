<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" import="java.sql.*,java.util.*,java.text.*"%>
<%
request.setCharacterEncoding("EUC-KR");
%>

<%@ include file="db_connection_oracle.jsp"%>

<%
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");
	int id = 1;
	int pos = 0;
	if (cont.length() == 1)
		cont = cont + " ";
	
	while ((pos = cont.indexOf("\'", pos)) != -1) {
		String left = cont.substring(0, pos);
		String right = cont.substring(pos, cont.length());
		cont = left + "\'" + right;
		pos += 2;
	}
	
	// out.println (pos);
	// out.println (cont.length());
	// if (true) return;

	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");
	String ymd = myformat.format(yymmdd);
	
	String sql = null;
	//Connection con=null;
	Statement st = null;
	ResultSet rs = null;
	int cnt = 0;

	
	try {
		st = conn.createStatement();
		sql = "select max(id) from  guestboard"; //최신글의 번호를 가져온다. 
		rs = st.executeQuery(sql);
		if (!(rs.next())) //글이 존재하지 않는 경우  
			id = 1;
		else {
			id = rs.getInt(1) + 1; //글이존재하는 경우 최대값에 + 1	
		}
		sql = String.format("insert into guestboard(id,name,email,subject,contents, inputdate) values(%d,'%s','%s','%s','%s','%s')",id,na,em,sub,cont,ymd);
		cnt = st.executeUpdate(sql);

	} catch (SQLException e) {
		out.println(e);
	} finally {
		if (rs != null)
			rs.close();
		if (st != null)
			st.close();
		if (conn != null)
			conn.close();
	}
%>

<jsp:forward page="bg_show.jsp"></jsp:forward>