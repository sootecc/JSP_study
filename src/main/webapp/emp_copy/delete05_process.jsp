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
	
	PreparedStatement pstmt = null;		// Statement 객체: SQL Query 구문을 담아서 실행하는 객체 
	ResultSet rs = null;
	String sql = null;
	
	
	
	try {
		
		sql = String.format("select eno, ename from emp_copy where eno = ?");
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,eno);
		rs = pstmt.executeQuery();
		
		if(rs.next()){//id가 존재할 때
			//rs의 결과 레코드를 변수에 할당

			String rId = rs.getString("eno");
			String rename = rs.getString("ename");
			
			if(ename.equals(rename)){	
				sql = String.format("delete mbTbl where eno = ?");
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,eno);
				pstmt.executeUpdate();
				out.println("테이블에서 해당 사원번호: "+eno+"가 잘 삭제되었습니다.");
				
			}else{
				out.println("사원이름이 일치하지 않습니다.");
			}
			
		}else{
			out.println("해당 사원이름이 존재하지 않습니다.");
		}
		
		out.println(sql);
		
	}catch(Exception e){
		out.println(e.getMessage());
		
	}finally{
		if(rs != null)
			rs.close();
		if(pstmt != null)
			pstmt.close();
		if(conn != null)	
			conn.close();
	}


%>	
</body>
</html>