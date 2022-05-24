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
		// Get 요청시 처리
		
		System.out.println("PassController 정상작동 ");
		String mode = req.getParameter("mode"); 
		System.out.println( "mode 변수의 값 : " + mode);
		
		
		//mode : edit <== 글수정,   mode : delete <== 글삭제 
		req.setAttribute("mode", req.getParameter("mode"));
		req.getRequestDispatcher("/member/Pass.jsp").forward(req, resp);
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Post 요청시 처리 
		
		//pass.jsp (뷰) 에서 전송한 변수 3개 
		String id = req.getParameter("id"); 
		String mode = req.getParameter("mode"); 
		String pwd = req.getParameter("pwd");
		
		//비밀번호 확인 (DAO에 작업을 시킴) 
		MemberDAO dao = new MemberDAO(); 
		boolean confirmed = dao.confirmPassword(pwd, id);
		dao.close();
		
		if (confirmed) {   //비밀 번호가 일치할때 (mode변수를 확인해서, edit : 수정, delete:삭제 
			if (mode.equals("edit")) {  //수정 페이지
				HttpSession session = req.getSession(); 
				session.setAttribute("pwd", pwd); 		//pass를 Session 변수에 할당.
				resp.sendRedirect("../member/edit.do?id=" + id );
				
			}else if (mode.equals("delete")) { //삭제 페이지
				dao = new MemberDAO(); 
				MemberDTO dto = dao.selectView(id); 
				int result = dao.deletePost(id);    //게시물 삭제 
				dao.close(); 
				
				
				
				JSFunction.alertLocation(resp, "삭제되었습니다", "../member/list.do");
			}
			
			
		}else  {	//비밀 번호가 일치하지 않을때  (Java Script실행서 이전페이지로 돌아가도록 
				//이전 페이지로 이동 (JavaScript) 
			JSFunction.alertBack(resp, "비밀번호 검증에 실패했습니다"); 
		}
		
		
		
			
	}
	
	

}
