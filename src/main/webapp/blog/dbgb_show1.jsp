<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
    
<%@ page import="java.sql.*,java.util.*,java.text.*" %> 
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file = "db_connection_oracle.jsp" %>
<link href="filegb.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>



<meta charset="UTF-8">
<title> </title>
</head>
<body>


<%
	String sql = null; 
	PreparedStatement pstmt = null; 
	ResultSet rs = null; 
	
	String name = request.getParameter("name");
	
	
	
	
	
	
	try {
		sql = "select * from guestboard where name = ? "; 
		pstmt = conn.prepareStatement(sql); 
		pstmt.setString(1, name); 
		rs = pstmt.executeQuery(); 
		
		if ( !(rs.next())){  
			out.println ("데이타베이스에 해당 내용이 없습니다. "); 
		}else {				
			String em = rs.getString("email"); 
			if ((em !=null) && (!(em.equals("")))){   
				em = "<A href = mailto:" + em + ">" + rs.getString("name") + "</A>" ; 
			}else { 
				em = rs.getString("name"); 
			}

			   out.println("<table width='600' cellspacing='0' cellpadding='2' align='center'>");
			   out.println("<tr>");
			   out.println("<td height='22'>&nbsp;</td></tr>");
			   out.println("<tr align='center'>");
			   out.println("<td height='1' bgcolor='#1F4F8F'></td>");
			   out.println("</tr>");
			   out.println("<tr align='center' bgcolor='#DFEDFF'>");
			   out.println("<td class='button' bgcolor='#DFEDFF'>"); 
			   out.println("<div align='left'><font size='2'>"+rs.getString("subject") + "</div> </td>");
			   out.println("</tr>");
			   out.println("<tr align='center' bgcolor='#FFFFFF'>");
			   out.println("<td align='center' bgcolor='#F4F4F4'>"); 
			   out.println("<table width='100%' border='0' cellpadding='0' cellspacing='4' height='1'>");
			   out.println("<tr bgcolor='#F4F4F4'>");
			   out.println("<td width='13%' height='7'></td>");
			   out.println("<td width='51%' height='7'>글쓴이 : "+ em +"</td>");
			   out.println("<td width='25%' height='7'></td>");
			   out.println("<td width='11%' height='7'></td>");
			   out.println("</tr>");
			   out.println("<tr bgcolor='#F4F4F4'>");
			   out.println("<td width='13%'></td>");
			   out.println("<td width='51%'>작성일 : " + rs.getString("inputdate") + "</td>");
			   out.println("<td width='25%'>조회 : "+(rs.getInt("readcount")+1)+"</td>");
			   out.println("<td width='11%'></td>");
			   out.println("</tr>");
			   out.println("</table>");
			   out.println("</td>");
			   out.println("</tr>");
			   out.println("<tr align='center'>");
			   out.println("<td bgcolor='#1F4F8F' height='1'></td>");
			   out.println("</tr>");
			   out.println("<tr align='center'>");
			   out.println("<td style='padding:10 0 0 0'>");
			   out.println("<div align='left'><br>");
			   out.println("<font size='3' color='#333333'><PRE>"+rs.getString("content") + "</PRE></div>");
			   out.println("<br>");
			   out.println("</td>");
			   out.println("</tr>");
			   out.println("<tr align='center'>");
			   out.println("<td class='button' height='1'></td>");
			   out.println("</tr>");
			   out.println("<tr align='center'>");
			   out.println("<td bgcolor='#1F4F8F' height='1'></td>");
			   out.println("</tr>");
			   out.println("</table>");
			  %>
		
		
  <%    
   sql = "update freeboard set readcount= readcount + 1 where name= ?" ;		
   pstmt = conn.prepareStatement(sql);		
   pstmt.setString(1, name);
   pstmt.executeUpdate();
  }
 
 } catch (SQLException e) {
  out.println(e);
 } finally{
	 if(rs!=null)
	 	rs.close();
	 if(pstmt!=null) 
	 	pstmt.close();
	 if(conn!=null)
		conn.close();
	 
 }
%>
</BODY>
</HTML>