package persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
	
	private static Connection connection;
	
	public static void connect() {
		
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
}
