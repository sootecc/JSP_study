package ex01;

import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;





public class MemberDAO extends DBConnPool{
		//DB Connection ��ü�� ����Ͽ� ���� �ߺ� �ڵ带 ������ �� �ִ�.
	
	public MemberDAO() {
		super();
	}
	
	//List.jsp ����� ���� select :��� ���ڵ尡 ���� ������ List<MemberDTO>
		//���ڵ� �� ���� DTO�� ����
		//DTO�� List : Vector(��Ƽ������ ����), ArrayList(�̱۾�����)
	
	public List<MemberDTO> listMember(){
		
		//List<MemberDTO>
		List<MemberDTO> listMember = new ArrayList<MemberDTO>(); 
		MemberDTO dto = new MemberDTO();
		
		String query = "select * from t_member";
		try {
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
				//rs�� DB���� Select�� ������� �����ϰ� �ִ�.
			//rs�� ����� ���ڵ� ���� DTO�� ���� �� List�� ADD ���ش�.
			
			while(rs.next()) {
				//rs�� ���� ������ ���� �� DTO�� �߰�
				MemberDTO dto2 = new MemberDTO();
				
				String id = rs.getString(1);		//rs.getString("id"); �̷��� �ص� �ȴ�.
				String pwd = rs.getString("pwd");
				String name = rs.getString(3);
				String email = rs.getString("email");
				Date joinDate = rs.getDate("joinDate");
				
				//DTO�� setter ����
				dto2.setId(id);
				dto2.setPwd(pwd);
				dto2.setName(name);
				dto2.setEmail(email);
				dto2.setJoinDate(joinDate);
				
				listMember.add(dto2);
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("t_member ���̺� select �� ���� �߻�");
			
		}
		return listMember;
	}
	
	
	//Insert.jsp DB�� insert
	 public int addMember (MemberDTO dto) {
		 
		 int result = 0;
		 
		 String query = "INSERT INTO t_member ( id ,pwd,name, email) VALUES ( ?, ?, ?, ?)";
		 
		 //DTO���� �Ѿ���� ������ ������ getter�� ȣ���Ͽ� ������ �Ҵ�
		 String id = dto.getId();
		 String pwd = dto.getPwd();
		 String name = dto.getName();
		 String email = dto.getEmail();
		 
		 
		 try {
			 
			//psmt ��ü ����
			psmt = con.prepareStatement(query);  //PareparedStatement ��ü ���� 
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getEmail());
			
			result = psmt.executeUpdate();  //insert�� �����϶� result > 0   //DB �� ���� ���� 
			
			
			}catch (Exception e) {
				e.printStackTrace();
			}
		 	return result;
		}
	
	//delete
	 	//�Ű������� Primary Key �÷��� �������� �ް�
	 public int delMember(String id) {
		 
		 	int result = 0;
			String query = "DELETE t_member WHERE id = ?"; 

			try {
				psmt = con.prepareStatement(query); 
				psmt.setString(1, id);
				
				result = psmt.executeUpdate(); 
				
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
