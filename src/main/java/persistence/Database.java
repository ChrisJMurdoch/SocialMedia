package persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.postgresql.Driver;

public class Database {
	
	private static Connection connection;
	
	public static void connect() {
		
		// This fixes the JDBC driver-loading issue with Eclipse
		try {
			Class.forName(Driver.class.getName());
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
		
		System.out.println("Database connecting...");
		
		// Get secret information from environment
		String user = System.getenv("db_user");
		String pass = System.getenv("db_pass");
		
		// No credentials
		if (user==null||pass==null) {
			System.out.println("Please add db_user and db_pass to environment variables.");
			System.out.println("Database failed to connect.");
			return;
		}
		
		// Attempt connection
	    try {
	    	String url = "jdbc:postgresql://ec2-54-247-122-209.eu-west-1.compute.amazonaws.com:5432/d72if0hlnukikq?sslmode=require&user="+user+"&password="+pass;
	        connection = DriverManager.getConnection(url);
			System.out.println("Database connected.");
			
		} catch (SQLException e) {
			
			System.out.println("Database failed to connect.");
			e.printStackTrace();
		}
	}
	
	public static String getHash(String username) throws SQLException {
		return getFirst("SELECT hash FROM users WHERE username = '" + username + "'");
	}
	
	/* Will return the String value of the first column, first line */
	private static String getFirst(String query) throws SQLException {

		// Execute query
		Statement statement = connection.createStatement();
		ResultSet result = statement.executeQuery(query);
		
		// Extract value
		String value = null;
		if (result.next())
			value = result.getString(1);
		
		// Clean up
		result.close();
		statement.close();
		return value;
	}
}
