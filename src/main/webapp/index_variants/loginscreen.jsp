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
	
	<!-- JAVA IMPORTS -->
	<%@ page import="servlets.Login, servlets.Register" %>
	
	<!-- PAGE-SPECIFIC RESOURCES -->
	<link rel="stylesheet" href="./css/pages/loginscreen.css">
	
</head>

<body style="background-image: url('images/CamBDark.jpg'); color: dimgrey">
	
	<%
		// Set default placeholder text
		String lUser="Username", lPass="Password";
		String rEmail="Email", rUser="Username", rPass="Password";
		
		// Problem logging in
		if ( session.getAttribute("login_failure") != null ) {
			switch( (Login.LoginResult)session.getAttribute("login_failure") ) {
			case WRONG_USERNAME:
				lUser="No user by that name";
				break;
			case WRONG_PASSWORD:
				lPass="Wrong password";
				break;
			default:
				System.out.println("Unexpected login_failure value:" + session.getAttribute("login_failure"));
			}
		}
		
		// Problem registering
		boolean reg_fail = false;
		if ( session.getAttribute("register_failure") != null ) {
			reg_fail = true;
			switch( (Register.RegisterResult)session.getAttribute("register_failure") ) {
			case EMAIL_INVALID:
				rEmail="Email invalid";
				break;
			case EMAIL_USED:
				rEmail="Email already in use";
				break;
			case USERNAME_INVALID:
				rUser="Username invalid";
				break;
			case USERNAME_USED:
				rUser="Username already in use";
				break;
			case PASSWORD_INVALID:
				rPass="Must be at least 5 characters";
				break;
			default:
				System.out.println("Unexpected register_failure value:" + session.getAttribute("register_failure"));
			}
		}
		
		// Clear failures for next reload
		request.getSession().removeAttribute("login_failure");
		request.getSession().removeAttribute("register_failure");
	%>
	
	<form id="login" class="centre_form" method="post" action="login">
		<h3>Welcome to Picturn!  You can log in here or if you're new, <a href="javascript:void(0)" onclick="switchDisplayed('login','register')">create an account</a>.</h3>
		<input type="text" autocomplete="off" name="username" placeholder="<%=lUser%>"><br>
	   	<input type="password" autocomplete="off" name="password" placeholder="<%=lPass%>"><br>
	   	<input type="submit" value="Log In">
	</form>
	
	<form id="register" class="centre_form" method="post" action="register" style="visibility: hidden;">
		<h3>Create an account here! if you already have one, you can <a href="javascript:void(0)" onclick="switchDisplayed('register','login')">log in here</a>.</h3>
		<input type="text" autocomplete="off" name="email" placeholder="<%=rEmail%>"><br>
		<input type="text" autocomplete="off" name="username" placeholder="<%=rUser%>"><br>
	   	<input type="password" autocomplete="off" name="password" placeholder="<%=rPass%>"><br>
	   	By creating an account with us, you agree to our <a href="/termsofservice" target="_">Terms of Service</a>.
	   	<input type="submit" value="Sign Up">
	</form>
	
	<!-- Switch to registration view if problem -->
	<% if (reg_fail) { %>
		<script> switchDisplayed('login','register'); </script>
	<% } %>
	
</body>

</html>
