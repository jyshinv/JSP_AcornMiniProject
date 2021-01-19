package test.users.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import test.users.dto.UsersDto;
import test.util.DbcpBean;

public class UsersDao {
	//static필드
	private static UsersDao dao;
	
	//생성자
	private UsersDao() {}
	
	//참조값을 리턴해주는 static메소드
	public static UsersDao getInstance() {
		if(dao==null) {
			dao=new UsersDao();
		}
		return dao;
	}
	
	//프로필 이미지 경로를 수정하는 메소드
	public boolean updateProfile(UsersDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 insert, update, delete문 구성
			String sql = "UPDATE mini_users SET profile=? WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩 할 내용이 있으면 바인딩 한다.
			pstmt.setString(1, dto.getProfile());
			pstmt.setString(2, dto.getId());
			flag = pstmt.executeUpdate(); //sql문 실행하고 변화된 row 갯수 리턴 받기 

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}

		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	//인자로 전달된 아이디가 DB에 존재하는지 여부를 리턴하는 메소드
	public boolean isExist(String id) {
		//아이디가 이미 존재하는지 여부를 담을 지역변수 선언하고 초기값 지정
		boolean isExist=false;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT * FROM mini_users WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			//?에서 바인딩 할게 있으면 여기서 바인딩 한다.
			pstmt.setString(1, id);
			//select문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서  ResultSet 으로 부터 data 추출
			//select된 row가 없다면 if문에 들어가지 않음 
			if (rs.next()) {
				//select된 row가 있다면 여기로 들어옴
				isExist=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		
		//아이디가 이미 존재하는지 여부를 리턴해준다. 
		return isExist;

	}
	
	//회원의 비밀번호를 수정하는 메소드
	public boolean updatePwd(UsersDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 insert, update, delete문 구성
			String sql = "UPDATE mini_users SET pwd=? WHERE id=? AND pwd=?";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩 할 내용이 있으면 바인딩 한다.
			pstmt.setString(1, dto.getNewPwd()); //새 비밀번호
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getPwd()); //구 비밀번호 
			flag = pstmt.executeUpdate(); //sql문 실행하고 변화된 row 갯수 리턴 받기 

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}

		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	//회원가입 정보를 수정반영하는 메소드
	public boolean update(UsersDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 insert, update, delete문 구성
			String sql = "UPDATE mini_users SET email=? WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩 할 내용이 있으면 바인딩 한다.
			pstmt.setString(1, dto.getEmail());
			pstmt.setString(2, dto.getId());
			flag = pstmt.executeUpdate(); //sql문 실행하고 변화된 row 갯수 리턴 받기 

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}

		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	//인자로 전달된 아이디에 해당하는 가입정보를 삭제하는 메소드
	public boolean delete(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 insert, update, delete문 구성
			String sql = "DELETE FROM mini_users WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩 할 내용이 있으면 바인딩 한다.
			pstmt.setString(1, id);
			flag = pstmt.executeUpdate(); //sql문 실행하고 변화된 row 갯수 리턴 받기 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}

		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	//인자로 전달된 아이디에 해당하는 가입정보를 리턴해주는 메소드
	public UsersDto getData(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//회언정보를 담을 UsersDto
		UsersDto dto=null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT pwd, email, profile, regdate FROM mini_users WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			//?에서 바인딩 할게 있으면 여기서 바인딩 한다.
			pstmt.setString(1, id);
			//select문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서  ResultSet 으로 부터 data 추출
			if (rs.next()) {
				dto=new UsersDto();
				dto.setId(id);
				dto.setPwd(rs.getString("pwd"));
				dto.setEmail(rs.getString("email"));
				dto.setProfile(rs.getString("profile"));
				dto.setRegdate(rs.getString("regdate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		
		return dto;

	}
	
	//인자로 전달된 정보가 유효한 정보인지 여부를 리턴하는 메소드
	public boolean isValid(UsersDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//아이디 비밀번호가 유효한 정보인지 여부를 담을 지역변수 만들고 초기값 부여 
		boolean isValid=false;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT id, pwd FROM mini_users WHERE id=? AND pwd=?";
			pstmt = conn.prepareStatement(sql);
			//?에서 바인딩 할게 있으면 여기서 바인딩 한다.
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPwd());
			//select문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서  ResultSet 으로 부터 data 추출
			if (rs.next()) { //만일 select된 row가 있다면
				//여기로 들어오면 맞는정보!
				//여기로 들어오지 않으면 맞지 않은 정보임!
				
				//유효한 정보이므로 isValid에 true를 대입한다. 
				isValid=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		//아이디가 유효한지 여부를 리턴해준다. 
		return isValid;

	}//end of isValid()
	
	//회원 정보를 저장하는 메소드
	public boolean insert(UsersDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 insert, update, delete 문 구성
			//users테이블에는 profile이 있는데 아무 값도 넣지 않으면 null이 들어간다. 
			String sql = "INSERT INTO mini_users"
					+ " (id, pwd, email, regdate)"
					+ " VALUES(?, ?, ?, SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 바인딩한다.
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getEmail());
			flag = pstmt.executeUpdate(); //sql 문 실행하고 변화된 row 갯수 리턴 받기
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}//end of insert()
	
}
