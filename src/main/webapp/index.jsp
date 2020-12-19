<!DOCTYPE html>

<html>

<head>
	<meta charset="ISO-8859-1">
	<title>Picturn</title>
	<link rel="stylesheet" href="./css/style.css">
</head>

<body>
	
	<%
		// Logged out -> login screen | Logged in -> newsfeed
		request.getRequestDispatcher( session.getAttribute("username")==null ? "index_variants/loginscreen.jsp" : "index_variants/newsfeed.jsp" ).forward( request, response );
	%>
	
	<!-- This page should always forward to a page in the index_variants directory -->
	<h1>Session error, try reloading page.</h1>
	
</body>

</html>
