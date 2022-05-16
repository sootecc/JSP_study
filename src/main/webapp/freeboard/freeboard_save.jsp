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
	String pw = request.getParameter("password");
	int id = 1;
	int pos = 0;
	if (cont.length() == 1)
		cont = cont + " ";
	
	while ((pos = cont.indexOf("\'", pos)) != -1) {		//-1: 값이 존재하지 않을 때
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
		sql = "select max(id) from  freeboard"; //최신글의 번호를 가져온다. 
		rs = st.executeQuery(sql);
		if (!(rs.next())) //글이 존재하지 않는 경우  
			id = 1;
		else {
			id = rs.getInt(1) + 1; //글이존재하는 경우 최대값에 + 1	
	
		}
		sql = "insert into freeboard(id,name,password,email,subject,";
		sql += "content,inputdate,masterid,readcount,replynum,step)";
		sql += " values(" + id + ", '" + na + "','" + pw + "','" + em;
		sql += "','" + sub + "','" + cont + "','" + ymd + "'," + id + ",";
		sql += "0,0,0)";
	
		cnt = st.executeUpdate(sql);
	
		//if (cnt > 0)
		//	out.println("데이터가 성공적으로 입력되었습니다.");
		//else
		//	out.println("데이터가 입력되지 않았습니다. ");
	
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

<jsp:forward page="freeboard_list.jsp"></jsp:forward>			
<!--  요청 흐름이 이동할 때 이 파일에서 사용한 request 기본 객체와 response 기본 객체가 freeboard_list.jsp 로 전달된다. -->
<!--  
	공통점: 페이지 이동

	jsp:forward  : 
		서버단에서 페이지를 이동, 기존의 클라이언트 url 정보가 바뀌지 않는다.
			
	response.sendRedirect  : 
		클라이언트에서 페이지를 재요청으로 페이지 이동, 이동하는 페이지로 url 정보가 바뀐다.

 -->

