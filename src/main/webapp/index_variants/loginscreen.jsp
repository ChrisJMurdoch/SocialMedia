<!DOCTYPE html>

<html>

<head>
	<meta charset="ISO-8859-1">
	<title>Picturn</title>
	<link rel="stylesheet" href="./css/style.css">
</head>

<body style="background-image: url('images/CamBDark.jpg'); color: white">
	
	<form class="login_box" method="post" action="login">
		<%
			String usernameField = ( session.getAttribute("login_failure") != null && session.getAttribute("login_failure").equals("wrong_username") ) ? "Wrong username" : "Username";
			String passwordField = ( session.getAttribute("login_failure") != null && session.getAttribute("login_failure").equals("wrong_password") ) ? "Wrong password" : "Password";
			request.getSession().removeAttribute("login_failure");
		%>
		<input type="text" autocomplete="off" name="username" placeholder="<%=usernameField%>"><br>
	   	<input type="password" autocomplete="off" name="password" placeholder="<%=passwordField%>"><br>
	   	<input type="submit" value="Log In">
	   	<div style="color: red;"><%= session.getAttribute("login_failure")==null ? "" : session.getAttribute("login_failure") %></div>
	</form>
	
</body>

</html>
