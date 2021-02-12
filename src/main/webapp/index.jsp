<!DOCTYPE html>

<html>

<head>
	<title>Picturn</title>
	<%@ page import="persistence.Database" %>
</head>

<body>
	
	<%
		Database.User user = (Database.User)session.getAttribute("user");
		if (user==null) {
			// User needs to log in
			request.getRequestDispatcher( "index_variants/loginscreen.jsp" ).forward( request, response );
		} else if (!user.verified()) {
			// User needs to verify email
			System.out.println(user.verify);
			request.getRequestDispatcher( "index_variants/verifyscreen.jsp" ).forward( request, response );
		} else {
			// Logged in
			request.getRequestDispatcher( "index_variants/newsfeed.jsp" ).forward( request, response );
		}
	%>
	
	<!-- This page should always forward to a page in the index_variants directory -->
	<h1>Session error, try reloading page.</h1>
	
</body>

</html>
