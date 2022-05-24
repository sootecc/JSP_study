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
		//List.jsp(view ������)���� �۾��⸦ Ŭ������ �� �۾��� �� ������(write.jsp)
		
		//�� �������� ����
		
		
		request.getRequestDispatcher("/member/Write.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

			MemberDTO dto = new MemberDTO();
			dto.setId(request.getParameter("id"));
			dto.setPwd(request.getParameter("pwd"));
			dto.setName(request.getParameter("name"));
			dto.setEmail(request.getParameter("email"));
			
	
			//DTO�� ��ü�� DAO�� insert �޼ҵ� ȣ��� DB�� ����
			MemberDAO dao = new MemberDAO();
			
			int result = dao.insertWrite(dto);
			
			//��ü ���� �޼ҵ� ȣ��(rs, stmt, psmt, con ��� ����)
			dao.close();
			
			//�۾��� ������ �� �̵��� ������
			if(result ==1) {	//�۾��� ����
				response.sendRedirect("../member/list.do");
			}
			//�۾��� ������ �� �̵��� ������
			if(result !=1) {	
				response.sendRedirect("../member/write.do");
			}
			
			
	}
	

}
