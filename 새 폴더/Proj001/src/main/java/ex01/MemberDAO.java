package ex01;

import java.util.List;
import java.util.Map;
import java.util.Vector;





public class MemberDAO extends DBConnPool{
	
	public MemberDAO() {
		super();
	}
	
	//List.jsp 출력을 위한 select
	public int selectCount( Map<String, Object> map ) {
		int totalCount = 0; 
		String query = "SELECT COUNT(*) FROM t_member";    //레코드의 총갯수 반환 ,  
			
		try {
			stmt = con.createStatement(); 
			rs = stmt.executeQuery(query);
			rs.next(); 
			totalCount = rs.getInt(1); 
			
		} catch (Exception e) {
			System.out.println("게시물 카운트중 예외 발생");
			e.printStackTrace();
		}
					
		return totalCount; 
	}
	
	 public MemberDTO selectView(String id) {
	    	MemberDTO dto = new MemberDTO();
	    	String query = "SELECT * FROM t_member WHERE id = ?"; 
	    	
	    	try {
	    		psmt = con.prepareStatement(query); 
	    		psmt.setString(1,id); 
	    		rs = psmt.executeQuery(); 
	    		
	    		if (rs.next()) {
	    			dto.setId(rs.getString(1));
	    			dto.setPwd(rs.getString(2));
	    			dto.setName(rs.getString(3));
	    			dto.setEmail(rs.getString(4));
	    			dto.setJoinDate(rs.getDate(5));
	    		}
	    		
	    	}catch (Exception e) {
	    		System.out.println("게시물 상세정보 출력중 예외 발생");
	    		e.printStackTrace();
	    	}
	    	
	    	return dto; 
	    }
	 
	 
	 
	 public List<MemberDTO> selectListPage(Map<String,Object> map) {
	        List<MemberDTO> board = new Vector<MemberDTO>();
	        String query = "SELECT * FROM (SELECT Tb.*, ROWNUM rNum FROM (SELECT * FROM t_member ORDER BY id DESC ) Tb )";
	        
	        System.out.println(query);  //콘솔에 전체 쿼리 출력 

	        try {
	            psmt = con.prepareStatement(query);
	            rs = psmt.executeQuery();

	            while (rs.next()) {
	                MemberDTO dto = new MemberDTO();

	                dto.setId(rs.getString(1));
	                dto.setPwd(rs.getString(2));
	                dto.setName(rs.getString(3));
	                dto.setEmail(rs.getString(4));
	                dto.setJoinDate(rs.getDate(5));
	                
	                board.add(dto);
	            }
	        }
	        catch (Exception e) {
	            System.out.println("게시물 조회 중 예외 발생");
	            e.printStackTrace();
	        }
	        return board;
	    }
	
	//Insert.jsp DB에 insert
	 public int insertWrite (MemberDTO dto) {
			int result = 0 ; 
			try {
				String query = "INSERT INTO t_member ( id ,pwd,name, email) VALUES ( ?, ?, ?, ?)"; 
				
			psmt = con.prepareStatement(query);  //PareparedStatement 객체 생성 
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getEmail());
			
			result = psmt.executeUpdate();  //insert가 성공일때 result > 0   //DB 에 값을 저장 
			
			
			}catch (Exception e) {
				e.printStackTrace();
			}
				
			return result; 		// result : Insert 성공시 > 0 , 실패시 : 0 
		}
	
	//delete
	 public int deletePost(String id) {
			int result = 0 ; 
			
			try {
				String query = "DELETE t_member WHERE id = ?"; 
				psmt = con.prepareStatement(query); 
				psmt.setString(1, id);
				
				result = psmt.executeUpdate();  //result > 0 삭제 성공, result = 0 : 삭제 실패 
				
			}catch (Exception e) {
				e.printStackTrace();
				System.out.println("delete 시 예외 발생 ");
			}
					
			return result; 				
		}
	
	 
	 
	// 비밀번호를 확인 하는 메소드 (입력한 비밀 번호가 DataBase 의 값과 일치하는지 확인 
		public boolean confirmPassword(String pwd, String id) {
			boolean isCorr = true; 
			try {
					//COUNT(*) = 1 : 레코드가 존재하면 : client에서 넘긴 pass , idx DB에 존재 
					//COUNT(*) = 0 : 레코드가 존재하지 않으면 client에서 넘긴 값이 DB에 존재하지 않는다. 
				String query = "SELECT COUNT(*) FROM t_member WHERE pwd = ? and id = ?";
				psmt = con.prepareStatement(query); 
				psmt.setString(1, pwd);
				psmt.setString(2, id);
				rs = psmt.executeQuery(); 
				
				rs.next(); 	
				if (rs.getInt(1) == 0) {
					isCorr = false; 
				}
						
			}catch (Exception e) {
				e.printStackTrace();
				System.out.println("비밀번호 확인시 예외 발생");
			}		
			return isCorr; 
		}
	
}
