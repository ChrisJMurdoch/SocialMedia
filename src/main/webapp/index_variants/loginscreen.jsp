<!DOCTYPE html>

<html>

<head>
	<meta charset="ISO-8859-1">
	<title>Picturn</title>
	<link rel="stylesheet" href="./css/style.css">
	<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>

<body style="background-image: url('images/CamBDark.jpg'); color: dimgrey">
	
	<form class="login_box" method="post" action="login">
		<h3>Welcome to Picturn!  You can log in here or if you're new, <a href="info">create an account</a>.</h3>
		<%
			String usernameField = ( session.getAttribute("login_failure") != null && session.getAttribute("login_failure").equals("wrong_username") ) ? "Wrong username" : "Username";
			String passwordField = ( session.getAttribute("login_failure") != null && session.getAttribute("login_failure").equals("wrong_password") ) ? "Wrong password" : "Password";
			request.getSession().removeAttribute("login_failure");
		%>
		<input type="text" autocomplete="off" name="username" placeholder="<%=usernameField%>"><br>
	   	<input type="password" autocomplete="off" name="password" placeholder="<%=passwordField%>"><br>
	   	<input type="submit" value="Log In">
	</form>
	
</body>

</html>
