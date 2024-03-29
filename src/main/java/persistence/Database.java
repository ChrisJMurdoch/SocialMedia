package persistence;

import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.util.LinkedList;
import java.util.Random;

import security.Generation;

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
	
	/** Take in a user-submitted String, and escape any SQL code */
	private static String sanitise(String input) {
		// TODO
		return null;
	}
	
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

	/** Return user that matches given email */
	public static User getUserByEmail(String email) {
		LinkedList<User> result = getRows( "SELECT * FROM users WHERE email = '" + email + "'", User.class);
		return result.size()>0 ? result.get(0) : null;
	}

	/** Get comments for post */
	public static LinkedList<Comment> getComments(int post) {
		return getRows( "SELECT * FROM comments WHERE post = '"+post+"';", Comment.class);
	}

	/** Get followers */
	public static LinkedList<User> getFollowers(String username) {
		return getRows(
			"SELECT users.* FROM " +
				"users JOIN " +
				"following ON users.username = following.follower AND following.followed = '"+username+"';",
			User.class);
	}

	/** Get user notifications */
	public static LinkedList<Notification> getNotifications(String username) {
		return getRows(
			"SELECT * FROM " +
				"notifications " +
				"WHERE notifications.user = '"+username+"';",
				Notification.class);
	}

	/** Get followed */
	public static LinkedList<User> getFollowed(String username) {
		return getRows(
			"SELECT users.* FROM " +
				"users JOIN " +
				"following ON users.username = following.followed AND following.follower = '"+username+"';",
			User.class);
	}

	/** Get users following user */
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

	/** Get posts from user */
	public static LinkedList<Post> getUserPosts(String username, String observer) {
		return getRows(
				"SELECT posts.*, COUNT(awards) AS likes, bool_or(awards.sender = '"+observer+"') as liked FROM " +
					"posts LEFT JOIN " +
					"awards ON posts.id = awards.post AND awards.award = 'like' " +
					"WHERE posts.username = '"+username+"' " +
					"GROUP BY posts.id " +
					"ORDER BY posts.posted_at DESC;",
			Post.class);
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
	
	/** Get users with most likes */
	public static LinkedList<LeaderboardPosting> mostLikes(boolean limit) {
		return getRows(
			"SELECT users.username, users.has_avatar, COUNT(awards) AS likes FROM " +
				"users LEFT JOIN " +
				"posts ON users.username = posts.username LEFT JOIN " +
				"awards ON posts.id = awards.post AND awards.award = 'like' " +
				"GROUP BY users.username " +
				"ORDER BY likes DESC " +
				(limit ? "LIMIT 5;" : ";"),
			LeaderboardPosting.class);
	}

	/** Get users with most posts */
	public static LinkedList<LeaderboardPosting> mostPosts() {
		return getRows(
			"SELECT users.username, users.has_avatar, COUNT(posts) AS posts FROM " +
				"users LEFT JOIN " +
				"posts ON users.username = posts.username " +
				"GROUP BY users.username " +
				"ORDER BY posts DESC " +
				"LIMIT 5;",
			LeaderboardPosting.class);
	}
	
	// ===== EXECUTIONS =====

	/** Add notification */
	public static void addNotification(String username, String message) {
		DatabaseDirect.execute("INSERT INTO notifications VALUES('"+username+"', '"+message+"', false);");
	}

	/** Like user post */
	public static void like(String username, String post_id) {
		DatabaseDirect.execute("INSERT INTO awards VALUES('"+username+"', 'like', "+post_id+");");
	}

	/** Comment on post */
	public static void comment(String sender, String message, String post) {
		DatabaseDirect.execute("INSERT INTO comments VALUES('"+sender+"', '"+message+"', "+post+");");
	}
	
	/** Unlike user post */
	public static void unlike(String username, String post_id) {
		DatabaseDirect.execute("DELETE FROM awards WHERE sender = '"+username+"' AND award = 'like' AND post = "+post_id+";");
	}
	
	/** Create user in database */
	public static void createUser(String username, String email, String hash) {
		String verify = Generation.randomString(6, Generation.ALPHANUMERIC);
		String reset = Generation.randomString(20, Generation.ALPHANUMERIC);
		System.out.println("Verification code: ["+verify+"]");
		DatabaseDirect.execute("INSERT INTO users VALUES ( '"+username+"', '"+email+"', '"+hash+"', DEFAULT, '"+verify+"', '"+reset+"' )");
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

	/** Verify specific user */
	public static void verify(String user) {
		DatabaseDirect.execute("UPDATE users SET verify='[TRUE]' WHERE username = '"+user+"';");
	}

	/** Change user hash */
	public static void setHash(String user, String hash) {
		DatabaseDirect.execute("UPDATE users SET hash='"+hash+"' WHERE username = '"+user+"';");
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
		public String username, email, hash, verify, reset;
		public boolean has_avatar;
		@Override
		public void populate(String[] data) {
			username = data[0];
			email = data[1];
			hash = data[2];
			has_avatar = data[3].equals("t");
			verify = data[4];
			reset = data[5];
		}
		public boolean verified() {
			return verify.equals("[TRUE]");
		}
	}
	public static class Comment extends DBRow {
		public String sender, message;
		@Override
		public void populate(String[] data) {
			sender = data[0];
			message = data[1];
		}
	}
	public static class LeaderboardPosting extends DBRow {
		public String username;
		public boolean has_avatar;
		public int score;
		@Override
		public void populate(String[] data) {
			username = data[0];
			has_avatar = data[1].equals("t");
			score = Integer.parseInt(data[2]);
		}
	}
	public static class Post extends DBRow {
		public String username, title, description, imageType, posted_at;
		public int likes, id;
		public boolean liked;
		@Override
		public void populate(String[] data) {
			id = Integer.parseInt(data[0]);
			username = data[1];
			title = data[2];
			description = data[3];
			imageType = data[4];
			posted_at = data[5];
			likes = Integer.parseInt(data[6]);
			liked = data[7]!=null && data[7].equals("t");
		}
	}
	public static class Notification extends DBRow {
		public String user, message;
		public boolean read;
		@Override
		public void populate(String[] data) {
			user = data[0];
			message = data[1];
			read = data[2]!=null && data[2].equals("t");
		}
	}
}
