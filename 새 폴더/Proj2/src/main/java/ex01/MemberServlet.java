package ex01;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/member.do")
public class MemberServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//Get ��û�� doHandle�� ������.
		doHandle(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//POST ��û�� doHandle�� ������.
		doHandle(req, resp);
	}
	
	private void doHandle(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException{
		//Get�� post ����� ��ûó��	
		System.out.println("MemberServlet Controller �� �۵���");
		req.setCharacterEncoding("UTF-8");		//�ѱ��� ���� ���� ó��
		resp.setContentType("text/html;charset=UTF-8");		//�������� ����� �� html ���
		
		//DAO ��ü ���� : DAO�� �޼ҵ� ȣ���� ���� ��ü ����
		MemberDAO dao = new MemberDAO();
		MemberDTO dto = new MemberDTO();
		
		//��� ������ ���� �ٷ� HTML�� ���(out ��ü�� �����ؾ���)
		//Ŭ���̾�Ʈ�� ���������� HTML�� ����� ������.
		
		PrintWriter out = resp.getWriter();
		
		//Client�� form���� �ѱ� ���� ���� �޴´�.
			//command = "addMember" �� ��� : DB�� ���� insert�Ѵ�.
			//command = "delMember" �� ��� : DB���� ���� delete�Ѵ�.
		String command = req.getParameter("command");	//form���� post ��� hidden����
														//��ũ get������� �Ѿ�� ���� �ִ�.
		if(command != null && command.equals("addMemeber")) {
			//DB�� ���� insert
			
			String id = req.getParameter("id");
			String pwd = req.getParameter("pwd");
			String name = req.getParameter("name");
			String email = req.getParameter("email");
			
			//DTO setter
			dto.setId(id);
			dto.setPwd(pwd);
			dto.setName(name);
			dto.setEmail(email);
			
			int result = dao.addMember(dto);		//DB�� ���� insert
			dao.close();	//��ü ����(�ڿ� �ݳ�)
			
			if(result == 1) {
				System.out.println("insert ����2");
				
			}else if(result == 0) {
				System.out.println("insert ����2");
			}
			
			
		}else if(command != null && command.equals("delMember")) {
			//DB���� ���� delete
			String id = req.getParameter("id");
			int result = dao.delMember(id);
			dao.close();
			
			if(result == 1) {
				System.out.println("���� ����2");
				resp.sendRedirect("/Proj01/member.do");
			}else if(result == 0) {
				System.out.println("���� ����2");
			}
			
		}
		
		//DB�� t_member ���̺��� ���� ��� �����ͼ� ���
		//listMember�� DB select�� ����� DTO(���ڵ�)�� ��� listMember�� DTO����
		List<MemberDTO> listMember = dao.listMember();
		out.print("<html><body>");
		out.print("<table border = 1><tr align = 'center' bgcolor = 'lightgreen'>");
		out.print("<td>���̵�</td><td>��й�ȣ</td><td>�̸���</td><td>������</td><td>����</td>");
		//�� ��° tr���� ���� ������ listMember���� DTO�� ������ getter�� ���
		for(int i = 0; i<listMember.size();i++) {
			MemberDTO dto2 = new MemberDTO();
			dto2 = (MemberDTO)listMember.get(i);	//listMember�� ����� �� ���� dto ��ü�� ������.
			//dto�� ����� �ʵ� ���� getter�� ����Ͽ� ������ �Ҵ�
			String id = dto2.getId();
			String pwd = dto2.getPwd();
			String name = dto2.getName();
			String email = dto2.getEmail();
			Date joinDate = dto2.getJoinDate();
			
			out.print("<tr><td>"+id+" </td><td>"+pwd+" </td><td>"+name+" </td><td> "+email+"</td><td>"+joinDate+" </td><td><a href='/member.do?command=delMember&id="+id+"'/>����</tr>");
		}
		out.print("</table>");
		out.print("</body></html>");
		out.print("<a href='/memberForm.jsp'>�� ȸ�� ����ϱ�</a>");
		
		
	}
}
