package dao;

import java.sql.*;	
import java.util.*;
import util.*;

public class CashDao {

	// cashDateList.jsp / 선택한 날 cash목록 출력 메서드
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = dbUtil.getConnection();
		
		
	
		
		String sql = "SELECT c.cash_price cashPrice"
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
	
	
	
}
