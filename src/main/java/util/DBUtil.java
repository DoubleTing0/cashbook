package util;

import java.sql.*;

public class DBUtil {
	
	public Connection getConnection() throws Exception {
		
		String driver = "org.mariadb.jdbc.Driver";
		String dbUrl = "jdbc:mariadb://localhost:3306/cashbook";
		String dbUser = "root";
		String dbPw = "java1234";
		
		// 드라이버 로딩
		Class.forName(driver);
		
		// DB 접속
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		
		
		
		return conn;
		
	}
	
}
