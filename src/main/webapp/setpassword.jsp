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
	
	<!-- PAGE-SPECIFIC RESOURCES -->
	<link rel="stylesheet" href="./css/pages/changepassword.css">
	
</head>

<body style="background-image: url('images/CamBDark.jpg');">
	
	<form method="post" action="setpass">
		<h1>Set New Password</h1>
		<input type="hidden" name="user" value="<%=request.getParameter("user")%>"><br>
		<input type="hidden" name="code" value="<%=request.getParameter("code")%>"><br>
		<input type="password" autocomplete="off" name="password" placeholder="New Password"><br>
		<div class="submit_bar">
			<input type="submit" value="Set">
			<a href="/">Cancel</a>
		</div>
	</form>
	
</body>

</html>
