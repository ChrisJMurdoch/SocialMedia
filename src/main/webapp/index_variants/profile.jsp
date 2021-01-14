<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Picturn</title>
	<script src="../javascript/script.js"></script>
	<script src="../javascript/profile.js" defer></script>
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
		<div class = "profile-head">
			<img src="defaultIcon.jpg " width="200" alt="">
			<div class="profile-info">
				<h3 class="user-name">Username</h3>
				<p class="bio">Insert bio here...</p>
				<p>Joined on ...</p>
			</div>
			<div class="scores">
				<p><strong>Score:</strong>  10020</p>
                <p><strong>Rating:</strong> <span class="fa fa-star checked"></span>
					<span class="fa fa-star checked"></span>
					<span class="fa fa-star checked"></span>
					<span class="fa fa-star"></span>
					<span class="fa fa-star"></span>
				</p>
			</div>
		</div>
		<div class="main-content">
			<ul class="nav-tabs">
				<li data-tab-target = "#posts" class="tab" >Posts</a></li>
				<li data-tab-target = "#followers" class="tab">Followers</a></li>
				<li data-tab-target = "#following" class="tab">Following</a></li>
				<li data-tab-target = "#trophies" class="tab">Trophies</a></li>
			</ul>
			<div class="tab-content">
				<div class="active" id="posts" tab-pane >
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

				<div id="followers" tab-pane >
					<p>This tab will show a list of the people that are following your account</p>
				</div>

				<div class="tab-pane" id="following" tab-pane >
					<p>This tab will show a list of the people you are following</p>
				</div>

				<div class="tab-pane" id="trophies" tab-pane >
					<p>This tab will show a list of the trophies you have earned</p>
				</div>
			</div>
		</div>
	</div> 
</body>
</html>