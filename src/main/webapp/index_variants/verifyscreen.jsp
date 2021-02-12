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
	<%@ page import="persistence.Database, persistence.Emailer" %>
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
	
	<!-- PAGE-SPECIFIC RESOURCES -->
	<link rel="stylesheet" href="./css/pages/verifyscreen.css">
	
</head>

<body style="background-image: url('images/CamBDark.jpg');">
	
	<form method="post" action="verify">
		<h1>Verify your email</h1>
		<p>We've sent a code to: <span style="color:forestgreen;"><%=user.email%></span>.</p>
		<input type="text" autocomplete="off" name="code" placeholder="Code"><br>
		<span style="color:red">
			<%
				if ( session.getAttribute("fail_message") != null ) {
					out.print( session.getAttribute("fail_message") );
					request.getSession().removeAttribute("fail_message");
				} else {
					Emailer.sendEmail(user.email, "Email verification", "Hello, "+user.username+".  Your verification code is: " + user.verify);
				}
			%>
		</span>
		<div class="submit_bar">
			<input type="submit" value="Verify">
			<a href="./">Re-send Email</a>
			<a href="/logout">Go Back</a>
		</div>
	</form>
	
</body>

</html>
