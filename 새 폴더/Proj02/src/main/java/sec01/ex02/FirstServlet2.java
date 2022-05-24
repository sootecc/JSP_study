package sec01.ex02;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/first02")		//response.addHead�� ���� ������ �̵�
public class FirstServlet2 extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		//resp.sendRedirect("second");		//servlet���� �ٸ� servlet���� 
	
		//resp.sendRedirect("index.jsp");		//JSP�������� �̵�
		
		//resp.addHeader("Refresh", "5;url=second02");		//5�� �ڿ� url�� �̵�
		resp.addHeader("Refresh", "5;url=index.jsp");
		
	}

}
