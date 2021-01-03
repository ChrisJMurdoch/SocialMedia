<!DOCTYPE html>

<html>

<head>
	<meta charset="ISO-8859-1">
	<title>Picturn</title>
	<script src="../javascript/script.js"></script>
	<link rel="stylesheet" href="./css/style.css">
	<link rel="stylesheet" href="./css/newsfeed.css">
	<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;400;500;600;700&display=swap" rel="stylesheet">
	<%@ page import = "persistence.Database" %>
</head>

<body>
	
	<nav>
		<div>
			<a href="./">Picturn</a>
		</div>
		<div style="width: 40%;">
			<input class="searchbar" type="text" placeholder="Search Picturn...">
		</div>
		<div>
			<a href="logout">Log Out</a>
			<a href="users/<%=session.getAttribute("username")%>"><%=session.getAttribute("username")%></a>
			<a href="./">Messages</a>
		</div>
	</nav>
	
	<main>
		<!-- Loop through posts and generate html -->
		<% for (Database.Post post : Database.getPosts("Chris")) { %>
			<div class="post" id="<%= post.id %>">
				<img src = "https://f000.backblazeb2.com/file/picturn/<%= post.id %>tn.jpg" onload="show('<%= post.id %>')">
				<div class="title"><%=post.title%></div>
				<div class="description"><%=post.description%></div>
			</div>
		<% } %>
	</main>
	
</body>

</html>
