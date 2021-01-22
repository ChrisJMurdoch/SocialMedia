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
			<a href="users"><%=user.username%></a>
			<a href="logout">Log Out</a>
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
	
	<!-- ADD HTML HERE -->
	<h1>Template page</h1>
	
</body>

</html>