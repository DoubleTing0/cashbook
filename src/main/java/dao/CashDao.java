package dao;

import java.sql.*;		
import java.util.*;
import util.*;
import vo.*;

public class CashDao {
	
	// 지난 달 수입/지출 항목 내역
	/*
			 * SELECT t2.*
		FROM (SELECT cashNo
				, memberId
				, cashDate
				, categoryNo
				, categoryKind
				, categoryName
				, if(categoryKind = '수입', cashPrice, NULL) importCash
				, if(categoryKind = '지출', cashPrice, NULL) exportCash
			FROM (SELECT cs.cash_no cashNo
						, cs.member_id memberId
						, cs.cash_date cashDate
						, cs.cash_price cashPrice
						, cs.cash_memo cashMemo
						, cg.category_no categoryNo
						, cg.category_kind categoryKind
						, cg.category_name categoryName
					FROM cash cs
						INNER JOIN category cg
						ON cs.category_no = cg.category_no) t) t2
		WHERE t2.memberId = 'goodee'
		GROUP BY t2.categoryName, MONTH(t2.cashDate)
		ORDER BY t2.categoryNO ASC, t2.cashDate ASC;
		 
	 */
	
	
	
	
	// 연도별 수입/지출
	public ArrayList<HashMap<String, Object>> selectCashYear(String memberId) {
		ArrayList<HashMap<String, Object>> list = null;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			
			list =new ArrayList<HashMap<String, Object>>();
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT YEAR(t2.cashDate) year"
					+ "			, COUNT(t2.importCash) cntImportCash"
					+ "			, IFNULL(SUM(importCash), 0) sumImportCash"
					+ "			, IFNULL(ROUND(AVG(importCash)), 0) avgImportCash"
					+ "			, COUNT(t2.exportCash) cntExportCash"
					+ "			, IFNULL(SUM(exportCash), 0) sumExportCash"
					+ "			, IFNULL(AVG(exportCasH), 0) avgExportCash"
					+ "		 FROM"
					+ "			 (SELECT cashNo"
					+ "					, memberId"
					+ "					, cashDate"
					+ "					, if(categoryKind = '수입', cashPrice, NULL) importCash"
					+ "					, if(categoryKind = '지출', cashPrice, NULL) exportCash"
					+ "				 FROM (SELECT cs.cash_no cashNo"
					+ "							, cs.cash_date cashDate"
					+ "							, cs.cash_price cashPrice"
					+ "							, cg.category_kind categoryKind"
					+ "							, cs.member_id memberId"
					+ "						 FROM cash cs"
					+ "							 INNER JOIN category cg"
					+ "							 ON cs.category_no = cg.category_no) t) t2"
					+ "		 WHERE t2.memberId = ?"
					+ "		 GROUP BY YEAR(t2.cashDate)"
					+ "		 ORDER BY YEAR(t2.cashDate) ASC";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("year", rs.getString("year"));
				map.put("cntImportCash", rs.getInt("cntImportCash"));
				map.put("sumImportCash", rs.getInt("sumImportCash"));
				map.put("avgImportCash", rs.getInt("avgImportCash"));
				map.put("cntExportCash", rs.getInt("cntExportCash"));
				map.put("sumExportCash", rs.getInt("sumExportCash"));
				map.put("avgExportCash", rs.getInt("avgExportCash"));
				
				list.add(map);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbUtil.close(rs, stmt, conn);
		}
		
		
		return list;
	}
	
	
	// 월별 수입/지출
	public ArrayList<HashMap<String, Object>> selectCashMonth(String memberId, int year) {
		ArrayList<HashMap<String, Object>> list = null;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			
			list =new ArrayList<HashMap<String, Object>>();
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT MONTH(t2.cashDate) month"
					+ "			, COUNT(t2.importCash) cntImportCash"
					+ "			, IFNULL(SUM(importCash), 0) sumImportCash"
					+ "			, IFNULL(ROUND(AVG(importCash)), 0) avgImportCash"
					+ "			, COUNT(t2.exportCash) cntExportCash"
					+ "			, IFNULL(SUM(exportCash), 0) sumExportCash"
					+ "			, IFNULL(ROUND(AVG(exportCasH)), 0) avgExportCash"
					+ "		 FROM"
					+ "			(SELECT cashNo"
					+ "					, memberId"
					+ "					, cashDate"
					+ "					, if(categoryKind = '수입', cashPrice, NULL) importCash"
					+ "					, if(categoryKind = '지출', cashPrice, NULL) exportCash"
					+ "			 FROM (SELECT cs.cash_no cashNo"
					+ "						, cs.cash_date cashDate"
					+ "						, cs.cash_price cashPrice"
					+ "						, cg.category_kind categoryKind"
					+ "						, cs.member_id memberId"
					+ "					 FROM cash cs"
					+ "						 INNER JOIN category cg"
					+ "						 ON cs.category_no = cg.category_no) t) t2"
					+ "		 WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ?"
					+ "		 GROUP BY MONTH(t2.cashDate)"
					+ "		 ORDER BY MONTH(t2.cashDate) ASC";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("month", rs.getString("month"));
				map.put("cntImportCash", rs.getInt("cntImportCash"));
				map.put("sumImportCash", rs.getInt("sumImportCash"));
				map.put("avgImportCash", rs.getInt("avgImportCash"));
				map.put("cntExportCash", rs.getInt("cntExportCash"));
				map.put("sumExportCash", rs.getInt("sumExportCash"));
				map.put("avgExportCash", rs.getInt("avgExportCash"));
				
				list.add(map);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbUtil.close(rs, stmt, conn);
		}
		
		
		return list;
	}
	
	// 연도 최대/최소
	public HashMap<String, Object> selectMinMaxYear() {
		
		HashMap<String, Object> map = null;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT MIN(YEAR(cash_date)) minYear"
					+ "			, MAX(YEAR(cash_date)) maxYear"
					+ "		 FROM cash";
			
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				
				map = new HashMap<String, Object>();
				map.put("minYear", rs.getInt("minYear"));
				map.put("maxYear", rs.getInt("maxYear"));
				
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbUtil.close(rs, stmt, conn);
		}	
		
		
		
		
		return map;
				
	}
		
		
	
	
	
	// cashDateList.jsp / 선택한 날 cash목록 출력 메서드
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) {
		
		ArrayList<HashMap<String, Object>> list = null; 
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		try {
			
			list = new ArrayList<HashMap<String, Object>>();
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
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
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2,  year);
			stmt.setInt(3,  month);
			stmt.setInt(4,  date);
			
			rs = stmt.executeQuery();
			while(rs.next()) {
				
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("cashNo", rs.getInt("cashNo"));
				m.put("cashPrice", rs.getLong("cashPrice"));
				m.put("cashMemo", rs.getString("cashMemo"));
				m.put("categoryKind", rs.getString("categoryKind"));
				m.put("categoryName", rs.getString("categoryName"));
				list.add(m);
				
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbUtil.close(rs, stmt, conn);
		}
		
		return list;
		
	}
	
	
	// cashList.jsp / 선택한 달 cash 목록 출력
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) {
		
		ArrayList<HashMap<String, Object>> list = null; 
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			
			dbUtil = new DBUtil();
			
			list = new ArrayList<HashMap<String, Object>>();
			
			conn = dbUtil.getConnection();
			
			
			String sql = "SELECT c.cash_date cashDate"
					+ "			, c.cash_price cashPrice"
					+ "			, ct.category_kind categoryKind"
					+ "			, ct.category_name categoryName"
					+ "		FROM cash c INNER JOIN category ct"
					+ "		ON c.category_no = ct.category_no"
					+ "		WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?"
					+ "		ORDER BY cash_date ASC, ct.category_kind ASC";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2,  year);
			stmt.setInt(3,  month);
			
			
			rs = stmt.executeQuery();
			while(rs.next()) {
				
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("cashDate", rs.getString("cashDate"));
				m.put("cashPrice", rs.getLong("cashPrice"));
				m.put("categoryKind", rs.getString("categoryKind"));
				m.put("categoryName", rs.getString("categoryName"));
				list.add(m);
				
				
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbUtil.close(rs, stmt, conn);
		}
		
		return list;
		
	}
	
	
	// insertCashAction.jsp  / cash 추가 메서드
	public int insertCash(Member paramMember, Cash paramCash) {
		
		int resultRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			
			// DB 접속
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
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
			
			// 쿼리 실행
			stmt = conn.prepareStatement(sql);
			
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
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbUtil.close(null, stmt, conn);
		}
		
		return resultRow;
		
	}
	
	// deleteCashAction.jsp / cash 삭제 메서드
	public int deleteCash(Member paramMember, int paramCashNo) {
		
		int resultRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			
			// DB 접속
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			// sql
			/*
			 *	DELETE
			 *	FROM cash
			 *	WHERE cash_no = ? AND member_id = ?
			 */
			String sql = "DELETE FROM cash WHERE cash_no = ? AND member_id = ?";
			
			// 쿼리 실행
			stmt = conn.prepareStatement(sql);
			
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
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbUtil.close(null, stmt, conn);
		}
		
		
		return resultRow;
		
		
	}
	
	// updateCashFrom.jsp / 한개의 cash 정보만 출력
	public Cash selectCashOne(int paramCashNo) {
		
		Cash resultCash = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			
			// DB 접속
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			//sql
			/*
			 *	SELECT ct.category_no categoryNo
			 *		, ct.category_kind categoryKind
			 *		, ct.category_name categoryName
			 *		, c.cash_date cashDate
			 *		, c.cash_price cashPrice
			 *		, c.cash_memo cashMemo
			 *	FROM cash c
			 *	INNER JOIN category ct
			 *	ON c.category_id = ct.category_id
			 *	WHERE c.cash_id = ?
			 */
			String sql = "SELECT category_no categoryNo"
					+ "	, cash_date cashDate"
					+ "	, cash_price cashPrice"
					+ "	, cash_memo cashMemo"
					+ "	FROM cash "
					+ "	WHERE cash_no = ?";
			
			// 쿼리 실행
			stmt = conn.prepareStatement(sql);
			
			// sql ? 대입
			stmt.setInt(1, paramCashNo);
			
			// ResultSet 에 저장
			rs = stmt.executeQuery();
			
			// Cash 객체에 저장
			if(rs.next()) {
				resultCash = new Cash();
				resultCash.setCategoryNo(rs.getInt("categoryNo"));
				resultCash.setCashDate(rs.getString("cashDate"));
				resultCash.setCashPrice(rs.getLong("cashPrice"));
				resultCash.setCashMemo(rs.getString("cashMemo"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbUtil.close(rs, stmt, conn);
		}
		
		return resultCash;
	}

	// updateCashAction.jsp  // cash update 메서드 
	public int updateCash(Cash paramCash) {
		
		int resultRow = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			
			// DB 접속
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			
			// sql
			/*
			 *	UPDATE cash
			 *	SET category_no = ?
			 *		, cash_price = ?
			 *		, cash_memo = ?
			 *	WHERE cash_no = ?
			 */
			String sql = "UPDATE cash SET category_no = ?, cash_price = ?, cash_memo = ? WHERE cash_no = ?";
			
			// 쿼리 실행
			stmt = conn.prepareStatement(sql);
			
			// sql ? 대입
			stmt.setInt(1, paramCash.getCategoryNo());
			stmt.setLong(2, paramCash.getCashPrice());
			stmt.setString(3, paramCash.getCashMemo());
			stmt.setInt(4, paramCash.getCashNo());
			
			// 쿼리 실행 후 완료된 쿼리 개수 반환
			resultRow = stmt.executeUpdate();
			
			if(resultRow == 1) {
				System.out.println("cash 수정 완료");
			} else {
				System.out.println("cash 수정 실패");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbUtil.close(null, stmt, conn);
		}
		
		return resultRow;
		
	}
	
}
