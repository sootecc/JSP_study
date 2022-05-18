package model2.mvcboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.DBConnPool;

public class MVCBoardDAO extends DBConnPool{
	
	//�⺻ ������ ȣ��� �θ� Ŭ������ ȣ��
	public MVCBoardDAO() {
		super();		//DBConnPool��ü�� �⺻ ������ ȣ��, DBCP���� con ��ü Ȱ��ȭ
	}
	
	//�˻� ���ǿ� �´� �Խù� ������ ��ȯ

	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		String query = "SELECT COUNT(*) FROM mvcboard";		//���ڵ� �� ����
			if(map.get("searchWord") != null) 				//�˻������ ���������
				query += " WHERE "+map.get("searchField")+" like '%"+map.get("searchWord")+"%'";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
		}catch(Exception e) {
			System.out.println("�Խù� ī��Ʈ �� ���� �߻�");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	//�˻� ���ǿ� �´� �Խù� ����� ��ȯ
		//DataBase���� Select�� ��� ���� DTO�� ��Ƽ� ���Ͻ�����
	public List<MVCBoardDTO> selectListPage(Map<String, Object> map){
		List<MVCBoardDTO> board = new Vector<MVCBoardDTO>();
		String query =" "+"SELECT * FROM (select Tb.*, ROWNUM rNUM FROM(select * from mvcboard";
		if(map.get("searchWord")!=null) {
			query += " WHERE" + map.get("searchField") + " LIKE '%"+map.get("searchWord")+"%'";
		}
		
		query += " ORDER BY Tb) WHERE rNUM BETWEEN ? AND ?)";
		
		try {	//psmt ��ü ���� �� ���� ����
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();
			
			//rs�� ����� ���� DTO�� ����
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
			
			
		return board;		//board�� DTO ��ü�� �����ϰ� �ִ�.
		
	}
	
	//��� �˻�(Select): �־��� �Ϸ� ��ȣ�� �ش��ϴ� ���� DTO�� �޾Ƽ� ��ȯ�Ѵ�. (�� ������ read)
	
	//������ ����(Insert)
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
		
		result = psmt.executeUpdate();		//insert�� ������ �� result > 0 , DB�� ���� ����
		
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;		//result: Insert ������ > 0, ���н� : 0
	}
	//������ ����(Update)
	
	//������ ����(Delete)
	
	//������ �˻�(Ư�� �������� select)
}
