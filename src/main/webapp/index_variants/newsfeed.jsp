<!DOCTYPE html>

<html>

<head>
	<meta charset="ISO-8859-1">
	<title>Picturn</title>
	<link rel="stylesheet" href="./css/style.css">
	<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>

<body>
	
	<nav>
		<a>Home</a>
		<a>Messages</a>
		<a><%=session.getAttribute("username")%></a>
	</nav>
	
	<h1>Hello, <%=session.getAttribute("username")%>!</h1>
	
	<a href="logout">log out</a>
	
</body>

</html>
