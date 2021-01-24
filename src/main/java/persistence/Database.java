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
	
	/** Get unfollowed users minus self */
	public static LinkedList<User> getFollowableUsers(String username) {
		return getRows(
			"SELECT users.* FROM users " +
				"WHERE users.username != '"+username+"' " +
			"EXCEPT SELECT users.* FROM " +
				"users JOIN " +
				"following ON users.username = following.followed " +
				"WHERE following.follower = '"+username+"';",
			User.class);
	}
	
	/** Get posts from user + followed users */
	public static LinkedList<Post> getNewsfeedPosts(String username) {
		return getRows(
			"SELECT DISTINCT posts_with_likes.* FROM " +
				"( " +
					"SELECT posts.*, COUNT(awards) AS likes, bool_or(awards.sender = '"+username+"') as liked FROM " +
						"posts LEFT JOIN " +
						"awards ON posts.id = awards.post AND awards.award = 'like' " +
						"GROUP BY posts.id " +
				") AS posts_with_likes JOIN " +
				"following ON posts_with_likes.username = following.followed AND ( following.follower = '"+username+"' OR posts_with_likes.username = '"+username+"' ) " +
				"ORDER BY posts_with_likes.posted_at DESC;",
			Post.class);
	}
	
	// ===== EXECUTIONS =====
	
	/** Like user post */
	public static void like(String username, String post_id) {
		DatabaseDirect.execute("INSERT INTO awards VALUES('"+username+"', 'like', "+post_id+");");
	}
	
	/** Unlike user post */
	public static void unlike(String username, String post_id) {
		DatabaseDirect.execute("DELETE FROM awards WHERE sender = '"+username+"' AND award = 'like' AND post = "+post_id+";");
	}
	
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
			username = data[0];
			email = data[1];
			hash = data[2];
			has_avatar = data[3].equals("t");
		}
	}
	public static class Post extends DBRow {
		public String id, username, title, description, imageType, posted_at;
		public int likes;
		public boolean liked;
		@Override
		public void populate(String[] data) {
			id = data[0];
			username = data[1];
			title = data[2];
			description = data[3];
			imageType = data[4];
			posted_at = data[5];
			likes = Integer.parseInt(data[6]);
			liked = data[7]!=null && data[7].equals("t");
		}
	}
}
