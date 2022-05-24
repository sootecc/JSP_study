package sec02.ex04;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/first004")		//dispatcher�� ���� ������ �̵�
public class FirstServlet4 extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		//resp.sendRedirect("second");		//servlet���� �ٸ� servlet���� 
	
		//resp.sendRedirect("index.jsp");		//JSP�������� �̵�
		
		//resp.addHeader("Refresh", "5;url=second02");		//5�� �ڿ� url�� �̵�
		//resp.addHeader("Refresh", "5;url=index.jsp");
		
//		out.print("<script type = 'text/javascript'>");
//		out.print("location.href='second03';");
//		out.print("</script>");
		
//		out.print("<script type = 'text/javascript'>");
//		out.print("location.href='index.jsp';");
//		out.print("</script>");
		
		
		//url �ּҰ� �ٲ��� �ʴ´�. 
		RequestDispatcher dis = req.getRequestDispatcher("second004?name=park&pwd=1234");
		dis.forward(req, resp);
		
//		RequestDispatcher dis = req.getRequestDispatcher("index.jsp");
//		dis.forward(req, resp);
	}

}
