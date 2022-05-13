<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.sql.*,java.util.*"%>
<HTML>
<HEAD>
<TITLE>게시판</TITLE>
<link href="freeboard.css" rel="stylesheet" type="text/css">
<SCRIPT language="javascript">
	function check() {		
		with (document.msgsearch) {
			if (sval.value.length == 0) {	//검색함수도 여기서 처리, 검색에에 아무것도 넣지 않고 검색 누르면 요거
				alert("검색어를 입력해 주세요!!");
				sval.focus();
				return false;
			}
			document.msgsearch.submit();
		}
	}
	function rimgchg(p1, p2) {			//Document 객체는 웹 페이지 그 자체를 의미합니다. 웹 페이지에 존재하는 HTML 요소에 접근하고자 할 때는 반드시 Document 객체부터 시작해야 합니다.
		if (p2 == 1)
			document.images[p1].src = "image/open.gif";
		else
			document.images[p1].src = "image/arrow.gif";		// 얘는 답글 이미지라서 arrow
	}	//이미지 바뀌는 것도 함수로 만들어서 토글시켜준다.

	function imgchg(p1, p2) {
		if (p2 == 1)
			document.images[p1].src = "image/open.gif";
		else
			document.images[p1].src = "image/close.gif";
	}
</SCRIPT>
</HEAD>
<BODY>
	<%@ include file="db_connection_oracle.jsp"%>
	<P>
	<P align=center>
		<FONT color=#0000ff face=굴림 size=3><STRONG>자유 게시판</STRONG></FONT>
	</P>
	<P>
		<TABLE border=0 width=600 cellpadding=4 cellspacing=0>
			<tr align="center">
				<td colspan="5" height="1" bgcolor="#1F4F8F"></td>
			</tr>
			<tr align="center" bgcolor="#87E8FF">
				<td width="42" bgcolor="#DFEDFF"><font size="2">번호</font></td>
				<td width="340" bgcolor="#DFEDFF"><font size="2">제목</font></td>
				<td width="84" bgcolor="#DFEDFF"><font size="2">등록자</font></td>
				<td width="78" bgcolor="#DFEDFF"><font size="2">날짜</font></td>
				<td width="49" bgcolor="#DFEDFF"><font size="2">조회</font></td>
			</tr>
			<tr align="center">
				<td colspan="5" bgcolor="#1F4F8F" height="1"></td>
			</tr>
			<%		//Vector : 멀티스레드 환경에서 사용, 모든 메소드가 동기화 처리되어 있음
			Vector name = new Vector();			//DB name 값만 저장
			Vector inputdate = new Vector();	//날짜
			Vector email = new Vector();		//메일주소
			Vector subject = new Vector();		//제목
			Vector rcount = new Vector();		// readcount
												
			Vector step = new Vector();			//DB의 step컬럼만 저장하는 Vector
			Vector keyid = new Vector();		//DB의 id 컬럼의 값을 저장하는 Vector
			
			//페이징 처리 시작 부분
			
			int where = 1;

			int totalgroup = 0;							// 출력할 페이징 그룹핑의 최대개수
			int maxpages = 5;							// 최대 페이지 개수(화면에 출력될 페이지 개수)
			int startpage = 1;							// 처음 페이지
			int endpage = startpage + maxpages - 1;		// 마지막 페이지
			int wheregroup = 1;							// 현재 위치하는 그룹
			
			// go: 해당 페이지 번호로 이동
			// freeboard_list.jsp?go=3
			// gogroup: 출력할 페이지의 그룹핑
			// freeboard_list.jsp?gogroup=2 (maxpage가 5일 때 6, 7, 8, 9, 10 에 해당하는 그룹)
			
			
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
			int maxrows = 4;					//출력할 레코드 수 
			int totalrows = 0;					//총 레코드 개수
			int totalpages = 0;					//총 페이지 개수
			//페이징 처리 마지막 부분
			
			
			/* out.println("=====maxpage:3 일 때====="+"<p>");
			out.println("현재 페이지: " + where);
			out.println("현재 페이지 그룹: "+wheregroup);
			out.println("시작 페이지: "+startpage);
			out.println("끝 페이지: "+endpage); */
			
			
			
			int id = 0;

			String em = null;
			//Connection con= null;
			Statement st = null;
			ResultSet rs = null;
			
			try {
				//답변글이 존재하는 테이블을 출력할 때 정렬을 잘 해서 가져와야 한다.
				st = conn.createStatement();
				String sql = "select * from freeboard order by";
				sql = sql + " masterid desc, replynum, step, id";	
				
				//masterid 컬럼에 중복된 값이 있을 경우, replynum 컬럼을 asc
				//replynum에 중복된 값이 존재할 때 step을 asc
				//step에 중복된 값이 존재할 때 id asc
				
				
				
				//id: 새 글 넘버링, 기존 최대 +1
				
				//답변글을 처리하는 컬럼 3가지
				//masterid: 답변글 grouping, masterid와 id가 같으면 원본글  
				//replynum: 답변글에 대한 넘버링(1, 2, 3...)
				//step: 답변글의 깊이
				//	0 : 원본글
				//  1 : 답변글
				//  2 : 답변의 답변글
				//  3 : 답변의 답변의 답변글
				
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
						idate = idate.substring(0, 8);		//데이터베이스에서 년 월 일
						inputdate.addElement(idate);
						subject.addElement(rs.getString("subject"));
						rcount.addElement(new Integer(rs.getInt("readcount")));
						step.addElement(new Integer(rs.getInt("step")));
						
					} while (rs.next());
					
					totalrows = name.size();						//name Vector에 저장된 값의 개수  -> 총 row의 개수와 같은 말
					totalpages = (totalrows - 1) / maxrows + 1;		// 페이지의 총 개수가 나온다.
					startrow = (where - 1) * maxrows;				//현재 페이지의 시작 레코드 번호
					endrow = startrow + maxrows - 1;				//현재 페이지의 마지막
					
				/* 	out.println("========maxrow: 3일 때==========");
					out.println("총 레코드 수: " + totalrows +"<p>");
					out.println("현재 페이지: " + where +"<p>");	
					out.println("시작 레코드" + startrow + "<p>");
					out.println("마지막 레코드"+endrow + "<p>");
					 */
					
					
					if (endrow >= totalrows)
						endrow = totalrows - 1;

					totalgroup = (totalpages - 1) / maxpages + 1;
					//out.println("토탈페이지그룹 "+totalgroup + "<p>");
					 
					if (endpage > totalpages)
						endpage = totalpages;

					
					
					//현재 페이지에서 시작레코드, 마지막 레코드까지 순환하면서 출력
					for (int j = startrow; j <= endrow; j++) {
						String temp = (String) email.elementAt(j);		//eamil Vector에서 email 주소를 가지고 온다
						if ((temp == null) || (temp.equals("")))
							em = (String) name.elementAt(j);		//이메일이 비어있으면 이름을 갖다 넣네
						else
							em = "<A href=mailto:" + temp + ">" + name.elementAt(j) + "</A>";	//메일 주소가 있으면 이름찍고 메일주소에 링크
						
						id = totalrows - j;
							
						if (j % 2 == 0) {
							out.println("<TR bgcolor='#FFFFFF' onMouseOver=\" bgColor= '#DFEDFF'\" onMouseOut=\"bgColor=''\">");
						} else {
							out.println("<TR bgcolor='#F4F4F4' onMouseOver=\" bgColor= '#DFEDFF'\" onMouseOut=\"bgColor='#F4F4F4'\">");
						}	//마우스 오버 했을 때 배경 색 넣고 아웃하면 원래 색으로 돌아오기
						out.println("<TD align=center>");
						out.println(id + "</TD>");
						out.println("<TD>");
						
						//step: 글의 깊이
						//	0 : 원본글
						//  1 : 답변글
						//  2 : 답변의 답변글
						//  3 : 답변의 답변의 답변글

						
						int stepi = ((Integer) step.elementAt(j)).intValue();
						int imgcount = j - startrow;
						if (stepi > 0) {	//-> 답변글
							for (int count = 0; count < stepi; count++)
								out.print("&nbsp;&nbsp;");		//답변글 -> 맨 앞 공백 두 칸 처리
							out.println("<IMG name=icon" + imgcount + " src=image/arrow.gif>");
							out.print("<A href=freeboard_read.jsp?id=");			//눌렀을 때 링크 처리 
							out.print(keyid.elementAt(j) + "&page=" + where);		//anchor tag href = 파일이름?컬럼= &컬럼= 형식
							out.print(" onmouseover=\"rimgchg(" + imgcount + ",1)\"");	//함수 매개변수로 1,2 토글 변수 -> 멘 으; javascript 부분에 함수 있음
							out.print(" onmouseout=\"rimgchg(" + imgcount + ",2)\">");
						} else {		// -> 원본글
							out.println("<IMG name=icon" + imgcount + " src=image/close.gif>");		//얘는 왜 줄바꿈? -> 줄바꿈하니까 한 칸 떨어지네
							out.print("<A href=freeboard_read.jsp?id=");			//눌렀을 때 링크 처리
							out.print(keyid.elementAt(j) + "&page=" + where);
							out.print(" onmouseover=\"imgchg(" + imgcount + ",1)\"");
							out.print(" onmouseout=\"imgchg	(" + imgcount + ",2)\">");
						}
						out.println(subject.elementAt(j) + "</TD>");
						out.println("<TD align=center>");
						out.println(em + "</TD>");
						out.println("<TD align=center>");
						out.println(inputdate.elementAt(j) + "</TD>");
						out.println("<TD align=center>");
						out.println(rcount.elementAt(j) + "</TD>");
						out.println("</TR>");
						
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
				out.println("[<A href=freeboard_list.jsp?gogroup=1>처음</A>]");
				out.println("[<A href=freeboard_list.jsp?gogroup=" + priorgroup + ">이전</A>]");
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
				out.println("[<A href=freeboard_list.jsp?go=" + jj + ">" + jj + "</A>]");
				}
			}
			if (wheregroup < totalgroup) {
				out.println("[<A href=freeboard_list.jsp?gogroup=" + nextgroup + ">다음</A>]");
				out.println("[<A href=freeboard_list.jsp?gogroup=" + totalgroup + ">마지막</A>]");
			} else {
				out.println("[다음]");
				out.println("[마지막]");
			}
			out.println("전체 글수 :" + totalrows);
			%>
			<!--<TABLE border=0 width=600 cellpadding=0 cellspacing=0>
 <TR>
  <TD align=right valign=bottom>
   <A href="freeboard_write.htm"><img src="image/write.gif" width="66" height="21" border="0"></A>
   </TD>
  </TR>
 </TABLE>-->

			<FORM method="post" name="msgsearch" action="freeboard_search.jsp">
				<TABLE border=0 width=600 cellpadding=0 cellspacing=0>
					<TR>
						<TD align=right width="241">
							<SELECT name=stype>	
									<OPTION value=1>이름
									<OPTION value=2>제목
									<OPTION value=3>내용
									<OPTION value=4>이름+제목
									<OPTION value=5>이름+내용
									<OPTION value=6>제목+내용
									<OPTION value=7>이름+제목+내용
							</SELECT>
						</TD>
						<TD width="127" align="center"><INPUT type=text size="17"
name="sval"></TD>
						<TD width="115">&nbsp;<a href="#" onClick="check();"><img src="image/serach.gif" border="0" align='absmiddle'></A></TD>
						<TD align=right valign=bottom width="117"><A href="freeboard_write.htm"><img src="image/write.gif" border="0"></TD>
					</TR>
				</TABLE>
			</FORM>
</BODY>
</HTML>