<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.sql.*,java.util.*"%>
<HTML>
<HEAD>
<TITLE>게시판</TITLE>
<link href="filegb.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
	<%@ include file="db_connection_oracle.jsp"%>
	<P>
	<P align=center>
		<FONT color=#0000ff face=굴림 size=3><STRONG>방명록</STRONG></FONT>
	</P>
	<P>
		<TABLE border=0 width=600 cellpadding=4 cellspacing=0>
			
			
			
			<%		//Vector : 멀티스레드 환경에서 사용, 모든 메소드가 동기화 처리되어 있음
			Vector name = new Vector();			//DB name 값만 저장
			Vector inputdate = new Vector();	//날짜
			Vector email = new Vector();		//메일주소
			Vector subject = new Vector();		//제목
			Vector content = new Vector();
			Vector keyid = new Vector();		//DB의 id 컬럼의 값을 저장하는 Vector
			
			//페이징 처리 시작 부분
			
			int where = 1;

			int totalgroup = 0;							// 출력할 페이징 그룹핑의 최대개수
			int maxpages = 5;							// 최대 페이지 개수(화면에 출력될 페이지 개수)
			int startpage = 1;							// 처음 페이지
			int endpage = startpage + maxpages - 1;		// 마지막 페이지
			int wheregroup = 1;							// 현재 위치하는 그룹
			
			// go: 해당 페이지 번호로 이동
			// bg_show.jsp?go=3
			// gogroup: 출력할 페이지의 그룹핑
			// bg_show.jsp?gogroup=2 (maxpage가 5일 때 6, 7, 8, 9, 10 에 해당하는 그룹)
			
			
			//go 변수(페이지 번호)를 넘겨 받아서 wheregroup, startpage, endpage 정보의 값을 알아낸다.
			if (request.getParameter("go") != null) {					//go 변수의 값을 가지고 있을 때
				where = Integer.parseInt(request.getParameter("go"));	//현재페이지 번호 담은 변수 
				wheregroup = (where - 1) / maxpages + 1;				//현재 위치한 페이지의 그룹			
				startpage = (wheregroup - 1) * maxpages + 1;			
				endpage = startpage + maxpages - 1;
			} 
			
			//gogroup 변수를 넘겨 받아서 startpage, endpage, where(페이지 그룹의 첫 번째 페이지) 
			else if (request.getParameter("gogroup") != null) {		//gogroup변수의 값을 가지고 올 때
				wheregroup = Integer.parseInt(request.getParameter("gogroup"));	
				startpage = (wheregroup - 1) * maxpages + 1;			
				where = startpage;										//그룹 단위로 넘어갈 때 startpage에 현 위치를 갖다 놓는다.★★
				endpage = startpage + maxpages - 1;
			}
			int nextgroup = wheregroup + 1;		//다음 그룹: 현재 그룹 + 1
			int priorgroup = wheregroup - 1;	//이전 그룹: 현재 그룹 - 1
			
			int nextpage = where + 1;			// 다음페이지: 현재페이지 + 1
			int priorpage = where - 1;			// 이전페이지: 현재페이지 - 1
			int startrow = 0;					//DataBase에서 select 한 레코드 시작 번호
			int endrow = 0;						//DataBase에서 select한 레코드 마지막 번호
			int maxrows = 2;					//출력할 레코드 수 
			int totalrows = 0;					//총 레코드 개수
			int totalpages = 0;					//총 페이지 개수
			//페이징 처리 마지막 부분
			
			
			
			int id = 0;

			String em = null;
			//Connection con= null;
			Statement st = null;
			ResultSet rs = null;
			
			try {
				//답변글이 존재하는 테이블을 출력할 때 정렬을 잘 해서 가져와야 한다.
				st = conn.createStatement();
				String sql = "select * from guestboard order by id desc";

				rs = st.executeQuery(sql);
				
				
				if (!(rs.next())) {		//rs -> DB select 결과를 담고 있지
					out.println("게시판에 올린 글이 없습니다");
				} else {
					do {
						//DataBase의 값을 가져와서 각각의 Vector에 저장
						
						keyid.addElement(new Integer(rs.getInt("id")));		
									//rs의 id컬럼 값을 가져와서 vector에 저장
						name.addElement(rs.getString("name"));
						email.addElement(rs.getString("email"));
						String idate = rs.getString("inputdate");
						inputdate.addElement(idate);
						subject.addElement(rs.getString("subject"));
						content.addElement(rs.getString("contents"));
						
					} while (rs.next());
					
					totalrows = name.size();						//name Vector에 저장된 값의 개수
					totalpages = (totalrows - 1) / maxrows + 1;		
					startrow = (where - 1) * maxrows;				//현재 페이지의 시작 레코드 번호
					endrow = startrow + maxrows - 1;				//현재 페이지의 마지막
					
				
					
					
					if (endrow >= totalrows)
						endrow = totalrows - 1;

					if (endpage > totalpages)
						endpage = totalpages;

					
					
					//현재 페이지에서 시작레코드, 마지막 레코드까지 순환하면서 출력
					for (int j = startrow; j <= endrow; j++) {
						
						id = totalrows - j;
					
						
						int imgcount = j - startrow;
						
						
						
							out.println("<table width='600' cellspacing='0' cellpadding='2' >");
						   out.println("<tr>");
						   out.println("<td height='22'>&nbsp;</td></tr>");
						   out.println("<tr align='center'>");
						   out.println("<td height='1' bgcolor='#1F4F8F'></td>");
						   out.println("</tr>");
						   out.println("<tr align='center' bgcolor='#DFEDFF'>");
						   out.println("<td class='button' bgcolor='#DFEDFF'>"); 
						   out.println("<div align='left'><font size='2'>"+subject.elementAt(j) + "</div> </td>");
						   out.println("</tr>");
						   out.println("<tr align='center' bgcolor='#FFFFFF'>");
						   out.println("<td align='center' bgcolor='#F4F4F4'>"); 
						   out.println("<table width='100%' border='0' cellpadding='0' cellspacing='4' height='1'>");
						   out.println("<tr bgcolor='#F4F4F4'>");
						   out.println("<td width='13%' height='7'></td>");
						   out.println("<td width='51%' height='7'>글쓴이 : "+ name.elementAt(j) +"</td>");
						   out.println("<td width='25%' height='7'></td>");
						   out.println("<td width='11%' height='7'></td>");
						   out.println("</tr>");
						   out.println("<tr bgcolor='#F4F4F4'>");
						   out.println("<td width='13%'></td>");
						   out.println("<td width='51%'>작성일 : " + inputdate.elementAt(j) + "</td>");
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
						   out.println("<font size='3' color='#333333'><PRE>"+content.elementAt(j) + "</PRE></div>");
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
						
					}
					//for block end
					
					rs.close();
				}
				out.println("</TABLE>");
				st.close();
				conn.close();
			} catch (java.sql.SQLException e) {
				out.println(e);
			}

			
			if (wheregroup > 1) {		//현재 나의 그룹이 1 이상일 때 
				out.println("[<A href=bg_show.jsp?gogroup=1 >처음</A>]");
				out.println("[<A href=bg_show.jsp?gogroup=" + priorgroup + ">이전</A>]");
			} 
			else {	//현재 나의 그룹이 1이상이 아닐 때 
				
				out.println("[처음]");
				out.println("[이전]");
			}
			if (name.size() != 0) {
				for (int jj = startpage; jj <= endpage; jj++) {
					if (jj == where)
				out.println("[" + jj + "]");
					else
				out.println("[<A href=bg_show.jsp?go=" + jj + ">" + jj + "</A>]");
				}
			}
			if (wheregroup < totalgroup) {
				out.println("[<A href=bg_show.jsp?gogroup=" + nextgroup + ">다음</A>]");
				out.println("[<A href=bg_show.jsp?gogroup=" + totalgroup + ">마지막</A>]");
			} else {
				out.println("[다음]");
				out.println("[마지막]");
			}
			out.println("전체 글수 :" + totalrows);
			%>


</BODY>
</HTML>