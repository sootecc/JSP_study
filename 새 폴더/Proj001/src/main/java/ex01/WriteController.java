package ex01;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

@WebServlet("/member/write.do")
public class WriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//List.jsp(view 페이지)에서 글쓰기를 클릭했을 때 글쓰기 뷰 페이지(write.jsp)
		
		//뷰 페이지로 전송
		
		
		request.getRequestDispatcher("/member/Write.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

			MemberDTO dto = new MemberDTO();
			dto.setId(request.getParameter("id"));
			dto.setPwd(request.getParameter("pwd"));
			dto.setName(request.getParameter("name"));
			dto.setEmail(request.getParameter("email"));
			
	
			//DTO의 객체를 DAO의 insert 메소드 호출로 DB에 저장
			MemberDAO dao = new MemberDAO();
			
			int result = dao.insertWrite(dto);
			
			//객체 종료 메소드 호출(rs, stmt, psmt, con 모두 종료)
			dao.close();
			
			//글쓰기 성공일 때 이동할 페이지
			if(result ==1) {	//글쓰기 성공
				response.sendRedirect("../member/list.do");
			}
			//글쓰기 실패일 때 이동할 페이지
			if(result !=1) {	
				response.sendRedirect("../member/write.do");
			}
			
			
	}
	

}
