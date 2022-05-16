<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" import="java.sql.*,java.util.*,java.text.*"%>


<%
request.setCharacterEncoding("UTF-8");
%>

<%@ include file="db_connection_oracle.jsp"%>

	<%
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");
	int id  = Integer.parseInt(request.getParameter("id"));
	int pos = 0;
	if (cont.length() == 1)
		cont = cont + " ";
	
	while ((pos = cont.indexOf("\'", pos)) != -1) {		
		String left = cont.substring(0, pos);
		String right = cont.substring(pos, cont.length());
		cont = left + "\'" + right;
		pos += 2;
	}

	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");
	String ymd = myformat.format(yymmdd);		//여기서 포멧 바꿔줘야 한다.
	
	String sql = null;
	Statement st = null;
	ResultSet rs = null;
	int cnt = 0;

	try {
		st = conn.createStatement();
		sql  = String.format("insert into guestboard( name, email, subject, content, inputdate, id) values('%s','%s','%s','%s','%s',%d)",na,em,sub,cont, ymd,id);
		//rs = st.executeQuery(sql);
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

<jsp:forward page="dbgb_show.jsp"></jsp:forward>			


