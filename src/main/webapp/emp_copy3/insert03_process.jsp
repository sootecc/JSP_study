<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 홈에서 넘겨받은 값을 DB에 저장하는 파일</title>
</head>
<body>
	
<%@ include file = "dbconn_mssql.jsp"%> 	<!--  파일을 불러올 때는 include를 사용한다. -->
<%
	request.setCharacterEncoding("UTF-8");	//form에서 넘긴 한글을 처리 
	
	int eno = Integer.parseInt(request.getParameter("eno"));
	String ename = request.getParameter("ename");
	String job = request.getParameter("job");
	int manager =  Integer.parseInt(request.getParameter("manager"));
	String hiredate =  request.getParameter("hiredate");
	int salary =  Integer.parseInt(request.getParameter("salary"));
	int commission =  Integer.parseInt(request.getParameter("commission"));
	int dno =  Integer.parseInt(request.getParameter("dno"));
	
	Statement stmt = null;		// Statement 객체: SQL Query 구문을 담아서 실행하는 객체 
	
	
	
	try {
		//String sql = "insert into mbTbl(idx,id,pass,name ,email) values(seq_mbTbl_idx.nextval,'"+id+"','"+passwd+"','"+name+"','"+email+"')";
		String sql2 =  String.format("insert into emp_copy(eno,ename,job,manager ,hiredate,salary,commission,dno) values('%s','%s','%s','%s','%s','%s','%s','%s')", eno,ename,job,manager,hiredate,salary,commission, dno);
		stmt = conn.createStatement();	//connection 객체를 통해서 statement 객체 생성 -> conn은 dbconn_oracle.jsp에서 가져온 것/ 형식 외워두기
		stmt.executeUpdate(sql2);		//statement 객체를 통해서 sql을 실행함
			//stmt.executeUpdate(sql): sql에 insert, update, delete (DML)문이 온다.
			//stmt.executeQuery(sql): sql에 select 문이 온다. 결과를 Resultset 객체로 반환
		out.println("테이블 삽입에 성공했습니다.");
		
		
	}catch(Exception e){
		out.println("emp_copy 테이블 삽입을 실패했습니다.");
		out.println(e.getMessage());
	}finally{
		if(stmt != null)
			stmt.close();
		if(conn != null)	
			conn.close();
	}


%>	
<br>
<br><br>
<%= eno  %><p>			<!-- 얘네가 출력? -->
<%= ename  %><p>		
<%= job  %><p>			
<%= manager %><p>
<%= hiredate%><p>
<%= salary %><p>
<%= commission %><p>
<%= dno %><p>
	
</body>
</html>