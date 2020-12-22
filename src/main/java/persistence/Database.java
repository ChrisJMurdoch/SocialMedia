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
		return get( "hash", "users", "username", username );
	}
	
	/** Execute query without return value */
	public static void execute(String query) throws SQLException {
		
		// Execute query
		Statement statement = connection.createStatement();
		ResultSet result = statement.executeQuery(query);
		
		// Clean up
		result.close();
		statement.close();
	}
	
	/** Check to see if value exists for given column */
	public static boolean exists(String table, String column, String value) throws SQLException {
		
		// Execute query
		Statement statement = connection.createStatement();
		ResultSet result = statement.executeQuery("SELECT * FROM " + table + " WHERE " + column + " = '" + value + "'");
		
		// Extract value
		boolean exists = result.next();
		
		// Clean up
		result.close();
		statement.close();
		return exists;
	}
	
	/** Will return the String value of the first column, first line */
	public static String get(String get, String table, String column, String value) throws SQLException {
		
		// Execute query
		Statement statement = connection.createStatement();
		ResultSet result = statement.executeQuery("SELECT " + get + " FROM " + table + " WHERE " + column + " = '" + value + "'");
		
		// Extract value
		String out = null;
		if (result.next())
			out = result.getString(1);
		
		// Clean up
		result.close();
		statement.close();
		return out;
	}
}
