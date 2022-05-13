<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%request.setCharacterEncoding("EUC-KR");%>
<%@ include file = "db_connection_oracle.jsp" %>

<HTML>
<HEAD>
<link href = "filegb.css" rel = "stylesheet" type = "text/css">
<TITLE>�� ���� ( ���� DataBase�� ������ ó���ϴ� ������)</TITLE>
<link href="freeboard.css" rel="stylesheet" type="text/css">
<BODY>

	[<a href = "freeborad_list.jsp?go=<%=request.getParameter("page")%>">�Խ��� ������� �̵�</a>]
	
	<%
		String sql = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;				//delete�� �� �Ǿ����� Ȯ���ϴ� ����
		
		int id = Integer.parseInt(request.getParameter("id"));
		try{
			sql = "select * from freeboard where id = ?";		//db�� ��й�ȣ�� form�� ��й�ȣ ��ġ ���� Ȯ��
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			
			if(!rs.next())
				out.println("�ش� ������ �������� �ʽ��ϴ�.");
			else{
				//id�� �����ϴ� ��� �н����� Ȯ�� �� ������ ����
				String pwd = rs.getString("password");
				if(pwd.equals(request.getParameter("password"))){
					sql = "delete freeboard where id = '?'";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, id);
					cnt = pstmt.executeUpdate();
					
					if(cnt > 0){
						out.println("�ش� ������ �� �����Ǿ����ϴ�.");
					}else{
						out.println("�ش� ������ �������� �ʾҽ��ϴ�.");
					}
					
				}else{
					out.println("��й�ȣ�� Ʋ�Ƚ��ϴ�.");
				}
			}
			
		}catch(Exception e){
			out.println(e.getMessage());
		}finally{
			if(rs!=null)
				rs.close();
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		
	%>


</BODY>
</HTML>