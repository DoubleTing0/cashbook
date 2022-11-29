package dao;

import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.*;

public class CategoryDao {
	
	
	// 수정 : 수정폼(select)과 수정액션(update)으로 구성
	// admin -> updateCategoryAction.jsp
	public int updateCategory(Category category) throws Exception {
		
		int resultRow = 0;
		
		String sql = "UPDATE category SET category_kind = ?, category_name = ?, updatedate = CURDATE() WHERE category_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryKind());
		stmt.setString(2, category.getCategoryName());
		stmt.setInt(3, category.getCategoryNo());
		
		resultRow = stmt.executeUpdate();
		
		if(resultRow == 1) {
			System.out.println("카테고리 수정 완료");
		} else {
			System.out.println("카테고리 수정 실패");
			
		}
		
		// 자원 반환
		dbUtil.close(null, stmt, conn);
		
		return resultRow;
	}
	
	// admin -> updateCategoryForm.jsp
	public Category selectCategoryOne(Category category) throws Exception {
		
		Category resultCategory = null;
		
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category WHERE category_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, category.getCategoryNo());

		rs = stmt.executeQuery();
		
		if(rs.next()) {
			resultCategory = new Category();
			resultCategory.setCategoryNo(rs.getInt("categoryNo"));
			resultCategory.setCategoryKind(rs.getString("categoryKind"));
			resultCategory.setCategoryName(rs.getString("categoryName"));
			
		}
		
		// 자원 반환
		dbUtil.close(rs, stmt, conn);
		
		
		return resultCategory;
		
	}
	
	// admin -> deleteCategory.jsp
	public int deleteCategory(Category category) throws Exception {
		
		int resultRow = 0;
		String sql = "DELETE FROM category WHERE category_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, category.getCategoryNo());
		
		resultRow = stmt.executeUpdate();
		
		if(resultRow == 1) {
			System.out.println("카테고리 삭제 완료");
		} else {
			System.out.println("카테고리 삭제 실패");
		}
		
		// 자원 반환
		dbUtil.close(null, stmt, conn);
		
		return resultRow;
	}
	
	
	// admin -> insertCategoryAction.jsp
	public int insertCategory(Category category) throws Exception {
		
		int resultRow = 0;
		
		String sql = "INSERT INTO category (category_kind, category_name, updatedate, createdate) VALUES (?, ?, CURDATE(), CURDATE())";
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, category.getCategoryKind());
		stmt.setString(2, category.getCategoryName());
		
		resultRow = stmt.executeUpdate();
		
		if(resultRow == 1) {
			System.out.println("카테고리 추가 완료");
		} else {
			System.out.println("카테고리 추가 실패");
		}
		
		
				
		dbUtil.close(null, stmt, conn);
	
		
		
		return resultRow;
	}
	
	
	// admin -> 카테고리관리 -> 카테고리목록
	public ArrayList<Category> selectCategoryListByAdmin() throws Exception {
		ArrayList<Category> list = null;
		list = new ArrayList<Category>();
		
		String sql = "SELECT"
					+ " category_no categoryNo"
					+ ", category_kind categoryKind"
					+ ", category_name categoryName"
					+ ", updatedate"
					+ ", createdate"
					+ " FROM category";
		
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		dbUtil = new DBUtil();
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setUpdatedate(rs.getString("updatedate"));
			c.setCreatedate(rs.getString("createdate"));
			
			list.add(c);
		}
		
		
		
		// 자원(jdbc api 자원) 반납
		dbUtil.close(rs, stmt, conn);
		
		return list;
	}
	
	
	// cashDateList.jsp / 입력 폼 중 select 카테고리 출력
	public ArrayList<Category> selectCategoryList() throws Exception {
		
		ArrayList<Category> list = new ArrayList<Category>();
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = dbUtil.getConnection();
		
		
		
		/*
		 SELECT category_no categoryNo
		 	, category_kind categoryKind
		 	, category_name categoryName
		 FROM category
		 ORDER BY category_no
		 */
		
		String sql = "SELECT category_no categoryNo"
				+ "	, category_kind categoryKind"
				+ "	, category_name categoryName"
				+ " FROM category"
				+ " ORDER BY category_no";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			list.add(c);
		}
		
		
		
		// 종료
		rs.close();
		stmt.close();
		conn.close();
		
		
		return list;
		
	}
	
}
