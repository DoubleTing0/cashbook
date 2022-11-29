package dao;

import java.sql.*;
import java.util.*;
import vo.*;
import dao.*;
import util.DBUtil;


public class CommentDao {
	
	// 입력 helpListAll.jsp / insertComment
	public int insertComment(Comment comment) throws Exception {
		
		int resultRow = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "INSERT INTO comment ("
				+ "		help_No"
				+ "		, comment_memo"
				+ "		, member_id"
				+ "		, updatedate"
				+ "		, createdate"
				+ ") VALUES ("
				+ "		?"
				+ "		, ?"
				+ "		, ?"
				+ "		, NOW()"
				+ "		, NOW()"
				+ ")";
		
		dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getHelpNo());
		stmt.setString(2, comment.getCommentMemo());
		stmt.setString(3, comment.getMemberId());
		resultRow = stmt.executeUpdate();
		
		if(resultRow == 1) {
			System.out.println("답변 추가 완료");
		} else {
			System.out.println("답변 추가 실패");
		}
		
		// DB 자원 반납
		dbUtil.close(rs, stmt, conn);
		
		return resultRow;
	}
	
	
	// updateCommentForm.jsp / 1개의 코멘트 selectCommentOne
	public Comment selectCommentOne(Comment comment) throws Exception {
		
		Comment resultComment = null;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT comment_memo commentMemo FROM comment WHERE comment_no = ?";
		
		dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, comment.getCommentNo());
		
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			resultComment = new Comment();
			resultComment.setCommentMemo(rs.getString("commentMemo"));
		}
		
		// DB 자원 반납
		dbUtil.close(rs, stmt, conn);
		
		
		return resultComment;
		
	}
	
	
	// 수정 updateCommentAction.jsp /  updateComment
	public int updateComment(Comment comment) throws Exception {
		
		int resultRow = 0;

		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "UPDATE comment SET comment_memo = ?, updatedate = NOW() WHERE comment_no = ?";
		
		dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, comment.getCommentMemo());
		stmt.setInt(2, comment.getCommentNo());
		
		resultRow = stmt.executeUpdate();
		
		if(resultRow == 1) {
			System.out.println("답변 수정 완료");
		} else {
			System.out.println("답변 수정 실패");
		}
		
		return resultRow;
	}
	
	// 삭제
	public int deleteComment(Comment comment) throws Exception {
		
		int resultRow = 0;
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "DELETE FROM comment WHERE comment_no = ?";
		
		dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, comment.getCommentNo());
		
		resultRow = stmt.executeUpdate();
		
		if(resultRow == 1) {
			System.out.println("답변 삭제 완료");
		} else {
			System.out.println("답변 삭제 실패");
		}
		
		return resultRow;
	}
	
	
	
}
