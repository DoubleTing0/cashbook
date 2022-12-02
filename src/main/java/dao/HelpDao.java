package dao;

import java.util.*;
import java.sql.*;
import vo.*;
import dao.*;
import util.*;

public class HelpDao {

	public int insertHelp(Help help) {
		
		int resultRow = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "INSERT INTO help ("
					+ "		help_memo"
					+ "		, member_id"
					+ "		, updatedate"
					+ "		, createdate"
					+ ") VALUES ("
					+ "		?"
					+ "		, ?"
					+ "		, NOW()"
					+ "		, NOW()"
					+ ")";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, help.getHelpMemo());
			stmt.setString(2, help.getMemberId());
			resultRow = stmt.executeUpdate();
			
			if(resultRow == 1) {
				System.out.println("문의 추가 완료");
			} else {
				System.out.println("문의 추가 실패");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원 반납
			dbUtil.close(null, stmt, conn);
		}
		
		return resultRow;
	}
	
	
	// helpList.jsp  help LEFT OUTER JOIN comment
	public ArrayList<HashMap<String, Object>> selectHelpList(Help help) {
		ArrayList<HashMap<String, Object>> list = null;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			
			list = new ArrayList<HashMap<String, Object>>();
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT h.help_no helpNo"
					+ ", h.help_memo helpMemo"
					+ ", h.createdate helpCreatedate"
					+ ", c.comment_memo commentMemo"
					+ ", c.createdate commentCreatedate"
					+ " FROM help h"
					+ " LEFT OUTER JOIN comment c"
					+ " ON h.help_no = c.help_no"
					+ " WHERE h.member_id = ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, help.getMemberId());
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, Object> hm = new HashMap<String, Object>();
				hm.put("helpNo", rs.getInt("helpNo"));
				hm.put("helpMemo", rs.getString("helpMemo"));
				hm.put("helpCreatedate", rs.getString("helpCreatedate"));
				hm.put("commentMemo", rs.getString("commentMemo"));
				hm.put("commentCreatedate", rs.getString("commentCreatedate"));
				
				list.add(hm);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원 반납
			dbUtil.close(rs, stmt, conn);
		}
		
		return list;
		
	}
	
	
	// 관리자 모드 / selectHelpList 오버로딩(매개변수가 다름)
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) {
		ArrayList<HashMap<String, Object>> list = null;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			
			list = new ArrayList<HashMap<String, Object>>();
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT h.help_no helpNo"
					+ ", h.member_id memberId"
					+ ", h.help_memo helpMemo"
					+ ", h.createdate helpCreatedate"
					+ ", c.comment_no commentNo"
					+ ", c.comment_memo commentMemo"
					+ ", c.createdate commentCreatedate"
					+ " FROM help h"
					+ " LEFT OUTER JOIN comment c"
					+ " ON h.help_no = c.help_no"
					+ " LIMIT ?, ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, Object> hm = new HashMap<String, Object>();
				hm.put("helpNo", rs.getInt("helpNo"));
				hm.put("memberId", rs.getString("memberId"));
				hm.put("helpMemo", rs.getString("helpMemo"));
				hm.put("helpCreatedate", rs.getString("helpCreatedate"));
				hm.put("commentNo", rs.getString("commentNo"));
				hm.put("commentMemo", rs.getString("commentMemo"));
				hm.put("commentCreatedate", rs.getString("commentCreatedate"));
				
				list.add(hm);
				
				
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원 반납
			dbUtil.close(rs, stmt, conn);
		}
		
		return list;
		
	}
	
	
	// helpListAll.jsp  // selectHelpCount
	public int selectHelpCount() {
		
		int count = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT COUNT(help_no) count FROM help";
			
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("count");
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원 반납
			dbUtil.close(rs, stmt, conn);
		}
		
		return count;
	}
	
	// helpList.jsp  // selectOne
	public Help selectHelpOne(Help help) {
		
		Help resultHelp = null;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT help_memo helpMemo FROM help WHERE help_no = ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, help.getHelpNo());
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				resultHelp = new Help();
				resultHelp.setHelpMemo(rs.getString("helpMemo"));
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원 반납
			dbUtil.close(rs, stmt, conn);
		}
		
		return resultHelp;
	}
	
	
	// helpList.jsp  / updateHelp
	public int updateHelp(Help help) {
		
		int resultRow = 0;

		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "UPDATE help SET help_memo = ?, updatedate = NOW() WHERE help_no = ?";
			
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, help.getHelpMemo());
			stmt.setInt(2, help.getHelpNo());
			
			resultRow = stmt.executeUpdate();
			
			if(resultRow == 1) {
				System.out.println("문의 수정 완료");
			} else {
				System.out.println("문의 수정 실패");
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원 반납
			dbUtil.close(null, stmt, conn);
		}
		
		return resultRow;
	}
	
	
	// deleteHelpAction.jsp  / deleteHelp
	public int deleteHelp(Help help) {
		
		int resultRow = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		

		try {
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "DELETE FROM help WHERE help_no = ?";
			
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, help.getHelpNo());
			
			resultRow = stmt.executeUpdate();
			
			if(resultRow == 1) {
				System.out.println("문의 삭제 완료");
			} else {
				System.out.println("문의 삭제 실패");
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원 반납
			dbUtil.close(null, stmt, conn);
		}
		
		return resultRow;
		
	}
	
}
