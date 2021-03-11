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
	
	<!-- PAGE SPECIFIC -->
	<link rel="stylesheet" href="./css/pages/users.css">
	<link rel="stylesheet" href="./css/components/usercard.css">
	
</head>

<body>
	
	<main>
		
		<!-- NAVIGATION BAR -->
		<nav>
			<div><a href="/">Picturn</a></div>
			<div style="width: 40%;"><input class="searchbar" type="text" placeholder="Search Picturn..."></div>
			<div>
				<a href="/leaderboard">Leaderboard</a>
				<a href="/users">Find Users</a>
				<a href="/users/<%=user.username%>"><%=user.username%></a>
				<a href="/logout">Log Out</a>
			</div>
		</nav>
		
		<!-- USER LIST -->
		<div class="user_list">
			<% for(Database.User u : Database.getFollowableUsers(user.username)) { %>
				<div class="user">
					<% if (u.has_avatar) { %>
						<img src = "https://f000.backblazeb2.com/file/picturn/<%= u.username %>pr.jpg">
					<% } else { %>
						<div class = "avatar_placeholder"></div>
					<% } %>
					<div class="user_name"><a href ="/users/<%= u.username %>" class="inner"><%= u.username %></a></div>
					<form method="post" action="/follow">
						<button type="submit" name="follow" value="<%=u.username%>">+</button>
					</form>
				</div>
			<% } %>
		</div>
	</main>
	
</body>

</html>
