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
			<a href="javascript:void(0);" onclick="show('screen','newpost')">+</a>
			<a href="users/<%=session.getAttribute("username")%>"><%=session.getAttribute("username")%></a>
			<a href="logout">Log Out</a>
		</div>
	</nav>
	
	<div id="screen" onclick="hide('screen','newpost')"></div>
	
	<main>
		<!-- Loop through posts and generate html -->
		<% for (Database.Post post : Database.getUserPosts("Chris")) { %>
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
