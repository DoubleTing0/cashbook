package dao;

import java.sql.*;	
import vo.*;
import util.*;

public class MemberDao {

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
		
		// Sql
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
	
	
	
	// 회원가입
	public int insertMember(Member paramMember) throws Exception {
		int resultRow = 0;
		
		
		
		
		
		
		return resultRow;
	}
	
	
	
	
	
	
	
	
	
	
	
}
