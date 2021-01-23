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
	
	<!-- JAVA IMPORTS -->
	<%@ page import="persistence.Database" %>
	
	<!-- GET SESSION DATA -->
	<%
		Database.User user = (Database.User)session.getAttribute("user");
	%>
	
	<!-- PAGE-SPECIFIC RESOURCES -->
	<link rel="stylesheet" href="./css/newsfeed.css">
	
</head>

<body>
	
	<!-- NAVIGATION BAR -->
	<nav>
		<div>
			<a href="./">Picturn</a>
		</div>
		<div style="width: 40%;">
			<input class="searchbar" type="text" placeholder="Search Picturn...">
		</div>
		<div>
			<a href="users">Find Users</a>
			<a href="javascript:void(0);" onclick="show('screen','newpost')">+</a>
			<a href="profile"><%=user.username%></a>
			<a href="logout">Log Out</a>
		</div>
	</nav>
	
	<div id="screen" onclick="hide('screen','newpost')"></div>
	
	<main>
		<!-- Loop through posts and generate html -->
		<% for (Database.Post post : Database.getNewsfeedPosts(user.username)) { %>
			<div class="post" id="<%= post.id %>">
				<div class="title"><span style="color: black"><%= post.username %></span> - <%= post.title %></div>
				<img src = "https://f000.backblazeb2.com/file/picturn/<%= post.id %>tn.jpg" onload="show('<%= post.id %>')">
				<div class="description"><%=post.description%></div>
			</div>
		<% } %>
	</main>
	
	<form class="newpost_form" id="newpost" method="post" enctype = "multipart/form-data" action="post">
		
		<label id="file_label" for="file" style="cursor: pointer;">Image</label><br>
		<input id="file" class="hide" type="file" name="file" accept="image/*" onchange="displayImage(event)">
		
		<input type="text" autocomplete="off" name="title" placeholder="Title"><br>
		<input type="text" autocomplete="off" name="description" placeholder="Description"><br>
		<input type="submit" value="Post">
	</form>
	
</body>

</html>
