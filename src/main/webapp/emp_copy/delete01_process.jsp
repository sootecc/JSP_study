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
	
	String eno = request.getParameter("eno"); 
	String ename = request.getParameter("ename");
	String job = request.getParameter("job");
	String manager = request.getParameter("manager");
	String hiredate = request.getParameter("hiredate");
	String salary = request.getParameter("salary");
	String commission = request.getParameter("commission");
	String dno = request.getParameter("dno");
	
	Statement stmt = null;		// Statement 객체: SQL Query 구문을 담아서 실행하는 객체 
	ResultSet rs = null;
	String sql = null;
	
	
	
	try {
		
		// 레코드 삭제, 폼에서 넘긴 ID,Passwd가 일치할 때 레코드 제거, id(primary key)
		sql = String.format("select eno, pass from emp_copy where ename = '%s'",eno);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if(rs.next()){//id가 존재할 때
			//rs의 결과 레코드를 변수에 할당

			String reno = rs.getString("eno");
			String rename = rs.getString("ename");
			
			if(ename.equals(rename)){	
				sql = String.format("delete emp_copy where eno = '%s'",eno);
				stmt.executeUpdate(sql);
				out.println("테이블에서 해당 사원번호: "+eno+"가 잘 삭제되었습니다.");
				
			}else{// password 일치하지 않을 때
				out.println("사원이름이 일치하지 않습니다.");
			}
			
		}else{
			out.println("해당 사원이름은 존재하지 않습니다.");
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