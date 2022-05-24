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
		// Get 방식으로 요청이 왔을때 서버에서 처리 
		
		//1. DAO 객체 생성 (Model : 비즈니스 로직 처리 ) 
		MemberDAO dao = new MemberDAO(); 
		
		//2.뷰에 전달할 매개변수 저장용 맵 생성 (Key,Value) 
	
        Map<String, Object> map = new HashMap<String, Object>();
        
        int totalCount = dao.selectCount(map);  // 게시물 개수 (게시물에서 start, end) 
		
		
	// 게시물 목록을 받아오기 (DAO 객체에 작업을 전달 )
		//boardLists는 DB의 레코드를 담은 DTO객체(5개) 를 담고 있다. 
	
        List<MemberDTO> boardLists = dao.selectListPage(map);  // 게시물 목록 받기
        dao.close(); // DB 연결 닫기
	
	
	//뷰페이지로 데이터 전달, request 영역에 전달할 데이터를 저장후 List.jsp (뷰페이지) 로 포워드 
    
    req.setAttribute("boardLists", boardLists);  //DataBase에서 Select한 결과값
    req.setAttribute("map", map);
    req.getRequestDispatcher("/member/List.jsp").forward(req, resp);
	
	
	
	}
	/*
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Post  방식으로 요청이 왔을때 서버에서 처리 
	}
	*/
}
