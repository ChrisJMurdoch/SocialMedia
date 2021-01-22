package persistence;

import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.util.LinkedList;

/** User-friendly DatabaseDirect wrapper class to perform PostgreSQL queries */
public class Database {
	
	// ===== CONNECTION =====
	
	public static void connect() {
		DatabaseDirect.connect();
	}
	public static void disconnect() {
		DatabaseDirect.disconnect();
	}
	
	// ===== UTILITY =====
	
	/** Check whether or not a value exists */
	public static boolean exists(String table, String column, String value) {
		LinkedList<String[]> result = DatabaseDirect.query("SELECT * FROM " + table + " WHERE " + column + " = '" + value + "'");
		return result.size() > 0;
	}
	
	/** Return first value of result for a given query */
	public static String getValue(String get, String table, String column, String value) {
		LinkedList<String[]> result = DatabaseDirect.query("SELECT " + get + " FROM " + table + " WHERE " + column + " = '" + value + "'");
		return (result.size()>0 && result.get(0).length>0) ? result.get(0)[0] : null;
	}
	
	// ===== QUERIES =====
	
	/** Return user that matches given username */
	public static User getUser(String username) {
		LinkedList<User> result = getRows( "SELECT * FROM users WHERE username = '" + username + "'", User.class);
		return result.size()>0 ? result.get(0) : null;
	}
	
	/** Return list of all users */
	public static LinkedList<User> getUsers() {
		return getRows( "SELECT * FROM users ORDER BY hash", User.class);
	}
	
	/** Return list of all users minus self and followed users */
	public static LinkedList<User> getFollowableUsers(String username) {
		return getRows( "SELECT users.* FROM users WHERE users.username != '" + username +
				"' EXCEPT SELECT users.* FROM users JOIN following ON users.username = following.followed WHERE following.follower = '"
				+ username + "';", User.class);
	}
	
	/** Return list of posts from all users */
	public static LinkedList<Post> getAllPosts() {
		return getRows( "SELECT * FROM posts ORDER BY posted_at DESC;", Post.class);
	}
	
	/** Return list of posts for given user */
	public static LinkedList<Post> getUserPosts(String user) {
		return getRows( "SELECT * FROM posts WHERE username = '" + user + "' ORDER BY posted_at DESC;", Post.class);
	}
	
	/** Return list of posts from all users followed by given user */
	public static LinkedList<Post> getFollowedUserPosts(String user) {
		return getRows( "SELECT posts.* FROM following JOIN posts ON following.followed = posts.username WHERE following.follower = '" + user + "' ORDER BY posted_at DESC;", Post.class);
	}
	
	// ===== EXECUTIONS =====

	/** Create user in database */
	public static void createUser(String username, String email, String hash) {
		DatabaseDirect.execute("INSERT INTO users VALUES ( '"+username+"', '"+email+"', '"+hash+"', DEFAULT )");
	}

	/** Create post in database and return id number */
	public static int createPost(String user, String title, String description, String imageType) {
		DatabaseDirect.execute( "INSERT INTO posts VALUES ( DEFAULT, '"+user+"', '"+title+"', '"+description+"', '"+imageType+"' )" );
		LinkedList<String[]> result = DatabaseDirect.query("SELECT id FROM posts");
		int highest = 0;
		for (String[] row : result) {
			int index = Integer.parseInt(row[0]);
			highest = (index>highest) ? index : highest;
		}
		return highest;
	}
	
	/** Create following entry in database */
	public static void follow(String follower, String followed) {
		DatabaseDirect.execute("INSERT INTO following VALUES ( '"+follower+"', '"+followed+"' )");
	}
	
	// ===== DATA PARSING AND REPRESENTATION =====
	
	/** This method takes in a query and Class and tries to create a list of the provided class populated with the query return-data */
	private static <T extends DBRow> LinkedList<T> getRows(String query, Class<T> clazz) {
		LinkedList<T> rows = new LinkedList<>();
		for (String[] array : DatabaseDirect.query(query)) {
			try {
				T t = clazz.getDeclaredConstructor().newInstance();
				t.populate(array);
				rows.add(t);
			} catch (InstantiationException | IllegalAccessException | IllegalArgumentException | InvocationTargetException | NoSuchMethodException | SecurityException e) {
				e.printStackTrace();
			}
		}
		return rows;
	}
	
	// ===== DATABASE RECORDS =====
	
	/** Abstract class to allow database records to be genericised */
	private static abstract class DBRow {
		abstract void populate(String[] data);
	}
	
	public static class User extends DBRow {
		public String username, email, hash;
		public boolean has_avatar;
		@Override
		public void populate(String[] data) {
			this.username = data[0];
			this.email = data[1];
			this.hash = data[2];
			this.has_avatar = data[3].equals("t");
		}
	}
	public static class Post extends DBRow {
		public String id, username, title, description, imageType;
		@Override
		public void populate(String[] data) {
			this.id = data[0];
			this.username = data[1];
			this.title = data[2];
			this.description = data[3];
			this.imageType = data[4];
		}
	}
}
