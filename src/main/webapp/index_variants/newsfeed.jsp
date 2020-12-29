<!DOCTYPE html>

<html>

<head>
	<meta charset="ISO-8859-1">
	<title>Picturn</title>
	<link rel="stylesheet" href="./css/style.css">
	<link rel="stylesheet" href="./css/newsfeed.css">
	<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>

<body>
	
	<nav>
		<div>
			<a href="./">Picturn</a>
		</div>
		<div style="width: 40%;">
			<input class="searchbar" type="text" placeholder="Search Picturn...">
		</div>
		<div>
			<a href="logout">Log Out</a>
			<a href="users/<%=session.getAttribute("username")%>"><%=session.getAttribute("username")%></a>
			<a href="./">Messages</a>
		</div>
	</nav>
	
</body>

</html>
