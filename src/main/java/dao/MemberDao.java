package dao;

import java.sql.*;	
import vo.*;
import util.*;

public class MemberDao {

	// loginAction.jsp / 로그인 메서드
	public Member login(Member paramMember) throws Exception {
		
		Member resultMember = null;
		
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
		
		
		
		//	DB 접속을 위한 객체 생성
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// sql
		//	SELECT member_id memberId
		//		, member_name memberName
		//	FROM member
		//	WHERE member_id = ? AND member_pw = PASSWORD(?)
		String sql = "SELECT member_id memberId, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		
		// sql 실행할 객체 생성
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// sql ? 대입
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		
		
		// ResultSet 에 저장
		ResultSet rs = stmt.executeQuery();
		
		// Member 에 저장
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
		}
		
		
		rs.close();
		stmt.close();
		conn.close();
		
		
		return resultMember;
	}
	
	
	
	// insertMemberAction.jsp / 회원가입 메서드
	public int insertMember(Member paramMember) throws Exception {
		int resultRow = 0;
		

		//	DB 접속을 위한 객체 생성
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
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
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		stmt.setString(3, paramMember.getMemberName());
		
		// 실행 완료된 쿼리 개수 반환
		resultRow = stmt.executeUpdate();
		
		// 디버깅 코드
		if(resultRow == 1) {
			System.out.println("회원 가입 성공");
		}
		
		
		// 종료
		stmt.close();
		conn.close();
		
		
		
		return resultRow;
		
		
		
	}
	
	
	// updateMemberAction.jsp  /  내 정보 수정 메서드
	public int updateMember(Member paramMember) throws Exception {
		int resultRow = 0;
		
		//	DB 접속을 위한 객체 생성
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// sql
		/*
		 *	UPDATE member 
		 *	SET member_name = ? 
		 */
		String sql = "UPDATE member SET member_name = ? WHERE member_id = ?";
		
		// sql 실행할 객체 생성
		PreparedStatement stmt = conn.prepareStatement(sql);
		
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
		
		
		// 종료
		stmt.close();
		conn.close();
		
		
		return resultRow;
	}
	
	
	// updatePwAcion.jsp  /  비밀번호 변경 메서드
	public int updatePw(Member paramMember, String paramMemberNewPw) throws Exception {
		int resultRow = 0;
		
		// DB 접속을 위한 객체 생성
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// sql
		/*
		 *	UPDATE member
		 * 	SET member_pw = PASSWORD(?)
		 * 	WHERE member_id = ? AND member_pw = PASSWORD(?) 
		 *  		 
		 * */
		// 조건 : 아이디와 비밀번호가 일치하고 / 새로운 비밀번호가 현재비밀번호와 다를 때 
		String sql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ? AND member_pw = PASSWORD(?) AND member_pw != PASSWORD(?)";
		
		// sql 실행할 객체 생성
		PreparedStatement stmt = conn.prepareStatement(sql);
		
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
		
		// 종료
		stmt.close();
		conn.close();
		
		
		return resultRow;
		
		
	}
	
	// deleteMemberAction.jsp  /  회원 탈퇴 메서드
	public boolean deleteMember(Member paramMember) throws Exception {
		int resultRow = 0;
		// DB 접속을 위한 객체 생성
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// sql
		/*
		 * 	DELETE
		 * 	FROM member
		 * 	WHERE member_id = ? AND member_pw = ?
		 */
		String sql = "DELETE FROM member WHERE member_id = ? AND member_pw = ?";
		
		// sql 실행할 객체 생성
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// sql ? 대입
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		
		// 쿼리 실행 후 완료된 쿼리 개수 반환
		resultRow = stmt.executeUpdate();
		
		// 종료
		stmt.close();
		conn.close();
		
		// 디버깅 
		if(resultRow == 1) {
			System.out.println("회원 탈퇴 완료");
			return true;
		} else {
			System.out.println("회원 탈퇴 실패");
			return false;
			
		}
		
		
		
		
	}
	
	
	
	
	
	
}
