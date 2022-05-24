package ex01;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/member.do")
public class MemberServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//Get 요청을 doHandle로 보낸다.
		doHandle(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//POST 요청을 doHandle로 보낸다.
		doHandle(req, resp);
	}
	
	private void doHandle(HttpServletRequest req, HttpServletResponse resp) throws ServletException,IOException{
		//Get과 post 모두의 요청처리	
		System.out.println("MemberServlet Controller 잘 작동됨");
		req.setCharacterEncoding("UTF-8");		//한글의 깨짐 방지 처리
		resp.setContentType("text/html;charset=UTF-8");		//브라우저에 출력할 때 html 출력
		
		//DAO 객체 생성 : DAO의 메소드 호출을 위한 객체 생성
		MemberDAO dao = new MemberDAO();
		MemberDTO dto = new MemberDTO();
		
		//출력 페이지 없이 바로 HTML로 출력(out 객체를 생성해야함)
		//클라이언트의 웹브라우저에 HTML의 출력을 보낸다.
		
		PrintWriter out = resp.getWriter();
		
		//Client의 form에서 넘긴 변수 값을 받는다.
			//command = "addMember" 일 경우 : DB에 값을 insert한다.
			//command = "delMember" 일 경우 : DB에서 값을 delete한다.
		String command = req.getParameter("command");	//form에서 post 방식 hidden으로
														//링크 get방식으로 넘어올 수도 있다.
		if(command != null && command.equals("addMemeber")) {
			//DB에 값을 insert
			
			String id = req.getParameter("id");
			String pwd = req.getParameter("pwd");
			String name = req.getParameter("name");
			String email = req.getParameter("email");
			
			//DTO setter
			dto.setId(id);
			dto.setPwd(pwd);
			dto.setName(name);
			dto.setEmail(email);
			
			int result = dao.addMember(dto);		//DB에 값을 insert
			dao.close();	//객체 종료(자원 반납)
			
			if(result == 1) {
				System.out.println("insert 성공2");
				
			}else if(result == 0) {
				System.out.println("insert 실패2");
			}
			
			
		}else if(command != null && command.equals("delMember")) {
			//DB에서 값을 delete
			String id = req.getParameter("id");
			int result = dao.delMember(id);
			dao.close();
			
			if(result == 1) {
				System.out.println("삭제 성공2");
				resp.sendRedirect("/Proj01/member.do");
			}else if(result == 0) {
				System.out.println("삭제 실패2");
			}
			
		}
		
		//DB의 t_member 테이블의 값을 모두 가져와서 출력
		//listMember는 DB select한 결과를 DTO(레코드)에 담고 listMember에 DTO저장
		List<MemberDTO> listMember = dao.listMember();
		out.print("<html><body>");
		out.print("<table border = 1><tr align = 'center' bgcolor = 'lightgreen'>");
		out.print("<td>아이디</td><td>비밀번호</td><td>이메일</td><td>가입일</td><td>삭제</td>");
		//두 번째 tr에서 루프 돌리며 listMember에서 DTO를 꺼내에 getter로 출력
		for(int i = 0; i<listMember.size();i++) {
			MemberDTO dto2 = new MemberDTO();
			dto2 = (MemberDTO)listMember.get(i);	//listMember에 저장된 각 방의 dto 객체를 꺼낸다.
			//dto의 저장된 필드 값을 getter를 사용하여 변수에 할당
			String id = dto2.getId();
			String pwd = dto2.getPwd();
			String name = dto2.getName();
			String email = dto2.getEmail();
			Date joinDate = dto2.getJoinDate();
			
			out.print("<tr><td>"+id+" </td><td>"+pwd+" </td><td>"+name+" </td><td> "+email+"</td><td>"+joinDate+" </td><td><a href='/member.do?command=delMember&id="+id+"'/>삭제</tr>");
		}
		out.print("</table>");
		out.print("</body></html>");
		out.print("<a href='/memberForm.jsp'>새 회원 등록하기</a>");
		
		
	}
}
