package dao;

import java.util.*;	
import java.sql.*;
import vo.*;
import util.*;

public class NoticeDao {
	
	
	// 관리자 : 수정을 위해 공지 한개의 정보를 가져오기
	// updateNoticeForm.jsp
	public Notice selectNoticeOne(Notice notice) {
		
		Notice resultNotice = null;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			// sql
			/*
			 *	SELECT notice_no noticeNo
			 *		, notice_memo noticeMemo
			 *		, createdate
			 *		, updatedate
			 *	FROM notice
			 *	WHERE notice_no = ?
			 * 
			 */
			String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate, updatedate FROM notice WHERE notice_no = ?";
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, notice.getNoticeNo());
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				resultNotice = new Notice();
				
				resultNotice.setNoticeNo(rs.getInt("noticeNo"));
				resultNotice.setNoticeMemo(rs.getString("noticeMemo"));
				resultNotice.setCreatedate(rs.getString("createdate"));
				resultNotice.setUpdatedate(rs.getString("updatedate"));
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbUtil.close(rs, stmt, conn);
		}
		
		return resultNotice;
		
	}
	
	// 추가 메서드
	public int insertNotice(Notice notice) {
		
		int resultRow = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "INSERT INTO notice (notice_memo, updatedate, createdate) VALUES (?, NOW(), NOW())";
			
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, notice.getNoticeMemo());
			
			resultRow = stmt.executeUpdate();
			
			if(resultRow == 1) {
				System.out.println("공지 추가 완료");
			} else {
				System.out.println("공지 추가 실패");
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			dbUtil.close(null, stmt, conn);
		}
		
		return resultRow;
		
	}
	
	// 삭제 메서드
	public int deleteNotice(Notice notice) {
		
		int resultRow = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "DELETE FROM notice WHERE notice_no = ?";
			
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, notice.getNoticeNo());
			
			resultRow = stmt.executeUpdate();
			
			if(resultRow == 1) {
				System.out.println("공지 삭제 완료");
			} else {
				System.out.println("공지 삭제 실패");
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			dbUtil.close(null, stmt, conn);
		}
		
		return resultRow;
	}
	
	
	
	
	// 수정 메서드
	public int updateNotice(Notice notice) {
		
		int resultRow = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "UPDATE notice SET notice_memo = ? WHERE notice_no = ?";
			
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, notice.getNoticeMemo());
			stmt.setInt(2, notice.getNoticeNo());
			
			resultRow = stmt.executeUpdate();
			
			if(resultRow == 1) {
				System.out.println("공지 수정 완료");
			} else {
				System.out.println("공지 수정 실패");
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			dbUtil.close(null, stmt, conn);
		}
		
		return resultRow;
		
	}
	
	
	
	// loginForm.jsp 공지 목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) {
		
		ArrayList<Notice> list = null;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			
			list = new ArrayList<Notice>();
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			/*
			 *	SELECT notice_no noticeNo
			 *		, notice_memo noticeMemo
			 *		, createdate 
			 *	FROM notice 
			 *	ORDER BY createdate DESC 
			 *	LIMIT ?, ?
			 */
			
			String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate FROM notice ORDER BY createdate DESC LIMIT ?, ?";
			
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			rs = stmt.executeQuery();
			while(rs.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rs.getInt("noticeNo"));
				n.setNoticeMemo(rs.getString("noticeMemo"));
				n.setCreatedate(rs.getString("createdate"));
				
				list.add(n);
				
			}

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 연결 종료
			dbUtil.close(rs, stmt, conn);
		}
		
		return list;
	}
	
	// 마지막 페이지를 구할려면 전체 row 구하는 메서드
	public int selectNoticeCount() {
		
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
			 * COUNT(notice_no) count
			 * FROM notice
			 * 
			 */
			String sql = "SELECT COUNT(notice_no) count FROM notice";
			
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
	
}
