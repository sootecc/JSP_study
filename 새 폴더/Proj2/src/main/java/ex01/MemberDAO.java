package ex01;

import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;





public class MemberDAO extends DBConnPool{
		//DB Connection 객체를 상속하여 쓰면 중복 코드를 방지할 수 있다.
	
	public MemberDAO() {
		super();
	}
	
	//List.jsp 출력을 위한 select :출력 레코드가 많기 때문에 List<MemberDTO>
		//레코드 한 개를 DTO에 저장
		//DTO를 List : Vector(멀티쓰레드 지원), ArrayList(싱글쓰레드)
	
	public List<MemberDTO> listMember(){
		
		//List<MemberDTO>
		List<MemberDTO> listMember = new ArrayList<MemberDTO>(); 
		MemberDTO dto = new MemberDTO();
		
		String query = "select * from t_member";
		try {
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
				//rs는 DB에서 Select한 결과값을 저장하고 있다.
			//rs에 저장된 레코드 셋을 DTO에 저장 후 List에 ADD 해준다.
			
			while(rs.next()) {
				//rs의 값을 변수에 담은 후 DTO에 추가
				MemberDTO dto2 = new MemberDTO();
				
				String id = rs.getString(1);		//rs.getString("id"); 이렇게 해도 된다.
				String pwd = rs.getString("pwd");
				String name = rs.getString(3);
				String email = rs.getString("email");
				Date joinDate = rs.getDate("joinDate");
				
				//DTO에 setter 주입
				dto2.setId(id);
				dto2.setPwd(pwd);
				dto2.setName(name);
				dto2.setEmail(email);
				dto2.setJoinDate(joinDate);
				
				listMember.add(dto2);
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("t_member 테이블 select 중 오류 발생");
			
		}
		return listMember;
	}
	
	
	//Insert.jsp DB에 insert
	 public int addMember (MemberDTO dto) {
		 
		 int result = 0;
		 
		 String query = "INSERT INTO t_member ( id ,pwd,name, email) VALUES ( ?, ?, ?, ?)";
		 
		 //DTO에서 넘어오는 변수의 값들을 getter로 호출하여 변수에 할당
		 String id = dto.getId();
		 String pwd = dto.getPwd();
		 String name = dto.getName();
		 String email = dto.getEmail();
		 
		 
		 try {
			 
			//psmt 객체 생성
			psmt = con.prepareStatement(query);  //PareparedStatement 객체 생성 
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getEmail());
			
			result = psmt.executeUpdate();  //insert가 성공일때 result > 0   //DB 에 값을 저장 
			
			
			}catch (Exception e) {
				e.printStackTrace();
			}
		 	return result;
		}
	
	//delete
	 	//매개변수로 Primary Key 컬럼의 변수값을 받고
	 public int delMember(String id) {
		 
		 	int result = 0;
			String query = "DELETE t_member WHERE id = ?"; 

			try {
				psmt = con.prepareStatement(query); 
				psmt.setString(1, id);
				
				result = psmt.executeUpdate(); 
				
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
