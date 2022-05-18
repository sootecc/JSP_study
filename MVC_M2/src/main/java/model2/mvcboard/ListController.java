package model2.mvcboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.BoardPage;//����¡ ó���ϴ� ��ü

public class ListController extends HttpServlet{
	//��Ʈ�ѷ����� get, post ������� ���� �� ���̽� �з��ؼ� ���������
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//Get ������� ��û�� ���� �� �������� ó��
		
		//1. DAO ��ü ����(Model: ����Ͻ� ���� ó��)
		MVCBoardDAO dao = new MVCBoardDAO();
		
		//2. �信 ������ �Ű����� ����� �� ����(Key, Value)
		Map<String,Object> map = new HashMap<String, Object>();
		
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		
		if(searchWord!=null) {	//�˻�� �����Ѵٸ� map�� ���� ����
			map.put("searchField", searchField);
			map.put("searchWord", searchWord);
		}
		//�Խù� ���� �˾ƿ���(DAO�� selectCount(map)
		int totalCount = dao.selectCount(map);
		//System.out.println("��ü ���ڵ� �� : "+totalCount);
		//System.out.println("List.do ��û�� Controller ������ ����");
		
		/* ����¡ ó�� �κ� start*/
		ServletContext application  = getServletContext();
		int pageSize = Integer.parseInt(application.getInitParameter("POSS_PER_PAGE"));
		int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
		
		//System.out.println(pageSize);
		//System.out.println(blockPage);
		
		//���� ������ Ȯ��
		int pageNum = 1;
		String pageTemp = req.getParameter("pageNum");
		if(pageTemp !=null && !pageTemp.equals("")) 
			pageNum = Integer.parseInt(pageTemp);	//���� ������� ���� �� �Ѿ���� ������ ������ ������ ��ȯ�Ͽ� ����
		
		//��Ͽ� ����� �Խù� ���� ���
		int start = (pageNum -1) * pageSize + 1; //ù �Խù� ��ȣ
		int end = pageNum * pageSize;	//������ �Խù� ��ȣ
		
		//�� �������� ���� ������
		map.put("start", start);
		map.put("end", end);
		/* ����¡ ó�� �κ� end*/

		
		//�Խù� ����� �޾ƿ���(DAO ��ü�� �۾��� ����)
			//boardList�� DB�� ���ڵ带 ���� DTO ��ü�� ���� �ִ�. 
		List<MVCBoardDTO> boardLists = dao.selectListPage(map);
		dao.close();
		
		//���������� ������ �Ű��������� �߰�
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, "../mvcboard/list.do");
		map.put("pagingImg", pagingImg);
		map.put("totalCount", totalCount);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);
		
		//���������� ������ ����, request ������ ������ �����͸� ���� �� List.jsp�� ������
		req.setAttribute("boardLists", boardLists);
		req.setAttribute("map", map);
		req.getRequestDispatcher("/mvcboard/List.jsp").forward(req, resp);
		
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//Post ������� ��û�� ���� �� �������� ó��
	}
	
	
	
}
