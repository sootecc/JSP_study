package sec03.ex01;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/second0001")
public class SecondServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		
		String address = (String) req.getAttribute("address");
		String email = (String) req.getAttribute("email");
		
		
		out.print("<html><body>");
		out.print("sendRedirect를 이용한 redirect 실습입니다.<br><br>");
		out.print("주소: " +address+"<br><br>");
		out.print("패스워드: "+email+"<br><br>");
		out.print("</body></html>");
		
		
	
	}

}
