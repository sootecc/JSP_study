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
		//Get 요청시 처리 블락
		//System.out.println("ViewController 작동잘됨 (Get 요청 처리)");
		
		//게시물 정보 불러 오기 ( 1. 조회수 증가, 2.게시물 정보 가져오기) 
		MemberDAO dao = new MemberDAO(); 
		
		String id = req.getParameter("id"); 
		
	
		
		//게시물의 자세한 정보 값 가져오기
		MemberDTO dto = dao.selectView(id); 
		dao.close();   //객체 반납 

		//게시물 (dto) 객체를 view페이지로 전달하기 변수 값 저장 
		req.setAttribute("dto", dto); 
		req.getRequestDispatcher("/member/View.jsp").forward(req, resp); 
		
		
		
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Post 요청시 처리 블락
		//System.out.println("ViewController 작동잘됨 (Post 요청 처리)");
	}
	
	
}
