<!DOCTYPE html>

<html>

<head>
	
	<!-- METADATA -->
	<meta charset="UTF-8">
	<title>Picturn</title>
	
	<!-- COMMON INCLUDES -->
	<script src="./javascript/script.js"></script>
	<link rel="stylesheet" href="./css/global.css">
	
	<!-- FONT -->
	<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;400;500;600;700&display=swap" rel="stylesheet">
	
	<!-- SESSION -->
	<%@ page import="persistence.Database, java.util.LinkedList" %>
	<%
		// Get session and user data
		Database.User user = (Database.User)session.getAttribute("user");
		
		// Add dummy user if null
		if (user==null) {
			user = new Database.User();
			String[] dummy = {"DEFAULT_USER", "default@gmail.com", "dummy_hash", "f"};
			user.populate(dummy);
		}
	%>
	
	<!-- PAGE-SPECIFIC RESOURCES -->
	<link rel="stylesheet" href="./css/pages/newsfeed.css">
	<link rel="stylesheet" href="./css/components/userpost.css">
	<link rel="stylesheet" href="./css/components/usercard.css">
	<link rel="stylesheet" href="./css/components/newpostform.css">
	<script src="./javascript/newsfeed.js"></script>
	
</head>

<body>
	
	<!-- NAVIGATION BAR -->
	<nav>
		<div><a href="/">Picturn</a></div>
		<div style="width: 40%;"><input class="searchbar" type="text" placeholder="Search Picturn..."></div>
		<div>
			<a href="javascript:void(0);" onclick="show('screen','newpost')">+</a>
			<a href="/leaderboard">Leaderboard</a>
			<a href="/discover">Discover</a>
			<a href="/users">Find Users</a>
			<a href="/users/<%=user.username%>"><%=user.username%></a>
			<a href="avatar.jsp">Avatar Creator</a>
			<a href="/logout">Log Out</a>
		</div>
	</nav>
	
	<div id="screen" onclick="hide('screen','newpost')"></div>
	
	<main>
		<div class="newsfeed">
			<!-- Loop through posts and generate html -->
			<% for (Database.Post post : Database.getNewsfeedPosts(user.username)) { %>
				<div class="post_wrapper">
					<div class="post" id="<%= post.id %>">
						<div class="post_header">
							<% String time = post.posted_at.split(" ")[0]; %>
							<div class="timestamp"><%=time%></div>
							<div class="username"><%=post.username%></div>
							<div class="like_box">
								<% String heart = post.liked ? "heart-filled" : "heart-empty"; %>
								<img id="like_button_<%=post.id%>" liked="<%=post.liked%>" class="like_button" src="../images/<%=heart%>.png" onclick="action('<%=post.id%>','<%=post.id%>')"></img>
								<div id="like_number_<%=post.id%>" class="likes"><%=post.likes%></div>
							</div>
						</div>
						<img class="post_image" src="https://f000.backblazeb2.com/file/picturn/<%= post.id %>tn.jpg" onload="show('<%= post.id %>')">
						<% if (!post.description.equals("")) { %>
							<div class="post_footer"><%=post.description%></div>
							<% } %>
					</div>
					<form class="comment_form" method="post" action="comment">
						<input type="text" autocomplete="off" name="message" placeholder="Comment..."><br>
						<input type="hidden" autocomplete="off" name="post" value="<%=post.id%>">
						<input type="submit" value="Send">
					</form>
					<% for (Database.Comment comment : Database.getComments(post.id)) { %>
						<div class="comment"><span style="font-weight: bold; color: forestgreen"><%=comment.sender%></span> <%=comment.message%></div>
					<% } %>
				</div>
			<% } %>
		</div>
	</main>
	
	<!-- <div class="notifications_box">No notifications to show</div> -->
	
	<div class="notifications_box">
		<div style="text-align: center; background-color: white; font-size: 1.5rem; border-radius: 0.2em; color: dimgrey;">Notifications</div>
		<%
			LinkedList<Database.Notification> notifications = Database.getNotifications(user.username);
			for(int i=notifications.size()-1; i>=0; i--) {
		%>
			<h3 style="background-color: white; border-radius: 0.5em; padding: 4px 2px; box-shadow: 0 0 10px lightgrey;"><%= notifications.get(i).message %></h3>
		<% } %>
	</div>
	
	<div class="following_box">
		<div style="text-align: center; background-color: white; font-size: 1.5rem; border-radius: 0.2em; color: dimgrey;">Following</div>
		<!-- USER LIST -->
		<div class="user_list">
			<% for(Database.User u : Database.getFollowed(user.username)) { %>
				<div class="user" style="width: 100%;">
					<% if (u.has_avatar) { %>
						<img src = "https://f000.backblazeb2.com/file/picturn/<%= u.username %>pr.jpg">
					<% } else { %>
						<div class = "avatar_placeholder"></div>
					<% } %>
					<div class="user_name"><a href ="/users/<%= u.username %>" class="inner"><%= u.username %></a></div>
				</div>
			<% } %>
		</div>
	</div>
	
	<form class="newpost_form" id="newpost" method="post" enctype = "multipart/form-data" action="post">
		
		<label id="file_label" for="file" style="cursor: pointer;">Image</label><br>
		<input id="file" class="hide" type="file" name="file" accept="image/*" onchange="displayImage(event)">
		
		<input type="text" autocomplete="off" name="title" placeholder="Title"><br>
		<input type="text" autocomplete="off" name="description" placeholder="Description"><br>
		<input type="submit" value="Post">
	</form>
	
</body>

</html>
