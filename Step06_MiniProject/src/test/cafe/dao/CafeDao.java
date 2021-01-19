package test.cafe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.cafe.dto.CafeDto;
import test.util.DbcpBean;

public class CafeDao {

	private static CafeDao dao;
	private CafeDao() {};
	public static CafeDao getInstance() {
		if(dao==null) {
			dao=new CafeDao();
		}
		return dao;
	}
	
	//글 조회수를 올리는 메소드
	public boolean addViewCount(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 insert, update, delete문 구성
			String sql = "UPDATE mini_board_cafe SET viewCount=viewCount+1 WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩 할 내용이 있으면 바인딩 한다.
			pstmt.setInt(1, num);
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
	
	//인자로 전달되는 글 내용을 수정반영하는 메소드
	public boolean update(CafeDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 insert, update, delete문 구성
			String sql = "UPDATE mini_board_cafe SET title=?,content=? WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩 할 내용이 있으면 바인딩 한다.
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNum());
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
	
	//인자로 전달되는 글 번호를 이용해서 삭제하는 메소드
	public boolean delete(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 insert, update, delete문 구성
			String sql = "DELETE FROM mini_board_cafe WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩 할 내용이 있으면 바인딩 한다.
			pstmt.setInt(1, num);
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
	
	//인자로 전달되는 글 번호에 해당하는 글정보를 리턴하는 메소드
	public CafeDto getData(int num) {
		CafeDto dto=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT writer, title, content, viewCount, regdate "
					+ "FROM mini_board_cafe "
					+ "WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			//?에서 바인딩 할게 있으면 여기서 바인딩 한다.
			pstmt.setInt(1, num);
			//select문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서  ResultSet 으로 부터 data 추출
			if (rs.next()) {
				dto=new CafeDto();
				dto.setNum(num);
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setViewCount(rs.getInt("viewCount"));
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
	
	//글 하나의 정보를 추가하는 메소드
	public boolean insert(CafeDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 insert, update, delete문 구성
			//새로운 글이 추가되면 조회수는 0이므로 0을 insert한다. 
			String sql = "INSERT INTO mini_board_cafe(num, writer, title, content, viewCount, regdate)"
					+ " VALUES(mini_board_cafe_seq.NEXTVAL,?,?,?,0,SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩 할 내용이 있으면 바인딩 한다.
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
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
	
	//글 전체 목록을 리턴하는 메소드 
	public List<CafeDto> getList(CafeDto dto){
		//글 목록을 담을 ArrayList 객체 생성
		List<CafeDto> list=new ArrayList<CafeDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT *" + 
					"		FROM" + 
					"			(SELECT result1.*, ROWNUM AS rnum" + 
					"			FROM" + 
					"				(SELECT num, writer, title, viewCount, regdate" + 
					"				FROM mini_board_cafe" + 
					"				ORDER BY num DESC) result1)" + 
					"		WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			//?에서 바인딩 할게 있으면 여기서 바인딩 한다.
			pstmt.setInt(1, dto.getStartRowNum());
			pstmt.setInt(2, dto.getEndRowNum());
			//select문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서  ResultSet 으로 부터 data 추출
			while (rs.next()) {
				CafeDto tmp=new CafeDto();
				tmp.setNum(rs.getInt("num"));
				tmp.setWriter(rs.getString("writer"));
				tmp.setTitle(rs.getString("title"));
				tmp.setViewCount(rs.getInt("viewCount"));
				tmp.setRegdate(rs.getString("regdate"));
				list.add(tmp);
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
			} catch (Exception e) {}
		}

		return list;
	}//end of getList()
	
	
	//전체 row의 개수를 리턴하는 메소드 
	public int getCount() {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM),0) AS num FROM mini_board_cafe";
			pstmt = conn.prepareStatement(sql);
			//?에서 바인딩 할게 있으면 여기서 바인딩 한다.

			//select문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서  ResultSet 으로 부터 data 추출
			if (rs.next()) {
				count=rs.getInt("num");	
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

		return count;
	}
}
