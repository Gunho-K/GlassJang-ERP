package db_transaction;

import java.sql.*;

public class ConnectionPool {
	public static Connection getConnection() {
		try {
			String dbURL = "jdbc:mysql://121.172.132.48:3306/glassjang?autoReconnect=true";
			String dbID = "java";
			String dbPassword = "java";
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
}
