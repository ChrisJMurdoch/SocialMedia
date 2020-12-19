<!DOCTYPE html>

<html>

<head>
	<meta charset="ISO-8859-1">
	<title>Picturn</title>
	<link rel="stylesheet" href="./css/style.css">
</head>

<body>
	
	<!-- Welcome message -->
	<h1>Hello, <%=session.getAttribute("username")%>!</h1>
	
	<a href="logout">log out</a>
	
</body>

</html>
