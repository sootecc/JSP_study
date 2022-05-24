package sec01.ex02;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/first02")		//response.addHead를 통한 페이지 이동
public class FirstServlet2 extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		//resp.sendRedirect("second");		//servlet에서 다른 servlet으로 
	
		//resp.sendRedirect("index.jsp");		//JSP페이지로 이동
		
		//resp.addHeader("Refresh", "5;url=second02");		//5초 뒤에 url로 이동
		resp.addHeader("Refresh", "5;url=index.jsp");
		
	}

}
