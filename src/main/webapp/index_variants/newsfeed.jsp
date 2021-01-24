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
	<script src="./javascript/newsfeed.js"></script>
	
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
			<a href="/WEB-INF/profile.jsp"><%=user.username%></a>
			<a href="logout">Log Out</a>
		</div>
	</nav>
	
	<div id="screen" onclick="hide('screen','newpost')"></div>
	
	<main>
		<!-- Loop through posts and generate html -->
		<% for (Database.Post post : Database.getNewsfeedPosts(user.username)) { %>
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
