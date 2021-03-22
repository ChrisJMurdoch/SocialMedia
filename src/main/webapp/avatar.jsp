<!DOCTYPE html>
<html>
<head>

	<!-- META DATA -->
	<meta charset="UTF-8">
	<title>Picturn</title>
	
	<!-- GLOBAL LINKS -->
	<script src="/javascript/script.js"></script>
	<link rel="stylesheet" href="/css/global.css">
	
	<!-- FONTS -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;400;500;600;700&display=swap">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<!-- PAGE-SPECIFIC LINKS -->
	<link rel="stylesheet" href="/css/pages/avatar.css">
	<script src="/javascript/avatar.js"></script>
	<script src="/javascript/downloadAvatar.js"></script> 
	
	<!-- SESSION -->
	<%@ page import="persistence.Database" %>
	<%
		// Get session and user data
		Database.User user = (Database.User)session.getAttribute("user");
		String profile = request.getParameter("profile");
		
		// Add dummy user if null
		if (user==null) {
			user = new Database.User();
			String[] dummy = {"DEFAULT_USER", "default@gmail.com", "dummy_hash", "f"};
			user.populate(dummy);
		}
	%>
	
	
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
	
	<h1 align="center">Avatar Creator</h1>
		
	<!-- Shows avatar generated -->
	<div align="center">
		<canvas id="canvas"></canvas>
		<br></br>
		<button onClick="window.location.reload();" id="button">Generate Avatar</button> 
		<button onclick="DownloadCanvasAsImage();" id="downButton">Download Avatar</button>
	</div>
		
	
	
</body>
</html>