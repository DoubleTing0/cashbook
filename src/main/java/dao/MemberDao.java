package dao;

import java.sql.*;
import java.util.*;

import vo.*;
import util.*;

public class MemberDao {

	// 관리자 : 레벨 수정을 위해 한명의 정보를 가져오기
	// updateLevelForm.jsp
	public Member selectMemberOne(Member member) {
		
		Member resultMember = null;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			// sql
			/*
			 *	SELECT member_no memberNo
			 *		, member_id memberId
			 *		, member_level memberLevel
			 *		, member_name memberName
			 *	FROM member
			 *	WHERE member_id = ?
			 * 
			 */
			String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id = ?";
			
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, member.getMemberId());
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				resultMember = new Member();
				
				resultMember.setMemberNo(rs.getInt("memberNo"));
				resultMember.setMemberId(rs.getString("memberId"));
				resultMember.setMemberLevel(rs.getInt("memberLevel"));
				resultMember.setMemberName(rs.getString("memberName"));
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			dbUtil.close(rs, stmt, conn);
		}
		
		return resultMember;
	}
	
	// 관리자 멤버 강퇴
	public int deleteMemberByAdmin(Member member) {
		
		int resultRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;

		try {
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			// sql
			/*
			 * DELETE
			 * FROM member
			 * WHERE member_id = ?
			 * 
			 */
			String sql = "DELETE FROM member WHERE member_id = ?";
			
			
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, member.getMemberId());
			
			resultRow = stmt.executeUpdate();
			
			if(resultRow == 1) {
				System.out.println("강제 탈퇴 완료");
			} else {
				System.out.println("강제 탈퇴 실패");
				
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			dbUtil.close(null, stmt, conn);
		}
		
		return resultRow;
	}
		
	
	// 관리자 : 레벨수정
	public int updateMemberLevel(Member member) {
		
		int resultRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			// sql
			/*
			 * UPDATE member
			 * SET member_level = ?
			 * WHERE member_id = ?
			 * 
			 */
			String sql = "UPDATE member SET member_level = ? WHERE member_id = ?";
			
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, member.getMemberLevel());
			stmt.setString(2, member.getMemberId());
			
			resultRow = stmt.executeUpdate();
			
			if(resultRow == 1) {
				System.out.println("레벨 수정 완료");
			} else {
				System.out.println("레벨 수정 실패");
				
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbUtil.close(null, stmt, conn);
		}
		
		return resultRow;
	}
	
	// 관리자 : 멤버 수
	public int selectMemberCount() {
		
		int count = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			//sql
			/*
			 * SELECT
			 * COUNT(member_no) count
			 * FROM member
			 * 
			 */
			String sql = "SELECT COUNT(member_no) count FROM member";
			
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("count");
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 연결 종료
			dbUtil.close(rs, stmt, conn);
		}
		
		return count;
	}
	
	
	// loginAction.jsp / 로그인 메서드
	public Member login(Member paramMember) {
		
		//	DB를 연결하는 코드(명령들)가 Dao 메서드를 거의 공통으로 중복된다.
		//	중복되는 코드를 하나의 이름(메서드)으로 만들자.
		//	입력값과 반환값 결정해야 한다.(정해진 규칙, 공식은 없다.)
		//	여기서는 입력값 X, 반환값은 Connection 타입의 결과값이 남도록 한다.
		/*
		String driver = "org.mariadb.jdbc.Driver";
		String dbUrl = "jdbc:mariadb://localhost:3306/cashbook";
		String dbUser = "root";
		String dbPw = "java1234";
		
		// 드라이버 로딩
		Class.forName(driver);
		
		// DB 접속
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		*/
		
		
		Member resultMember = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			
			// DB 접속
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			// sql
			//	SELECT member_id memberId
			//		, member_name memberName
			//	FROM member
			//	WHERE member_id = ? AND member_pw = PASSWORD(?)
			String sql = "SELECT member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
			
			// sql 실행
			stmt = conn.prepareStatement(sql);
			
			// sql ? 대입
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			
			
			// ResultSet 에 저장
			rs = stmt.executeQuery();
			
			// Member 에 저장
			if(rs.next()) {
				resultMember = new Member();
				resultMember.setMemberId(rs.getString("memberId"));
				resultMember.setMemberLevel(rs.getInt("memberLevel"));
				resultMember.setMemberName(rs.getString("memberName"));
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 연결 종료
			dbUtil.close(rs, stmt, conn);
		}
		
		return resultMember;
	}
	
	
	// 회원가입 프로세스 1) id 중복 확인 2) 회원가입
	// 반환값 t : 이미 존재 , f : 사용가능(중복되지 않음)
	public boolean selectMemberIdCk(String paramMemberId) {
		
		boolean result = false;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			
			// DB 접속
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT member_id FROM member WHERE member_id = ?";
			
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, paramMemberId);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				result = true;
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 연결 종료
			dbUtil.close(rs, stmt, conn);
		}
		
		return result;
	}
	
	// insertMemberAction.jsp / 회원가입 메서드
	public int insertMember(Member paramMember) {
	
		int resultRow = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			
			//	DB 접속
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			/*
			 *	INSERT INTO member (
			 *		member_id
			 *		, member_pw
			 *		, member_name
			 *		, updatedate
			 *		, createdate
			 *	) VALUES (
			 *		?
			 *		, PASSWORD(?)
			 *		, ?
			 *		, CURDATE()
			 *		, CURDATE()
			 *	)
			 */
			String sql = "INSERT INTO member (member_id, member_pw, member_name, updatedate, createdate) VALUES (?, PASSWORD(?), ?, CURDATE(), CURDATE())";
			
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			stmt.setString(3, paramMember.getMemberName());
			
			// 실행 완료된 쿼리 개수 반환
			resultRow = stmt.executeUpdate();
			
			// 디버깅 코드
			if(resultRow == 1) {
				System.out.println("회원 가입 성공");
			} else {
				System.out.println("회원 가입 실패");
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 연결 종료
			dbUtil.close(null, stmt, conn);
		}
		
		return resultRow;
		
	}
	
	
	// updateMemberAction.jsp  /  내 정보 수정 메서드
	public int updateMember(Member paramMember) {
		
		int resultRow = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			
			//	DB 접속
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			// sql
			/*
			 *	UPDATE member 
			 *	SET member_name = ? 
			 */
			String sql = "UPDATE member SET member_name = ? WHERE member_id = ?";
			
			// sql 실행
			stmt = conn.prepareStatement(sql);
			
			// sql ? 대입
			stmt.setString(1, paramMember.getMemberName());
			stmt.setString(2, paramMember.getMemberId());
			
			// 쿼리 실행 후 완료된 쿼리 개수 반환
			resultRow = stmt.executeUpdate();
			
			// 디버깅
			if(resultRow == 1) {
				System.out.println("내 정보 수정 완료");
			} else {
				System.out.println("내 정보 수정 실패");
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 연결 종료
			dbUtil.close(null, stmt, conn);
		}
		
		return resultRow;
	}
	
	
	// updatePwAcion.jsp  /  비밀번호 변경 메서드
	public int updatePw(Member paramMember, String paramMemberNewPw) {
		
		int resultRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			
			// DB 접속을 위한 객체 생성
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			// sql
			/*
			 *	UPDATE member
			 * 	SET member_pw = PASSWORD(?)
			 * 	WHERE member_id = ? AND member_pw = PASSWORD(?) 
			 *  		 
			 * */
			// 조건 : 아이디와 비밀번호가 일치하고 / 새로운 비밀번호가 현재비밀번호와 다를 때 
			String sql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ? AND member_pw = PASSWORD(?) AND member_pw != PASSWORD(?)";
			
			// sql 실행
			stmt = conn.prepareStatement(sql);
			
			// sql ? 대입
			stmt.setString(1, paramMemberNewPw);
			stmt.setString(2, paramMember.getMemberId());
			stmt.setString(3, paramMember.getMemberPw());
			stmt.setString(4, paramMemberNewPw);
			
			// 쿼리 실행 후 완료된 쿼리 개수 반환
			resultRow = stmt.executeUpdate();
			
			// 디버깅
			if(resultRow == 1) {
				System.out.println("비밀번호 변경 완료");
			} else {
				System.out.println("비밀번호 변경 실패");
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 연결 종료
			dbUtil.close(null, stmt, conn);
		}
		
		return resultRow;

	}
	
	
	
	
	
	// deleteMemberAction.jsp  /  회원 탈퇴 메서드
	// true : 회원 탈퇴 완료 / false : 회원 탈퇴 실패
	public boolean deleteMember(Member paramMember) {

		boolean result = false;
		int resultRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			
			// DB 접속을 위한 객체 생성
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			// sql
			/*
			 * 	DELETE
			 * 	FROM member
			 * 	WHERE member_id = ? AND member_pw = ?
			 */
			String sql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
			
			// sql 실행할 객체 생성
			stmt = conn.prepareStatement(sql);
			
			// sql ? 대입
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			
			// 쿼리 실행 후 완료된 쿼리 개수 반환
			resultRow = stmt.executeUpdate();
			
			if(resultRow == 1) {
				System.out.println("회원 탈퇴 완료");
				result = true;
			} else {
				System.out.println("회원 탈퇴 실패");
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 종료
			dbUtil.close(null, stmt, conn);
		}
		
		return result;
		
	}
	
	// loginForm.jsp , memberList.jsp 멤버 목록
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) {
		
		ArrayList<Member> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		
		try {
			
			list = new ArrayList<Member>();
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			/*
			 *	SELECT member_id memberId
			 *		, member_level memberLevel
			 *		, member_name memberName
			 *		, createdate 
			 *	FROM member 
			 *	ORDER BY createdate DESC 
			 *	LIMIT ?, ?
			 */
			
			String sql = "SELECT member_no memberNo"
					+ "		, member_id memberId"
					+ "		, member_level memberLevel"
					+ "		, member_name memberName"
					+ "		, updatedate"
					+ "		, createdate"
					+ "	FROM member"
					+ "	ORDER BY createdate DESC"
					+ ", member_no DESC"
					+ "	LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			rs = stmt.executeQuery();
			while(rs.next()) {
				Member m = new Member();
				m.setMemberNo(rs.getInt("memberNo"));
				m.setMemberId(rs.getString("memberId"));
				m.setMemberLevel(rs.getInt("memberLevel"));
				m.setMemberName(rs.getString("memberName"));
				m.setUpdatedate(rs.getString("updatedate"));
				m.setCreatedate(rs.getString("createdate"));
				
				list.add(m);
				
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 연결 종료
			dbUtil.close(rs, stmt, conn);
		}
		
		return list;
	}
	
	
}
