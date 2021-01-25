<!DOCTYPE html>

<html>

<head>
	
	<!-- METADATA -->
	<meta charset="UTF-8">
	<title>Picturn</title>
	
	<!-- COMMON INCLUDES -->
	<script src="./javascript/script.js"></script>
	<link rel="stylesheet" href="./css/style.css">
	
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
	<link rel="stylesheet" href="./css/users.css">
	
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
		
		<!-- NAVIGATION ELEMENTS -->
		<div id="screen" onclick="hide('screen','newpost')"></div>
		<form class="newpost_form" id="newpost" method="post" enctype = "multipart/form-data" action="post">
			
			<label id="file_label" for="file" style="cursor: pointer;">Image</label><br>
			<input id="file" class="hide" type="file" name="file" accept="image/*" onchange="displayImage(event)">
			
			<input type="text" autocomplete="off" name="title" placeholder="Title"><br>
			<input type="text" autocomplete="off" name="description" placeholder="Description"><br>
			<input type="submit" value="Post">
		</form>
		
		<!-- USER LIST -->
		<div class="user_list">
			<% for(Database.User u : Database.getFollowableUsers(user.username)) { %>
				<div class="user">
					<% if (u.has_avatar) { %>
						<img src = "https://f000.backblazeb2.com/file/picturn/<%= u.username %>pr.jpg">
					<% } else { %>
						<div class = "avatar_placeholder"></div>
					<% } %>
					<div class="user_name"><div class="inner"><%= u.username %></div></div>
					<form method="post" action="/follow">
						<button type="submit" name="follow" value="<%=u.username%>">+</button>
					</form>
				</div>
			<% } %>
		</div>
	</main>
	
</body>

</html>
