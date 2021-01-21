<!DOCTYPE html>

<html>

<head>
	<title>Picturn</title>
	<link rel="stylesheet" href="./css/style.css">
	<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>

<body>
	
	<%
		// Logged out -> login screen | Logged in -> newsfeed
		request.getRequestDispatcher( session.getAttribute("user")==null ? "index_variants/loginscreen.jsp" : "index_variants/newsfeed.jsp" ).forward( request, response );
	%>
	
	<!-- This page should always forward to a page in the index_variants directory -->
	<h1>Session error, try reloading page.</h1>
	
</body>

</html>
