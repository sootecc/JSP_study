<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update01_process.jsp</title>
</head>
<body>
	
<%@ include file = "dbconn_oracle.jsp" %>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	//변수에 form 값 할당
	int eno = Integer.parseInt(request.getParameter("eno"));
	String ename = request.getParameter("ename");
	String job = request.getParameter("job");
	int manager = Integer.parseInt(request.getParameter("manager"));	
	String hiredate = request.getParameter("hiredate");
	int salary = Integer.parseInt(request.getParameter("salary"));
	int commission = Integer.parseInt(request.getParameter("commission"));
	int dno = Integer.parseInt(request.getParameter("dno"));
	
	Statement stmt = null;  
	ResultSet rs = null;
	String sql;

	try{
		sql = String.format("UPDATE emp_copy set eno = '%s', ename = '%s', job = '%s', manager = '%s', hiredate='%s', salary = '%s',commission = '%s',dno = '%s'",eno, ename, job, manager, hiredate, salary, commission, dno);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if(rs.next()){
			int rEno = rs.getInt("eno");
			String rEname = rs.getString("ename");
			String rJob = rs.getString("job");
			int rManager = rs.getInt("manager");
			String rHiredate = rs.getString("hiredate");
			int rSalary = rs.getInt("salary");
			int rCommission = rs.getInt("commission");
			int rDno = rs.getInt("dno");
			
			if(ename == rEname){
				sql = String.format("UPDATE emp_copy set eno = '%s', ename = '%s', job = '%s', manager = '%s', hiredate='%s', salary = '%s',commission = '%s',dno = '%s'",eno, ename, job, manager, hiredate, salary, commission, dno);
				stmt.executeUpdate(sql);
				out.println("테이블의 내용이 수정되었습니다.");
			}else{
				out.println("없는 사원 이름입니다.");
			}
		}else{
			out.println("해당 사원번호가 존재하지 않습니다.");
		}
	}catch(Exception e){
		out.println(e.getMessage());
	}finally{
		if(rs!=null)
			rs.close();
		if(stmt!=null)
			stmt.close();
		if(conn!=null)
			conn.close();
	}


%>	
	
	
</body>
</html>