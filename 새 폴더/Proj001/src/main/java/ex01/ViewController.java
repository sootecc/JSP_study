package ex01;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/member/view.do")
public class ViewController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//Get ��û�� ó�� ���
		//System.out.println("ViewController �۵��ߵ� (Get ��û ó��)");
		
		//�Խù� ���� �ҷ� ���� ( 1. ��ȸ�� ����, 2.�Խù� ���� ��������) 
		MemberDAO dao = new MemberDAO(); 
		
		String id = req.getParameter("id"); 
		
	
		
		//�Խù��� �ڼ��� ���� �� ��������
		MemberDTO dto = dao.selectView(id); 
		dao.close();   //��ü �ݳ� 

		//�Խù� (dto) ��ü�� view�������� �����ϱ� ���� �� ���� 
		req.setAttribute("dto", dto); 
		req.getRequestDispatcher("/member/View.jsp").forward(req, resp); 
		
		
		
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Post ��û�� ó�� ���
		//System.out.println("ViewController �۵��ߵ� (Post ��û ó��)");
	}
	
	
}
