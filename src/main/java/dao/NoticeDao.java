package dao;

import java.util.*;
import java.sql.*;
import vo.*;
import util.*;

public class NoticeDao {

	// loginForm.jsp 공지 목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		/*
		 *	SELECT notice_no noticeNo
		 *		, notice_memo noticeMemo
		 *		, createdate 
		 *	FROM notice 
		 *	ORDER BY createdate DESC 
		 *	LIMIT ?, ?
		 */
		
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate FROM notice ORDER BY createdate DESC LIMIT ?, ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			
			list.add(n);
			
		}
		
		return list;
	}
	
	// 마지막 페이지를 구할려면 전체 row 구하는 메서드
	public int noticeCount() throws Exception {
		int count = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		//sql
		/*
		 * SELECT
		 * COUNT(notice_no) count
		 * FROM notice
		 * 
		 */
		String sql = "SELECT COUNT(notice_no) count FROM notice";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			count = rs.getInt("count");
		}
		
		
		return count;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
