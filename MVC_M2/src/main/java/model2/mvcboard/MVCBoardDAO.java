package model2.mvcboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.DBConnPool;

public class MVCBoardDAO extends DBConnPool{
	
	//기본 생성자 호출시 부모 클래스를 호출
	public MVCBoardDAO() {
		super();		//DBConnPool객체의 기본 생성자 호출, DBCP에서 con 객체 활성화
	}
	
	//검색 조건에 맞는 게시물 개수를 반환

	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		String query = "SELECT COUNT(*) FROM mvcboard";		//레코드 총 개수
			if(map.get("searchWord") != null) 				//검색기능을 사용했으면
				query += " WHERE "+map.get("searchField")+" like '%"+map.get("searchWord")+"%'";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
		}catch(Exception e) {
			System.out.println("게시물 카운트 중 예외 발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	//검색 조건에 맞는 게시물 목록을 반환
		//DataBase에서 Select한 결과 값을 DTO에 담아서 리턴시켜줌
	public List<MVCBoardDTO> selectListPage(Map<String, Object> map){
		List<MVCBoardDTO> board = new Vector<MVCBoardDTO>();
		String query =" "+"SELECT * FROM (select Tb.*, ROWNUM rNUM FROM(select * from mvcboard";
		if(map.get("searchWord")!=null) {
			query += " WHERE" + map.get("searchField") + " LIKE '%"+map.get("searchWord")+"%'";
		}
		
		query += " ORDER BY Tb) WHERE rNUM BETWEEN ? AND ?)";
		
		try {	//psmt 객체 생성 후 쿼리 실행
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();
			
			//rs의 저장된 값을 DTO에 저장
			while(rs.next()) {
				MVCBoardDTO dto = new MVCBoardDTO();
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitcount(10);
				
				board.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
			
			
		return board;		//board는 DTO 객체를 저장하고 있다.
		
	}
	
	//목록 검색(Select): 주어진 일련 번호에 해당하는 값을 DTO가 받아서 반환한다. (한 페이지 read)
	
	//데이터 삽입(Insert)
	public int insertWrite(MVCBoardDTO dto) {
		int result = 0;
		try {
		String query = String.format( "INSERT into mvcboard(idx, name, title, content, ofile, sfile, pass) VALUES(seq_board_num.nextval,?,?,?,?,?,? )");
		psmt = con.prepareStatement(query);
		psmt.setString(1, dto.getName());
		psmt.setString(2, dto.getTitle());
		psmt.setString(3, dto.getContent());
		psmt.setString(4, dto.getOfile());
		psmt.setString(5, dto.getSfile());
		psmt.setString(6, dto.getPass());
		
		result = psmt.executeUpdate();		//insert가 성공일 때 result > 0 , DB에 값을 저장
		
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;		//result: Insert 성공시 > 0, 실패시 : 0
	}
	//데이터 수정(Update)
	
	//데이터 삭제(Delete)
	
	//데이터 검색(특정 조건으로 select)
}
