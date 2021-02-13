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
	%>
	
	<!-- PAGE-SPECIFIC RESOURCES -->
	<link rel="stylesheet" href="./css/pages/changepassword.css">
	
</head>

<body style="background-image: url('images/CamBDark.jpg');">
	
	<form method="post" action="changepass">
		<h1>Change password</h1>
		<input type="password" autocomplete="off" name="current" placeholder="Current password"><br>
		<input type="password" autocomplete="off" name="new" placeholder="New password"><br>
		<span style="color:red">
			<%
				if ( session.getAttribute("fail_message") != null ) {
					out.print( session.getAttribute("fail_message") );
					request.getSession().removeAttribute("fail_message");
				}
			%>
		</span>
		<div class="submit_bar">
			<input type="submit" value="Change">
			<a href="/">Cancel</a>
		</div>
	</form>
	
</body>

</html>
