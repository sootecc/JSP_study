<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>



<%@ include file = "dbconn_oracle.jsp"%>

<table width = "1000" border = "1">
	<tr>
		<th>사원번호</th>
		<th>이름</th>
		<th>직책</th>
		<th>직속상관번호</th>
		<th>입사일</th>
		<th>급여</th>
		<th>보너스</th>
		<th>부서번호</th>
	</tr>

	<%
		ResultSet rs = null;								// ResultSet 객체는 DB의 테이블을 Select문으로 read한 결과, 즉 레코드셋을 담는 객체
	
		Statement stmt = null;								// Statement 객체는 SQL 쿼리를 담아서 실행하는 객체이다.
	
		try {
			String sql = "SELECT * FROM emp_copy";
			
			stmt = conn.createStatement();					// Connection 객체의 createStatement() 함수로 Statement 객체 활성화
			
			rs = stmt.executeQuery(sql);					// stmt.executeQuery(sql); : select 문이 오면서 그 결과를 Resultset 객체로 반환한다.
			
			
			while (rs.next()) {
				String eno = rs.getString("eno");
				String ename = rs.getString("ename");
				String job = rs.getString("job");
				String manager = rs.getString("manager");
				String hiredate = rs.getString("hiredate");
				String salary = rs.getString("salary");
				String commission = rs.getString("commission");
				String dno = rs.getString("dno");
			%>
			
			<tr>
				<td><%= eno %></td>
				<td><%= ename %></td>
				<td><%= job %></td>
				<td><%= manager %></td>
				<td><%= hiredate %></td>
				<td><%= salary %></td>
				<td><%= commission %></td>
				<td><%= dno %></td>
			</tr>
			
			<%
				
			}
			
			
			
		} catch (Exception e) {
			out.println("테이블 호출을 실패하였습니다.");
			out.println(e.getMessage());
		} finally {
			if (rs != null) {
				rs.close();
			}
			
			if (stmt != null) {
				rs.close();
			}
			
			if (conn != null) {
				conn.close();
			}
		}
	
	%>

</table>




</body>
</html>