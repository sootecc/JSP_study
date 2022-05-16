<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> delete</title>
</head>
<body>
<% %><!-- script retag라고 부른다 -->	
<%@ include file = "dbconn_oracle.jsp"%> 	<!--  파일을 불러올 때는 include를 사용한다. -->
<%
	request.setCharacterEncoding("UTF-8");	//form에서 넘긴 한글을 처리 
	
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String email =  request.getParameter("email");
	
	Statement stmt = null;		// Statement 객체: SQL Query 구문을 담아서 실행하는 객체 
	ResultSet rs = null;
	String sql = null;
	
	
	
	try {
		
		// 레코드 삭제, 폼에서 넘긴 ID,Passwd가 일치할 때 레코드 제거, id(primary key)
		sql = String.format("select id, pass from mbTbl where id = '%s'",id);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if(rs.next()){//id가 존재할 때
			//rs의 결과 레코드를 변수에 할당

			String rId = rs.getString("id");
			String rPass = rs.getString("pass");
			
			if(passwd.equals(rPass)){	//폼의 password와 DB의 Password가 일치할 때
				sql = String.format("delete mbTbl where id = '%s'",id);
				stmt.executeUpdate(sql);
				out.println("테이블에서 해당 아이디: "+id+"가 잘 삭제되었습니다.");
				
			}else{// password 일치하지 않을 때
				out.println("패스워드가 일치하지 않습니다.");
			}
			
		}else{
			out.println("해당 아이디는 존재하지 않습니다.");
		}
		
		out.println(sql);
		
	}catch(Exception e){
		out.println(e.getMessage());
		
	}finally{
		if(rs != null)
			rs.close();
		if(stmt != null)
			stmt.close();
		if(conn != null)	
			conn.close();
	}


%>	
</body>
</html>