<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Picturn</title>
	<script src="./javascript/script.js"></script>
	<script src="./javascript/profile.js" defer></script>
	<link rel="stylesheet" href="./css/style.css">
	<link rel="stylesheet" href="./css/profile.css">
	<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;400;500;600;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
			<a href="javascript:void(0);" onclick="show('screen','newpost')">+</a>
			<a href="users/<%=session.getAttribute("username")%>"><%=session.getAttribute("username")%></a>
			<a href="logout">Log Out</a>
		</div>
	</nav>
	
	<div class = "container">
	
	<!-- top section of the profile containing all the user details  -->
		<div class = "profile-head">
			<!-- users display picture and change link for adding a new dp -->
			<div class="display-pic">
				<img src="defaultIcon.jpg " width="200" alt="">
				<a href="#" onclick="document.getElementById('dp').style.display='block'">Change</a>
			</div>
			
			<!-- form which allows users to change dp. invisible until change link is clicked -->
			<form class="dp-form" id="dp" >
				<label id="file_label" for="file" style="cursor: pointer;">Image</label><br>
				<input id="file" class="hide" type="file" name="file" accept="image/*" onchange="displayImage(event)">
				<input type="submit" value="Change">
			</form>
			
			<!-- user information  -->
			<div class="profile-info">
				<h3 class="user-name">Username</h3>
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
				<div class="active tab-pane" id="posts">
					<!-- Uploaded photos will be displayed under this tab -->
					<div class="gallery">
						<a target="_blank" href="https://composeclick.com/wp-content/uploads/2018/05/nature-1-1024x637.jpg">
							<img src = "https://composeclick.com/wp-content/uploads/2018/05/nature-1-1024x637.jpg" alt="pic" width="600" height="400">
						</a>
						<div class="desc">
							description
						</div>
					</div>
					<div class='gallery'>
						<a target="_blank" href="https://composeclick.com/wp-content/uploads/2018/05/nature-2-1024x576.jpg">
							<img src="https://composeclick.com/wp-content/uploads/2018/05/nature-2-1024x576.jpg" alt="Forest" width="600" height="400">
						</a>
						<div class="desc">
							description
						</div>
					</div>
				</div>

				<div  class = "tab-pane" id="followers" >
					<p>This tab will show a list of the people that are following your account</p>
				</div>

				<div class="tab-pane" id="following">
					<p>This tab will show a list of the people you are following</p>
				</div>

				<div class="tab-pane" id="trophies">
					<p>This tab will show a list of the trophies you have earned</p>
				</div>
			</div>
		</div>
	</div> 
</body>
</html>