package dao;

import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.*;

public class CategoryDao {

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
