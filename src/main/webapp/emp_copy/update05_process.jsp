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

<%@ include file = "dbconn_oracle.jsp"%> 	
<%
	
	request.setCharacterEncoding("UTF-8");	
	int eno = Integer.parseInt(request.getParameter("eno"));
	String ename = request.getParameter("ename");
	String job = request.getParameter("job");
	int manager = Integer.parseInt(request.getParameter("manager"));	
	String hiredate = request.getParameter("hiredate");
	int salary = Integer.parseInt(request.getParameter("salary"));
	int commission = Integer.parseInt(request.getParameter("commission"));
	int dno = Integer.parseInt(request.getParameter("dno"));
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;		
	String sql = null;
	
	
	try{
		sql = String.format("select eno from emp_copy where eno = ?");
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery(sql);
		if(rs.next()){	
		
			int rEno = rs.getInt("eno");
			String rEname = rs.getString("ename");
			String rJob = rs.getString("job");
			int rManager = rs.getInt("manager");
			String rHiredate = rs.getString("hiredate");
			int rSalary = rs.getInt("salary");
			int rCommission = rs.getInt("commission");
			int rDno = rs.getInt("dno");
			
			if(eno == rEno){
				sql = String.format("UPDATE emp_copy set eno = ?, ename = ?, job = ?, manager = ?, hiredate = ?, salary = ?, commission = ?, dno = ? WHERE eno = ?");
				pstmt.executeUpdate(sql);
				pstmt.setInt(1, eno);
				pstmt.setString(2, ename);
				pstmt.setString(3, job);
				pstmt.setInt(4, manager);
				pstmt.setString(5, hiredate);
				pstmt.setInt(6, salary);
				pstmt.setInt(7, commission);
				pstmt.setInt(8, dno);
				pstmt.setInt(9, eno);
				pstmt.executeUpdate();
				out.println("테이블의 내용이 수정되었습니다.");
			}else{
				out.println("없는 사원 번호입니다.");
				
			}
			
		}else{	
			out.println("해당 사원번호가 존재하지 않습니다.");
			
		}
		
	}catch(Exception e){
		out.println(e.getMessage());
		out.println(sql);
	}finally{
		if(rs!=null)
			rs.close();
		if(pstmt!=null)
			pstmt.close();
		if(conn!=null)
			conn.close();
	}
	
	



%>
	
	
</body>
</html>