<!DOCTYPE html>

<html>

<head>
	<meta charset="ISO-8859-1">
	<title>Picturn</title>
	<link rel="stylesheet" href="./css/style.css">
</head>

<body>
	<h1>Picturn</h1>
	
	<%
		// Get data from post and session
		String username = 		(String)session.getAttribute("username");
		String loginFailure = 	(String)session.getAttribute("login_failure");
		
		// Clear single-use attributes
		request.getSession().removeAttribute("login_failure");
		
		// Welcome message or login screen
		if (username!=null) {%>
		
			<h1>Welcome <%=username%>!</h1>
			<a href="logout">log out</a>
			
		<%} else {%>
		
			<form method="post" action="login">
				Username: <input type="text" name="username"><br>
		    	Password: <input type="text" name="password"><br>
		    	<input type="submit" value="log in">
			</form>
			<div style="color: red;"><%= loginFailure==null ? "" : loginFailure %></div>
			
		<%}
	%>
	
	<a href="./info">info</a>
	
</body>

</html>
