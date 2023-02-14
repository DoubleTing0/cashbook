package util;

import java.sql.*;	

public class DBUtil {
	
	// DB 연결하는 메서드
	public Connection getConnection() {
		
		String driver = "org.mariadb.jdbc.Driver";
//		String dbUrl = "jdbc:mariadb://52.78.152.251:3306/cashbook";
		String dbUrl = "jdbc:mariadb://localhost:3306/cashbook";
		String dbUser = "root";
		String dbPw = "java1234";
		
		Connection conn = null;
		
		try {
			
			// 드라이버 로딩
			Class.forName(driver);
			
			// DB 접속
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return conn;
		
	}
	
	// DB 연결 종료하는 메서드
	public void close(ResultSet rs, PreparedStatement stmt,Connection conn) {
		
		try {
			
			if(rs != null) {
				rs.close();
			}
			
			if(stmt != null) {
				stmt.close();
			}
			
			if(conn != null) {
				conn.close();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
}
