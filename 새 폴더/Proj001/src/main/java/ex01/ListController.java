package ex01;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Get ������� ��û�� ������ �������� ó�� 
		
		//1. DAO ��ü ���� (Model : ����Ͻ� ���� ó�� ) 
		MemberDAO dao = new MemberDAO(); 
		
		//2.�信 ������ �Ű����� ����� �� ���� (Key,Value) 
	
        Map<String, Object> map = new HashMap<String, Object>();
        
        int totalCount = dao.selectCount(map);  // �Խù� ���� (�Խù����� start, end) 
		
		
	// �Խù� ����� �޾ƿ��� (DAO ��ü�� �۾��� ���� )
		//boardLists�� DB�� ���ڵ带 ���� DTO��ü(5��) �� ��� �ִ�. 
	
        List<MemberDTO> boardLists = dao.selectListPage(map);  // �Խù� ��� �ޱ�
        dao.close(); // DB ���� �ݱ�
	
	
	//���������� ������ ����, request ������ ������ �����͸� ������ List.jsp (��������) �� ������ 
    
    req.setAttribute("boardLists", boardLists);  //DataBase���� Select�� �����
    req.setAttribute("map", map);
    req.getRequestDispatcher("/member/List.jsp").forward(req, resp);
	
	
	
	}
	/*
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Post  ������� ��û�� ������ �������� ó�� 
	}
	*/
}
