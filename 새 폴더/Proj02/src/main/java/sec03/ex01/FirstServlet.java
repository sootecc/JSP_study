package sec03.ex01;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/first0001")
public class FirstServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		
		//request 객체의 setAttribute()를 사용해서 변수의 값을 넘김
		req.setAttribute("address","서울시 강남구 역삼동");		//address가 변수, 값이 서울시 강남구 역삼동
		req.setAttribute("email","sootecc@gmail.com");
		resp.sendRedirect("second0001?name=lee&pwd=1234");		//servlet에서 다른 servlet으로 
	
		
		
		
		
		//resp.sendRedirect("index.jsp");		//JSP페이지로 이동
	}

}
