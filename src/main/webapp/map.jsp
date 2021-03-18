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
	
	<!-- SESSION -->
	<%@ page import="persistence.Database" %>
	<%
		// Get session and user data
		Database.User user = (Database.User)session.getAttribute("user");
		
		// Add dummy user if null
		if (user==null) {
			user = new Database.User();
			String[] dummy = {"DEFAULT_USER", "default@gmail.com", "dummy_hash", "f"};
			user.populate(dummy);
		}
	%>
	<!-- PAGE-SPECIFIC RESOURCES -->
	<link rel="stylesheet" href="./css/pages/map.css">
	
</head>

<body>
	
	<!-- NAVIGATION BAR -->
	<nav>
		<div><a href="/">Picturn</a></div>
		<div style="width: 40%;"><input class="searchbar" type="text" placeholder="Search Picturn..."></div>
		<div>
			<a href="javascript:void(0);" onclick="show('screen','newpost')">+</a>
			<a href="/leaderboard">Leaderboard</a>
			<a href="/users">Find Users</a>
			<a href="/users/<%=user.username%>"><%=user.username%></a>
			<a href="/logout">Log Out</a>
		</div>
	</nav>
	
	<main>
		<!--Div to hold the map -->
		<div id="map"></div>

		<script>
		function myMap() {
		var mapProp= {
		//Latutude and longitude of HWU, should be changed so it shows the users current location
		center:new google.maps.LatLng(55.9097,-3.3203),
		zoom:10,
		};
		//Inserts the map into the div created above
		var map = new google.maps.Map(document.getElementById("map"),mapProp);
		}
		</script>

		<!--Google API key to use a google map -->
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAArlMemNWcimcXoq2dHWrDe7omkQd6mn4&callback=myMap"></script>

		
	
		<div class="post_list">
			<p> this box is for post list</p>
			
		</div>
	</main>
	
</body>

</html>