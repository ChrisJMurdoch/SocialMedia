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
	<link rel="stylesheet" href="./css/pages/leaderboard.css">
	<link rel="stylesheet" href="./css/components/usercard.css">
	
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
		
		<div class="leaderboard">
			<div class="title">Most likes</div>
			<% for (Database.LeaderboardPosting posting : Database.mostLikes(true)) { %>
				<div class="posting">
					<% if (posting.has_avatar) { %>
						<img src = "https://f000.backblazeb2.com/file/picturn/<%= posting.username %>pr.jpg">
					<% } else { %>
						<div class = "avatar_placeholder"></div>
					<% } %>
					<div class="username"><%= posting.username %></div>
					<div class="score"><%= posting.score %></div>
				</div>
			<% } %>
		</div>
		
		<div class="leaderboard">
			<div class="title">Most posts</div>
			<% for (Database.LeaderboardPosting posting : Database.mostPosts()) { %>
				<div class="posting">
					<% if (posting.has_avatar) { %>
						<img src = "https://f000.backblazeb2.com/file/picturn/<%= posting.username %>pr.jpg">
					<% } else { %>
						<div class = "avatar_placeholder"></div>
					<% } %>
					<div class="username"><%= posting.username %></div>
					<div class="score"><%= posting.score %></div>
				</div>
			<% } %>
		</div>
		
	</main>
	
</body>

</html>
