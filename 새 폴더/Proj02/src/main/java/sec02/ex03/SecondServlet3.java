package sec02.ex03;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/second003")	//location.href를 통한 페이지 이동
public class SecondServlet3 extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		
		String name = req.getParameter("name");
		String pwd = req.getParameter("pwd");
		
		out.print("<html><body>");
		out.print("location.href를 이용한 redirect 실습입니다.<br><br>");
		out.print("이름: " +name+"<br><br>");
		out.print("패스워드: "+pwd+"<br><br>");
		out.print("</body></html>");
	}

}
