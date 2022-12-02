package dao;

import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.*;

public class CategoryDao {
	
	
	// 수정 : 수정폼(select)과 수정액션(update)으로 구성
	// admin -> updateCategoryAction.jsp
	public int updateCategory(Category category) {
		
		int resultRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "UPDATE category SET category_kind = ?, category_name = ?, updatedate = CURDATE() WHERE category_no = ?";
			
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
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			dbUtil.close(null, stmt, conn);
		}
		
		return resultRow;
	}
	
	// admin -> updateCategoryForm.jsp
	public Category selectCategoryOne(Category category) {
		
		Category resultCategory = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category WHERE category_no = ?";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, category.getCategoryNo());
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				resultCategory = new Category();
				resultCategory.setCategoryNo(rs.getInt("categoryNo"));
				resultCategory.setCategoryKind(rs.getString("categoryKind"));
				resultCategory.setCategoryName(rs.getString("categoryName"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			dbUtil.close(rs, stmt, conn);
		}
		
		return resultCategory;
		
	}
	
	// admin -> deleteCategory.jsp
	public int deleteCategory(Category category) {
		
		int resultRow = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			
			dbUtil = new DBUtil();
			
			conn = dbUtil.getConnection();
			String sql = "DELETE FROM category WHERE category_no = ?";
			
			stmt = conn.prepareStatement(sql);
			
			stmt.setInt(1, category.getCategoryNo());
			
			resultRow = stmt.executeUpdate();
			
			if(resultRow == 1) {
				System.out.println("카테고리 삭제 완료");
			} else {
				System.out.println("카테고리 삭제 실패");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			dbUtil.close(null, stmt, conn);
		}
		
		
		return resultRow;
	}
	
	
	// admin -> insertCategoryAction.jsp
	public int insertCategory(Category category) {
		
		int resultRow = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = null;
		
		try {
			
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "INSERT INTO category (category_kind, category_name, updatedate, createdate) VALUES (?, ?, CURDATE(), CURDATE())";
			
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, category.getCategoryKind());
			stmt.setString(2, category.getCategoryName());
			
			resultRow = stmt.executeUpdate();
			
			if(resultRow == 1) {
				System.out.println("카테고리 추가 완료");
			} else {
				System.out.println("카테고리 추가 실패");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbUtil.close(null, stmt, conn);
		}
		
		return resultRow;
	}
	
	
	// admin -> 카테고리관리 -> 카테고리목록
	public ArrayList<Category> selectCategoryListByAdmin() {
		
		ArrayList<Category> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			
			list = new ArrayList<Category>();
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			String sql = "SELECT"
					+ " category_no categoryNo"
					+ ", category_kind categoryKind"
					+ ", category_name categoryName"
					+ ", updatedate"
					+ ", createdate"
					+ " FROM category";
			
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
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 자원(jdbc api 자원) 반납
			dbUtil.close(rs, stmt, conn);
		}
	
		return list;
	}
	
	
	// cashDateList.jsp / 입력 폼 중 select 카테고리 출력
	public ArrayList<Category> selectCategoryList() {
		
		ArrayList<Category> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = null;
		
		try {
			
			list = new ArrayList<Category>();
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
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
			
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Category c = new Category();
				c.setCategoryNo(rs.getInt("categoryNo"));
				c.setCategoryKind(rs.getString("categoryKind"));
				c.setCategoryName(rs.getString("categoryName"));
				list.add(c);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// 종료
			dbUtil.close(rs, stmt, conn);
		}
		
		return list;
		
	}
	
}
