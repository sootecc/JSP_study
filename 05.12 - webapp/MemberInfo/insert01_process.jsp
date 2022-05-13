<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>폼에서 넘겨 받은 값을 DB에 저장하는 파일 </title>
</head>
<body>

<%@ include file = "dbconn_oracle.jsp" %>    

<%
	request.setCharacterEncoding("EUC-KR"); 	// 폼에서 넘긴 한글 처리하리 위함.
	
	//폼에서 넘긴 값을 변수에 담는다. 
	String id = request.getParameter("id"); 
	String passwd = request.getParameter("passwd");
	String name = request.getParameter ("name"); 
	String email = request.getParameter("email"); 
	
	Statement stmt = null;       //Statement 객체 : SQL 쿼리 구문을 담아서 실행 하는 객체 
	String sql = null; 		//전역 변수 
	
	try {
		 sql = "INSERT INTO mbTbl ( idx, id, pass, name, email ) Values (seq_mbTbl_idx.nextval, '" + id + "','"+  passwd + "','" + name+"','" + email + "') ";  
		
		stmt = conn.createStatement();       //connection객체를 통해서 statement객체 생성 
		stmt.executeUpdate (sql);            //statement객체를 통해서 sql을 실행함. 
					//stmt.executeUpate (sql)  : sql <== insert, update, delete 문이 온다. 
					//stmt.executeQuery (sql)  : sql <== select 문이 오면서 결과를 Resultset 객체로 반환 
		
		out.println ("테이블 삽입에 성공 했습니다. "); 
		out.println ("<p> <p>"); 
		
		//out.println (sql); 
			
		
	}catch (Exception ex){
		
		out.println ("mbTbl 테이블 삽입을 실패 했습니다. "); 
		out.println (ex.getMessage());
		out.println( "<br><p>");
		//out.println(sql);
		
		
		
	} finally {
		if (stmt != null)
			stmt.close(); 
		if ( conn != null)
			conn.close(); 
	}

%>


<p><p><p>

<%= id %> <p>  
<%= passwd %> <p>
<%= name %><p>
<%= email %> <p><p> 


<%= sql %>  <p><p>         //html 블락에서 출력 할때 
<% 

out.println(sql);			//JSP 블락에서 출력 할때 

%>






</body>
</html>