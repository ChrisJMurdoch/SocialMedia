package persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;

import org.postgresql.Driver;

/** Direct interface to PostgreSQL database.  For most purposes, the Database class provides more user-friendly functions */
public class DatabaseDirect {
	
	private static Connection connection;
	
	public static void connect() {
		
		System.out.println("Database connecting...");
		
		// This fixes the JDBC driver-loading issue with Eclipse
		try {
			Class.forName(Driver.class.getName());
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		// Get secret information from environment
		String user = System.getenv("db_user");
		String pass = System.getenv("db_pass");
		
		// No credentials
		if (user==null || pass==null) {
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
	
	public static void disconnect() {
		
		try {
			
			System.out.println("Database disconnecting...");
			connection.close();
			System.out.println("Database disconnected.");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/** Execute command without return data */
	public static void execute(String command) {
		
		try {
			
			// Execute query
			Statement statement = connection.createStatement();
			statement.executeUpdate(command);
			
			// Clean up
			statement.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/** Execute command and return data as list of Strings */
	public static LinkedList<String[]> query(String query) {
		
		try {
			
			// Execute query
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(query);
			int columns = result.getMetaData().getColumnCount();
			
			// For every row
			LinkedList<String[]> list = new LinkedList<>();
			while (result.next()) {
				
				// For every column
				String[] array = new String[columns];
				for (int i=0; i<array.length; i++) {
					
					// Populate with column value
					array[i] = result.getString(i+1);
				}
				
				// Add row to list
				list.add(array);
			}
			
			// Clean up
			result.close();
			statement.close();
			return list;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
}
