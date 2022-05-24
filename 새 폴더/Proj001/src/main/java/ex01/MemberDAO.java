package ex01;

import java.util.List;
import java.util.Map;
import java.util.Vector;





public class MemberDAO extends DBConnPool{
	
	public MemberDAO() {
		super();
	}
	
	//List.jsp ����� ���� select
	public int selectCount( Map<String, Object> map ) {
		int totalCount = 0; 
		String query = "SELECT COUNT(*) FROM t_member";    //���ڵ��� �Ѱ��� ��ȯ ,  
			
		try {
			stmt = con.createStatement(); 
			rs = stmt.executeQuery(query);
			rs.next(); 
			totalCount = rs.getInt(1); 
			
		} catch (Exception e) {
			System.out.println("�Խù� ī��Ʈ�� ���� �߻�");
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
	    		System.out.println("�Խù� ������ ����� ���� �߻�");
	    		e.printStackTrace();
	    	}
	    	
	    	return dto; 
	    }
	 
	 
	 
	 public List<MemberDTO> selectListPage(Map<String,Object> map) {
	        List<MemberDTO> board = new Vector<MemberDTO>();
	        String query = "SELECT * FROM (SELECT Tb.*, ROWNUM rNum FROM (SELECT * FROM t_member ORDER BY id DESC ) Tb )";
	        
	        System.out.println(query);  //�ֿܼ� ��ü ���� ��� 

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
	            System.out.println("�Խù� ��ȸ �� ���� �߻�");
	            e.printStackTrace();
	        }
	        return board;
	    }
	
	//Insert.jsp DB�� insert
	 public int insertWrite (MemberDTO dto) {
			int result = 0 ; 
			try {
				String query = "INSERT INTO t_member ( id ,pwd,name, email) VALUES ( ?, ?, ?, ?)"; 
				
			psmt = con.prepareStatement(query);  //PareparedStatement ��ü ���� 
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getEmail());
			
			result = psmt.executeUpdate();  //insert�� �����϶� result > 0   //DB �� ���� ���� 
			
			
			}catch (Exception e) {
				e.printStackTrace();
			}
				
			return result; 		// result : Insert ������ > 0 , ���н� : 0 
		}
	
	//delete
	 public int deletePost(String id) {
			int result = 0 ; 
			
			try {
				String query = "DELETE t_member WHERE id = ?"; 
				psmt = con.prepareStatement(query); 
				psmt.setString(1, id);
				
				result = psmt.executeUpdate();  //result > 0 ���� ����, result = 0 : ���� ���� 
				
			}catch (Exception e) {
				e.printStackTrace();
				System.out.println("delete �� ���� �߻� ");
			}
					
			return result; 				
		}
	
	 
	 
	// ��й�ȣ�� Ȯ�� �ϴ� �޼ҵ� (�Է��� ��� ��ȣ�� DataBase �� ���� ��ġ�ϴ��� Ȯ�� 
		public boolean confirmPassword(String pwd, String id) {
			boolean isCorr = true; 
			try {
					//COUNT(*) = 1 : ���ڵ尡 �����ϸ� : client���� �ѱ� pass , idx DB�� ���� 
					//COUNT(*) = 0 : ���ڵ尡 �������� ������ client���� �ѱ� ���� DB�� �������� �ʴ´�. 
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
				System.out.println("��й�ȣ Ȯ�ν� ���� �߻�");
			}		
			return isCorr; 
		}
	
}
