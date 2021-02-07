<!DOCTYPE html>
<html>
<head>

	<!-- META DATA -->
	<meta charset="ISO-8859-1">
	<title>Picturn</title>
	
	<!-- GLOBAL LINKS -->
	<script src="/javascript/script.js"></script>
	<link rel="stylesheet" href="/css/global.css">
	
	<!-- FONTS -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;400;500;600;700&display=swap">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<!-- SESSION -->
	<%@ page import="persistence.Database" %>
	<%
		// Get session and user data
		Database.User user = (Database.User)session.getAttribute("user");
		String profile = request.getParameter("profile");
		
		// Add dummy user if null
		if (user==null) {
			user = new Database.User();
			String[] dummy = {"DEFAULT_USER", "default@gmail.com", "dummy_hash", "f"};
			user.populate(dummy);
		}
	%>
	
	<!-- PAGE-SPECIFIC LINKS -->
	<link rel="stylesheet" href="/css/pages/profile.css">
	<link rel="stylesheet" href="/css/components/userpost.css">
	<link rel="stylesheet" href="/css/components/usercard.css">
	<script src="/javascript/profile.js" defer></script>
	
</head>
<body>

	<!-- NAVIGATION BAR -->
	<nav>
		<div><a href="/">Picturn</a></div>
		<div style="width: 40%;"><input class="searchbar" type="text" placeholder="Search Picturn..."></div>
		<div>
			<a href="/leaderboard">Leaderboard</a>
			<a href="/users">Find Users</a>
			<a href="/users/<%=user.username%>"><%=user.username%></a>
			<a href="/logout">Log Out</a>
		</div>
	</nav>
	
	<div class = "container">
	
	<!-- top section of the profile containing all the user details  -->
		<div class = "profile-head">
			<!-- users display picture and change link for adding a new dp -->
			<div class="display-pic">
				<img src="../images/defaultIcon.jpg " width="200" alt="">
				<a href="javascript:void(0);" onclick="show('dp')">Change</a>
			</div>
			
			<!-- form which allows users to change dp. invisible until change link is clicked -->
			<form class="dp-form" id="dp" >
				<label id="file_label" for="file" style="cursor: pointer;">Image</label><br>
				<input id="file" class="hide" type="file" name="file" accept="image/*" onchange="displayImage(event)">
				<input type="submit" value="Change">
			</form>
			
			<!-- user information  -->
			<div class="profile-info">
				<h3 class="user-name"><%=request.getParameter("profile")%></h3>
				<p class="bio">Insert bio here...</p>
				<p>Joined on ...</p>
			</div>
			
			<!-- users rating in stars and their points total -->
			<div class="scores">
				<p><strong>Score:</strong>  10020</p>
                <p><strong>Rating:</strong> <span class="fa fa-star checked"></span>
					<span class="fa fa-star checked"></span>
					<span class="fa fa-star checked"></span>
					<span class="fa fa-star"></span>
					<span class="fa fa-star"></span>
					
				<!-- above code sourced from https://www.w3schools.com/howto/howto_css_star_rating.asp -->
				</p>
			</div>
		</div>
		
		<!-- Bottom section of the profile page. Contains various tabs for posts, followers, etc -->
		<div class="main-content">
			
			<!-- https://www.youtube.com/watch?v=5L6h_MrNvsk followed this tutorial for tabs -->
			<ul class="nav-tabs">
				<li data-tab-target = "#posts" class="tab" >Posts</li>
				<li data-tab-target = "#followers" class="tab">Followers</li>
				<li data-tab-target = "#following" class="tab">Following</li>
				<li data-tab-target = "#trophies" class="tab">Trophies</li>
			</ul>
			<div class="tab-content">
				<div tab-pane class="active" id="posts" style="padding: 0 35%;">
					<!-- Uploaded photos will be displayed under this tab -->
					<!-- Loop through posts and generate html -->
					<% for (Database.Post post : Database.getUserPosts(profile, user.username)) { %>
						<div class="post" id="<%= post.id %>">
							<div class="post_header">
								<% String time = post.posted_at.split(" ")[0]; %>
								<div class="timestamp"><%=time%></div>
								<div class="username"><%=post.username%></div>
								<div class="like_box">
									<% String heart = post.liked ? "heart-filled" : "heart-empty"; %>
									<img id="like_button_<%=post.id%>" liked="<%=post.liked%>" class="like_button" src="../images/<%=heart%>.png" onclick="action('<%=post.id%>','<%=post.id%>')"></img>
									<div id="like_number_<%=post.id%>" class="likes"><%=post.likes%></div>
								</div>
							</div>
							<img class="post_image" src="https://f000.backblazeb2.com/file/picturn/<%= post.id %>tn.jpg" onload="show('<%= post.id %>')">
							<% if (!post.description.equals("")) { %>
								<div class="post_footer"><%=post.description%></div>
								<% } %>
						</div>
					<% } %>
				</div>

				<div  class = "tab-pane" id="followers" tab-pane>
					<!-- USER LIST -->
					<div class="user_list">
						<% for(Database.User u : Database.getFollowers(profile)) { %>
							<div class="user">
								<% if (u.has_avatar) { %>
									<img src = "https://f000.backblazeb2.com/file/picturn/<%= u.username %>pr.jpg">
								<% } else { %>
									<div class = "avatar_placeholder"></div>
								<% } %>
								<div class="user_name"><a href ="/users/<%= u.username %>" class="inner"><%= u.username %></a></div>
							</div>
						<% } %>
					</div>
				</div>
				
				<div class="tab-pane" id="following" tab-pane>
					<!-- USER LIST -->
					<div class="user_list">
						<% for(Database.User u : Database.getFollowed(profile)) { %>
							<div class="user">
								<% if (u.has_avatar) { %>
									<img src = "https://f000.backblazeb2.com/file/picturn/<%= u.username %>pr.jpg">
								<% } else { %>
									<div class = "avatar_placeholder"></div>
								<% } %>
								<div class="user_name"><a href ="/users/<%= u.username %>" class="inner"><%= u.username %></a></div>
							</div>
						<% } %>
					</div>
				</div>

				<div class="tab-pane" id="trophies" tab-pane>
					<p style="padding-left: 45%">No trophies to show yet!</p>
				</div>
			</div>
		</div>
	</div> 
</body>
</html>