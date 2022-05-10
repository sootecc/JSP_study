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
	//form에서 Request 객체의 getParameter로 홈에서 넘긴 변수의 값을 받는다.
	request.setCharacterEncoding("UTF-8");	//한글 깨지지 않도록 처리, EUC-KR, UTF-8
	String id = request.getParameter("id"); 
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;		//select한 결과를 담는 객체, Select한 레코드셋을 담고 있다.
	String sql = null;
	
	//폼에서 넘겨 받은 id와 passwd를 DB에서 가져온 ID, PASSWD와 비교하여 같으면 update
	
	try{
		//폼에서 넘겨 받은 id를 조건으로 해서 DB의 값을 select 해온다.
		sql = String.format("SELECT id, pass FROM mbTbl WHERE id =? ");
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);		//index는 1번부터
		rs = pstmt.executeQuery(sql);
				//stmt.executeUpdate(sql) : insert, update, delete
				//stmt.executeQuery(sql) : select 한 결과를 ResultSet 객체로 값을 반환
		if(rs.next()){	// DB에 폼에서 넘긴 ID가 존재하면 -> 폼에서 넘긴 패스워드와 DB의 Password가 일치하는지 확인
			//out.println(id+":해당 id가 존재합니다.");	
		
			//DB에서 값을 가지고 온 ID와 Pass를 변수에 할당
			String rId = rs.getString("id");
			String rPassword =rs.getString("pass");		//DB 컬럼명
			
			//폼에서 넘겨준 값과 DB에서 가져온 값이 일치하는지 확인
			if(id.equals(rId) && passwd.equals(rPassword)){
				//DB에서 가져온 pass와 폼에서 넘긴 passwd가 일치할 때 update
				sql = String.format("UPDATE mbTbl set name = ?, email = ? WHERE id = ?");
				pstmt.setString(1, name);
				pstmt.setString(2, email);
				pstmt.setString(3, id);
				pstmt.executeUpdate();
				out.println("테이블의 내용이 수정되었습니다.");
			}else{//패스워드가 일치하지 않을 때
				out.println("패스워드가 일치하지 않습니다.");
				
			}
			
		}else{	//DB에 폼에서 넘긴 ID가 존재하지 않으면 
			out.println(id+ ":해당 id가 존재하지 않습니다.");
			
		}
		//out.println(sql);
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