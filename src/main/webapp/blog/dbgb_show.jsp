<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.sql.*,java.util.*"%>
<HTML>
<HEAD>
<TITLE>�Խ���</TITLE>
<link href="filegb.css" rel="stylesheet" type="text/css">

</HEAD>
<BODY>
	<%@ include file="db_connection_oracle.jsp"%>
	<P>
	<P align=center>
		<FONT color=#0000ff face=���� size=3><STRONG>���� �Խ���</STRONG></FONT>
	</P>
	<P>
		<TABLE border=0 width=600 cellpadding=4 cellspacing=0>
			<tr align="center">
				<td colspan="5" height="1" bgcolor="#1F4F8F"></td>
			</tr>
			<tr align="center" bgcolor="#87E8FF">
				<td width="42" bgcolor="#DFEDFF"><font size="2">��ȣ</font></td>
				<td width="340" bgcolor="#DFEDFF"><font size="2">����</font></td>
				<td width="84" bgcolor="#DFEDFF"><font size="2">�����</font></td>
				<td width="78" bgcolor="#DFEDFF"><font size="2">��¥</font></td>
				<td width="49" bgcolor="#DFEDFF"><font size="2">��ȸ</font></td>
			</tr>
			<tr align="center">
				<td colspan="5" bgcolor="#1F4F8F" height="1"></td>
			</tr>
			<%		//Vector : ��Ƽ������ ȯ�濡�� ���, ��� �޼ҵ尡 ����ȭ ó���Ǿ� ����
			Vector name = new Vector();			//DB name ���� ����
			Vector inputdate = new Vector();	//��¥
			Vector email = new Vector();		//�����ּ�
			Vector subject = new Vector();		//����
			Vector rcount = new Vector();		// readcount
			Vector content = new Vector();
												
			Vector step = new Vector();			//DB�� step�÷��� �����ϴ� Vector
			Vector keyid = new Vector();		//DB�� id �÷��� ���� �����ϴ� Vector
			
			//����¡ ó�� ���� �κ�
			
			int where = 1;

			int totalgroup = 0;							// ����� ����¡ �׷����� �ִ밳��
			int maxpages = 5;							// �ִ� ������ ����(ȭ�鿡 ��µ� ������ ����)
			int startpage = 1;							// ó�� ������
			int endpage = startpage + maxpages - 1;		// ������ ������
			int wheregroup = 1;							// ���� ��ġ�ϴ� �׷�
			
			
			
			//go ����(������ ��ȣ)�� �Ѱ� �޾Ƽ� wheregroup, startpage, endpage ������ ���� �˾Ƴ���.
			if (request.getParameter("go") != null) {					//go ������ ���� ������ ���� ��
				where = Integer.parseInt(request.getParameter("go"));	//���������� ��ȣ ���� ���� 
				wheregroup = (where - 1) / maxpages + 1;				//���� ��ġ�� �������� �׷�			
				startpage = (wheregroup - 1) * maxpages + 1;			
				endpage = startpage + maxpages - 1;
			} 
			
			//gogroup ������ �Ѱ� �޾Ƽ� startpage, endpage, where(������ �׷��� ù ��° ������) 
			else if (request.getParameter("gogroup") != null) {		//gogroup������ ���� ������ �� ��
				wheregroup = Integer.parseInt(request.getParameter("gogroup"));	
				startpage = (wheregroup - 1) * maxpages + 1;			
				where = startpage;										//�׷� ������ �Ѿ �� startpage�� �� ��ġ�� ���� ���´�.�ڡ�
				endpage = startpage + maxpages - 1;
			}
			int nextgroup = wheregroup + 1;		//���� �׷�: ���� �׷� + 1
			int priorgroup = wheregroup - 1;	//���� �׷�: ���� �׷� - 1
			
			int nextpage = where + 1;			// ����������: ���������� + 1
			int priorpage = where - 1;			// ����������: ���������� - 1
			int startrow = 0;					//DataBase���� select �� ���ڵ� ���� ��ȣ
			int endrow = 0;						//DataBase���� select�� ���ڵ� ������ ��ȣ
			int maxrows = 4;					//����� ���ڵ� �� 
			int totalrows = 0;					//�� ���ڵ� ����
			int totalpages = 0;					//�� ������ ����
			//����¡ ó�� ������ �κ�
		
			
			
			
			int id = 0;

			String em = null;
			//Connection con= null;
			Statement st = null;
			ResultSet rs = null;
			
			try {
				//�亯���� �����ϴ� ���̺��� ����� �� ������ �� �ؼ� �����;� �Ѵ�.
				st = conn.createStatement();
				String sql = "select * from guestboard order by inputdate desc";
				
				
				
				rs = st.executeQuery(sql);
				
				
				if (!(rs.next())) {		//rs -> DB select ����� ��� ����
					out.println("�Խ��ǿ� �ø� ���� �����ϴ�");
				} else {
					do {
						//DataBase�� ���� �����ͼ� ������ Vector�� ����
						content.add(rs.getString("content"));
						keyid.add(new Integer(rs.getInt("id")));		
									//rs�� id�÷� ���� �����ͼ� vector�� ����
						name.add(rs.getString("name"));
						email.add(rs.getString("email"));
						String idate = rs.getString("inputdate");
						idate = idate.substring(0, 8);		//�����ͺ��̽����� �� �� ��
						inputdate.add(idate);
						subject.add(rs.getString("subject"));
						rcount.add(new Integer(rs.getInt("readcount")));
						step.add(new Integer(rs.getInt("step")));
						
					} while (rs.next());
					
					totalrows = name.size();						//name Vector�� ����� ���� ����  -> �� row�� ������ ���� ��
					totalpages = (totalrows - 1) / maxrows + 1;		// �������� �� ������ ���´�.
					startrow = (where - 1) * maxrows;				//���� �������� ���� ���ڵ� ��ȣ
					endrow = startrow + maxrows - 1;				//���� �������� ������
			
					
					
					if (endrow >= totalrows)
						endrow = totalrows - 1;

					totalgroup = (totalpages - 1) / maxpages + 1;
					//out.println("��Ż�������׷� "+totalgroup + "<p>");
					 
					if (endpage > totalpages)
						endpage = totalpages;

					
					
					//���� ���������� ���۷��ڵ�, ������ ���ڵ���� ��ȯ�ϸ鼭 ���
					for (int j = startrow; j <= endrow; j++) {
						id = totalrows - j;
							
					
						out.println("<TD align=center>");
						out.println(id + "</TD>");
						out.println("<TD>");
				

						
						
						 out.println("<table width='600' cellspacing='0' cellpadding='2' align='center'>");
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
						   out.println("<td width='51%' height='7'>�۾��� : "+ name.elementAt(j) +"</td>");
						   out.println("<td width='25%' height='7'></td>");
						   out.println("<td width='11%' height='7'></td>");
						   out.println("</tr>");
						   out.println("<tr bgcolor='#F4F4F4'>");
						   out.println("<td width='13%'></td>");
						   out.println("<td width='51%'>�ۼ��� : " + inputdate.elementAt(j) + "</td>");
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
						
						
						out.println(subject.elementAt(j) + "</TD>");
						out.println("<TD align=center>");
						out.println(em + "</TD>");
						out.println("<TD align=center>");
						out.println(inputdate.elementAt(j) + "</TD>");
						out.println("<TD align=center>");
						out.println(rcount.get(j) + "</TD>");
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

			if (wheregroup > 1) {		//���� ���� �׷��� 1 �̻��� �� 
				out.println("[<A href=dbgb_show.jsp?gogroup=1>ó��</A>]");
				out.println("[<A href=dbgb_show.jsp?gogroup=" + priorgroup + ">����</A>]");
			} 
			else {	//���� ���� �׷��� 1�̻��� �ƴ� �� 
				
				out.println("[ó��]");
				out.println("[����]");
			}
			if (name.size() != 0) {
				for (int jj = startpage; jj <= endpage; jj++) {
					if (jj == where)
				out.println("[" + jj + "]");
					else
				out.println("[<A href=dbgb_show.jsp?go=" + jj + ">" + jj + "</A>]");
				}
			}
			if (wheregroup < totalgroup) {
				out.println("[<A href=dbgb_show.jsp?gogroup=" + nextgroup + ">����</A>]");
				out.println("[<A href=dbgb_show.jsp?gogroup=" + totalgroup + ">������</A>]");
			} else {
				out.println("[����]");
				out.println("[������]");
			}
			out.println("��ü �ۼ� :" + totalrows);
			%>
			

</BODY>
</HTML>