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
	
	<form method="post" action="resetpass">
		<h1>Reset Password</h1>
		<input type="text" autocomplete="off" name="email" placeholder="Email"><br>
		<p>If there's an account with this email address, we'll send you a reset link.</p>
		<div class="submit_bar">
			<input type="submit" value="Reset">
			<a href="/">Cancel</a>
		</div>
	</form>
	
</body>

</html>
