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
	<%@ page import="persistence.Database" %>
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
	<link rel="stylesheet" href="./css/pages/discover.css">
	<link rel="stylesheet" href="./css/components/usercard.css">
	<link rel="stylesheet" href="./css/components/userpost.css">
	
</head>

<body>
	
	<!-- NAVIGATION BAR -->
	<nav>
		<div><a href="/">Picturn</a></div>
		<div style="width: 40%;"><input class="searchbar" type="text" placeholder="Search Picturn..."></div>
		<div>
			<a href="/leaderboard">Leaderboard</a>
			<a href="/discover">Discover</a>
			<a href="/users">Find Users</a>
			<a href="/users/<%=user.username%>"><%=user.username%></a>
			<a href="avatar.jsp">Avatar Creator</a>
			<a href="/logout">Log Out</a>
		</div>
	</nav>
	
	<main>
		<div class="discover">
			<!-- Loop through posts and generate html -->
			<div class="title">Posts you might be interested in</div>
			<% for (Database.Post post : Database.getNewsfeedPosts(user.username)) { %>
			<%if(post.description.contains("#")){ %>
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
				<% } %>
		</div>
		
	</main>
	
</body>

</html>