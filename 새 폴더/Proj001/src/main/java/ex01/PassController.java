package ex01;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/member/pass.do")
public class PassController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Get ��û�� ó��
		
		System.out.println("PassController �����۵� ");
		String mode = req.getParameter("mode"); 
		System.out.println( "mode ������ �� : " + mode);
		
		
		//mode : edit <== �ۼ���,   mode : delete <== �ۻ��� 
		req.setAttribute("mode", req.getParameter("mode"));
		req.getRequestDispatcher("/member/Pass.jsp").forward(req, resp);
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Post ��û�� ó�� 
		
		//pass.jsp (��) ���� ������ ���� 3�� 
		String id = req.getParameter("id"); 
		String mode = req.getParameter("mode"); 
		String pwd = req.getParameter("pwd");
		
		//��й�ȣ Ȯ�� (DAO�� �۾��� ��Ŵ) 
		MemberDAO dao = new MemberDAO(); 
		boolean confirmed = dao.confirmPassword(pwd, id);
		dao.close();
		
		if (confirmed) {   //��� ��ȣ�� ��ġ�Ҷ� (mode������ Ȯ���ؼ�, edit : ����, delete:���� 
			if (mode.equals("edit")) {  //���� ������
				HttpSession session = req.getSession(); 
				session.setAttribute("pwd", pwd); 		//pass�� Session ������ �Ҵ�.
				resp.sendRedirect("../member/edit.do?id=" + id );
				
			}else if (mode.equals("delete")) { //���� ������
				dao = new MemberDAO(); 
				MemberDTO dto = dao.selectView(id); 
				int result = dao.deletePost(id);    //�Խù� ���� 
				dao.close(); 
				
				
				
				JSFunction.alertLocation(resp, "�����Ǿ����ϴ�", "../member/list.do");
			}
			
			
		}else  {	//��� ��ȣ�� ��ġ���� ������  (Java Script���༭ ������������ ���ư����� 
				//���� �������� �̵� (JavaScript) 
			JSFunction.alertBack(resp, "��й�ȣ ������ �����߽��ϴ�"); 
		}
		
		
		
			
	}
	
	

}
