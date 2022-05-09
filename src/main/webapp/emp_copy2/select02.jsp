<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB의 내용을 가져와서 출력하기 </title>
</head>
<body>

<%@ include file = "dbconn_mysql.jsp" %>


<table width = "500" border = "1" >

	<tr><!-- 행 -->
		<th>아이디</th>	<!-- column 제목에 사용 -->
		<th>비밀번호</th>
		<th>이름</th>
		<th>email</th>
		<th>city</th>
		<th>phone</th>
	</tr>
	
<%
	ResultSet rs = null; 		//ResultSet 객체는 DB의 테이블을 Select 해서 나온 결과 레코드셋을 담는 객체, select를 하면 꼭 들어가야 함
	Statement stmt = null;		//SQL Query를 담아서 실행하는 객체
	
	try{
		String sql =  "select * from emp_copy";
		stmt = conn.createStatement();			//connection 객체의 createStatement()로 stmt를 활성화
		rs = stmt.executeQuery(sql);
			//stmt.executeQuery(sql)	: select한 결과를 ResultSet 객체에 저장해야함 
			//stmt.executeUpdate(sql)	: insert, update, delete
		while(rs.next()){
			int eno = rs.getInt("eno");
			String ename = rs.getString("ename");
			String job = rs.getString("job");
			int manager = rs.getInt("manager");
			String hiredate = rs.getString("hiredate");
			int salary = rs.getInt("salary");
			int commission = rs.getInt("commission");
			int dno = rs.getInt("dno");
		
			%><!--  JSP끝내고 html로 값 출력 -->
		<tr>
			<td><%=eno%></td>	
			<td><%=ename%></td>
			<td><%=job%></td>
			<td><%=manager%></td>
			<td><%=hiredate%></td>
			<td><%=salary%></td>
			<td><%=commission%></td>
			<td><%=dno%></td>
		</tr>
		<%
		
		}		

	}catch(Exception e){
		out.println("테이블 호출 실패");
		out.println(e.getMessage());
	}finally{
		if(rs != null)
			rs.close();
		if(stmt!=null)
			stmt.close();
		if(conn !=null)
			conn.close();
	}
%>
</table>	


</body>
</html>

 