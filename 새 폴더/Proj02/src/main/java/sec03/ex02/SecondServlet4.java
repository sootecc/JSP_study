package sec03.ex02;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/second0004")	//dispatcher�� ���� ������ �̵�
public class SecondServlet4 extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
	
		String address = (String) req.getAttribute("address");
		String email = (String) req.getAttribute("email");
		
		
		out.print("<html><body>");
		out.print("sendRedirect�� �̿��� redirect �ǽ��Դϴ�.<br><br>");
		out.print("�ּ�: " +address+"<br><br>");
		out.print("�н�����: "+email+"<br><br>");
		out.print("</body></html>");
		
	}

}
