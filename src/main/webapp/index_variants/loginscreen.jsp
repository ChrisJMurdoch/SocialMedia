<!DOCTYPE html>

<html>

<head>
	<meta charset="ISO-8859-1">
	<title>Picturn</title>
	<script src="../javascript/script.js"></script>
	<link rel="stylesheet" href="./css/style.css">
	<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>

<body style="background-image: url('images/CamBDark.jpg'); color: dimgrey">
	
	<%
		// Set default placeholder text
		String lUser="Username", lPass="Password";
		String rEmail="Email", rUser="Username", rPass="Password", rCheck="Retype your password";
		
		// Problem logging in
		if ( session.getAttribute("login_failure") != null ) {
			switch( (String)session.getAttribute("login_failure") ) {
			case "username_wrong":
				lUser="No user by that name";
				break;
			case "password_wrong":
				lPass="Wrong password";
				break;
			default:
				System.out.println("Unexpected login_failure value:" + session.getAttribute("login_failure"));
			}
		}
		
		// Problem registering
		if ( session.getAttribute("register_failure") != null ) {
			switch( (String)session.getAttribute("register_failure") ) {
			case "email_invalid":
				rEmail="Email invalid";
				break;
			case "email_used":
				rEmail="Email already in use";
				break;
			case "username_invalid":
				rUser="Username invalid";
				break;
			case "username_used":
				rUser="Username already in use";
				break;
			case "password_invalid":
				rPass="Password invalid";
				break;
			case "password_mismatch":
				rCheck="Passwords don't match";
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
	   	<input type="password" autocomplete="off" name="check" placeholder="<%=rCheck%>"><br>
	   	<input type="submit" value="Sign Up">
	</form>
	
</body>

</html>
