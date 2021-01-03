package persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;

import org.postgresql.Driver;

public class Database {
	
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
	
	/* Utility method to return query data as a list of rows; each an array of columns */
	public static LinkedList<String[]> execute(String query) {
		
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
					array[i] = result.getString(i+1);
				}
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
	
	public static boolean exists(String table, String column, String value) {
		LinkedList<String[]> result = execute("SELECT * FROM " + table + " WHERE " + column + " = '" + value + "'");
		return result.size() > 0;
	}
	
	public static String getHash(String username) {
		LinkedList<String[]> result = execute("SELECT hash FROM users WHERE username = '" + username + "'");
		return (result.size()>0) ? result.get(0)[0] : null;
	}
	
	public static LinkedList<Post> getPosts(String user) {
		LinkedList<Post> posts = new LinkedList<>();
		for (String[] array : execute("SELECT * FROM posts WHERE username = '" + user + "'"))
			posts.add(new Post(array));
		return posts;
	}
	
	public static class Post {
		public String id, username, title, description;
		public Post(String[] data) {
			this.id = data[0];
			this.username = data[1];
			this.title = data[2];
			this.description = data[3];
		}
	}
}
