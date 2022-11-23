package dao;

import java.sql.*;		
import java.util.*;
import util.*;
import vo.*;

public class CashDao {

	// cashDateList.jsp / 선택한 날 cash목록 출력 메서드
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = dbUtil.getConnection();
		
		
	
		
		String sql = "SELECT c.cash_no cashNo"
				+ "			, c.cash_price cashPrice"
				+ "			, c.cash_Memo cashMemo"
				+ "			, ct.category_kind categoryKind"
				+ "			, ct.category_name categoryName"
				+ "		FROM cash c INNER JOIN category ct"
				+ "		ON c.category_no = ct.category_no"
				+ "		WHERE c.member_id = ?"
				+ "		AND YEAR(c.cash_date) = ?"
				+ "		AND MONTH(c.cash_date) = ?"
				+ "		AND DAY(c.cash_date) = ?"			
				+ "		ORDER BY cash_date ASC, ct.category_kind ASC";
		
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2,  year);
		stmt.setInt(3,  month);
		stmt.setInt(4,  date);
		
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("cashMemo", rs.getString("cashMemo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
			
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
		
		
		
	}
	
	
	// cashList.jsp / 선택한 달 cash 목록 출력
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = dbUtil.getConnection();
		
		
	
		
		String sql = "SELECT c.cash_date cashDate"
				+ "			, c.cash_price cashPrice"
				+ "			, ct.category_kind categoryKind"
				+ "			, ct.category_name categoryName"
				+ "		FROM cash c INNER JOIN category ct"
				+ "		ON c.category_no = ct.category_no"
				+ "		WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?"
				+ "		ORDER BY cash_date ASC, ct.category_kind ASC";
		
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2,  year);
		stmt.setInt(3,  month);
		
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
			
			
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
		
	}
	
	
	// insertCashAction.jsp  / cash 추가 메서드
	public int insertCash(Member paramMember, Cash paramCash) throws Exception {
		int resultRow = 0;
		
		// DB 접속을 위한 객체 생성
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// sql
		/*
		 * 	INSERT INTO cash (
		 * 		category_no
		 * 		, member_id
		 * 		, cash_date 
		 * 		, cash_price
		 * 		, cash_Memo
		 * 		, updatedate
		 * 		, createdate
		 * 	) VALUES (
		 * 		?
		 * 		, ?
		 * 		, ?
		 * 		, ?
		 * 		, CURDATE()
		 * 		, CURDATE()
		 *	)
		 * 	
		 */
		
		String sql = "INSERT INTO cash (category_no, member_id, cash_date, cash_price, cash_Memo, updatedate, createdate) VALUES (?, ?, ?, ?, ?, CURDATE(), CURDATE())";
		
		// sql 실행할 객체 생성
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// sql ? 대입
		stmt.setInt(1, paramCash.getCategoryNo());
		stmt.setString(2, paramMember.getMemberId());
		stmt.setString(3, paramCash.getCashDate());
		stmt.setLong(4, paramCash.getCashPrice());
		stmt.setString(5, paramCash.getCashMemo());
		
		// 쿼리 실행 완료 후 쿼리 갯수 반환
		resultRow = stmt.executeUpdate();
		
		if(resultRow == 1) {
			
			System.out.println("cash 추가 완료");
		} else {
			System.out.println("cash 추가 실패");
			
			
		}
		
		stmt.close();
		conn.close();
		
		
		return resultRow;
		
		
		
	}
	
	// deleteCashAction.jsp / cash 삭제 메서드
	public int deleteCash(Member paramMember, int paramCashNo) throws Exception {
		
		int resultRow = 0;
		
		// DB 접속을 위한 객체 생성
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// sql
		/*
		 *	DELETE
		 *	FROM cash
		 *	WHERE cash_no = ? AND member_id = ?
		 */
		String sql = "DELETE FROM cash WHERE cash_no = ? AND member_id = ?";
		
		// sql 실행할 객체 생성
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// sql ? 대입
		stmt.setInt(1, paramCashNo);
		stmt.setString(2, paramMember.getMemberId());
		
		// 쿼리 실행 후 완료된 쿼리 개수 반환
		resultRow = stmt.executeUpdate();
		
		if(resultRow == 1) {
			System.out.println("cash 삭제 완료");
		} else {
			
			System.out.println("cash 삭제 실패");
		}
		
		// 종료
		stmt.close();
		conn.close();
		
		return resultRow;
		
		
		
	}
	
	
	
	
}
