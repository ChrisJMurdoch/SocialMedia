<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Picturn</title>
	<script src="./javascript/script.js"></script>
	<script src="./javascript/profile.js" defer></script>
	<link rel="stylesheet" href="./css/style.css">
	<link rel="stylesheet" href="./css/profile.css">
	<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;400;500;600;700&display=swap"
		  rel="stylesheet">
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
		<a href="users/<%=session.getAttribute(" username")%>"><%=session.getAttribute("username")%></a>
		<a href="logout">Log Out</a>
	</div>
</nav>
<div class="container">
	<div class="profile-head">
		<img src="defaultIcon.jpg " width="200" alt="">
		<div class="profile-info">
			<h3 class="user-name">Username</h3>
			<p class="bio">Insert bio here...</p>
			<p>Joined on ...</p>
		</div>
		<div class="scores">
			<p><strong>Score:</strong> 10020</p>
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
			<li data-tab-target="#posts" class="tab active">Posts</a></li>
			<li class="tab" id="Followers">Followers</a></li>
			<li class="tab" id="Following">Following</a></li>
			<li data-tab-target="#trophies" class="tab">Trophies</a></li>
		</ul>
		<div class="tab-content">
			<div class="active" id="posts" tab-pane>
				<div class="gallery">
					<a target="_blank"
					   href="https://composeclick.com/wp-content/uploads/2018/05/nature-1-1024x637.jpg">
						<img src="https://composeclick.com/wp-content/uploads/2018/05/nature-1-1024x637.jpg"
							 alt="pic" width="600" height="400">
					</a>
					<div class="desc">
						description
					</div>
				</div>
				<div class='gallery'>
					<a target="_blank"
					   href="https://composeclick.com/wp-content/uploads/2018/05/nature-2-1024x576.jpg">
						<img src="https://composeclick.com/wp-content/uploads/2018/05/nature-2-1024x576.jpg"
							 alt="Forest" width="600" height="400">
					</a>
					<div class="desc">
						description
					</div>
				</div>
				<div class='gallery'>
					<a target="_blank"
					   href="https://composeclick.com/wp-content/uploads/2020/06/Golden-Hour-Image1-1536x1025.jpg">
						<img src="https://composeclick.com/wp-content/uploads/2020/06/Golden-Hour-Image1-1536x1025.jpg"
							 alt="Forest" width="600" height="400">
					</a>
					<div class="desc">
						description
					</div>
				</div>
				<div class='gallery'>
					<a target="_blank"
					   href="https://composeclick.com/wp-content/uploads/2020/06/Golden-Hour-Image2-1536x1025.jpg">
						<img src="https://composeclick.com/wp-content/uploads/2020/06/Golden-Hour-Image2-1536x1025.jpg"
							 alt="Forest" width="600" height="400">
					</a>
					<div class="desc">
						description
					</div>
				</div>
				<div class='gallery'>
					<a target="_blank"
					   href="https://composeclick.com/wp-content/uploads/2020/06/Golden-Hour-Image3-1536x1024.jpg">
						<img src="https://composeclick.com/wp-content/uploads/2020/06/Golden-Hour-Image3-1536x1024.jpg"
							 alt="Forest" width="600" height="400">
					</a>
					<div class="desc">
						description
					</div>
				</div>
				<div class='gallery'>
					<a target="_blank"
					   href="https://composeclick.com/wp-content/uploads/2020/06/Golden-Hour-Image4-1536x1024.jpg">
						<img src="https://composeclick.com/wp-content/uploads/2020/06/Golden-Hour-Image4-1536x1024.jpg"
							 alt="Forest" width="600" height="400">
					</a>
					<div class="desc">
						description
					</div>
				</div>
				<div class='gallery'>
					<a target="_blank"
					   href="https://composeclick.com/wp-content/uploads/2020/06/Golden-Hour-Image6-1536x1024.jpg">
						<img src="https://composeclick.com/wp-content/uploads/2020/06/Golden-Hour-Image6-1536x1024.jpg"
							 alt="Forest" width="600" height="400">
					</a>
					<div class="desc">
						description
					</div>
				</div>
				<div class='gallery'>
					<a target="_blank"
					   href="https://composeclick.com/wp-content/uploads/2020/06/Golden-Hour-Image8-1536x1025.jpg">
						<img src="https://composeclick.com/wp-content/uploads/2020/06/Golden-Hour-Image8-1536x1025.jpg"
							 alt="Forest" width="600" height="400">
					</a>
					<div class="desc">
						description
					</div>
				</div>

			</div>
			<!--
            <div id="followers" tab-pane>
                <p>This tab will show a list of the people that are following your account</p>
            </div> -->

			<!-- <div class="tab-pane" id="following" tab-pane>
                <p>This tab will show a list of the people you are following</p>
            </div> -->

			<div class="tab-pane" id="trophies" tab-pane>
				<div class="achievement">
					<div class="achie-item">
						<div class="achie-image">
							<img src="./image/10.png" alt="">
						</div>
						<div class="achie-text">
							<p>
								<span style="font-weight: bold;">10/10:</span><span>upload10 posts(250pts)</span>

							</p>

						</div>
					</div>
					<div class="achie-item">
						<div class="achie-image">
							<img src="./image/foodie.png" alt="">
						</div>
						<div class="achie-text">
							<p>
								<span style="font-weight: bold;">Foodie:</span><span>Have the topost on food
										(90pts)</span>

							</p>

						</div>
					</div>
					<div class="achie-item">
						<div class="achie-image">
							<img src="./image/rise.png" alt="">
						</div>
						<div class="achie-text">
							<p>
								<span style="font-weight: bold;">Miss Popular:</span><span>Gain 50
										followers(50pts)</span>

							</p>

						</div>
					</div>
					<div class="achie-item">
						<div class="achie-image">
							<img src="./image/pic.png" alt="">
						</div>
						<div class="achie-text">
							<p>
								<span style="font-weight: bold;">Start:</span><span>Upload your first post
										(1000pts)</span>

							</p>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="cont" id="cont">
	<div class="fans-item" id="fans">
		<div class="fans-headers">
			<div></div>
			<div><span>Followers</span></div>
			<div id="fansCloesBtn">
				X
			</div>
		</div>
		<div class="fans-body">
			<div class="fans-list">
				<div class="list-headers">
					<div class="fans-icon">
						<img src="./image/male.png" alt="">
					</div>
					<div class="fans-textgroup">
						<div class="fans-name">chirs.romer095</div>
						<div class="fans-text">Chiristopher Damian rOMERO</div>
					</div>
				</div>
				<div><button class="fans-btn">Follow</button></div>
			</div>
			<div class="fans-list">
				<div class="list-headers">
					<div class="fans-icon">
						<img src="./image/female.png" alt="">
					</div>
					<div class="fans-textgroup">
						<div class="fans-name">sahoodhoni</div>
						<div class="fans-text">dhoni sahoo1</div>
					</div>
				</div>
				<div><button class="fans-btn">Follow</button></div>
			</div>
			<div class="fans-list">
				<div class="list-headers">
					<div class="fans-icon">
						<img src="https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3043904798,91034843&fm=15&gp=0.jpg"
							 alt="">
					</div>
					<div class="fans-textgroup">
						<div class="fans-name">paglinawanmanilyn</div>
						<div class="fans-text">Manilyn Villamor Paglinawan</div>
					</div>
				</div>
				<div><button class="fans-btn">Follow</button></div>
			</div>
			<div class="fans-list">
				<div class="list-headers">
					<div class="fans-icon">
						<img src="https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2470744323,1870155875&fm=15&gp=0.jpg"
							 alt="">
					</div>
					<div class="fans-textgroup">
						<div class="fans-name">lobrdt</div>
						<div class="fans-text">Loic Bordinat</div>
					</div>
				</div>
				<div><button class="fans-btn">Follow</button></div>
			</div>
			<div class="fans-list">
				<div class="list-headers">
					<div class="fans-icon">
						<img src="https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3716438606,4272118910&fm=26&gp=0.jpg"
							 alt="">
					</div>
					<div class="fans-textgroup">
						<div class="fans-name">mtuffy7rd</div>
						<div class="fans-text">mtuffy7rd</div>
					</div>
				</div>
				<div><button class="fans-btn">Follow</button></div>
			</div>
			<div class="fans-list">
				<div class="list-headers">
					<div class="fans-icon">
						<img src="https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1428393749,2021466125&fm=26&gp=0.jpg"
							 alt="">
					</div>
					<div class="fans-textgroup">
						<div class="fans-name">qusje2021</div>
						<div class="fans-text"> </div>
					</div>
				</div>
				<div><button class="fans-btn">Follow</button></div>
			</div>
			<div class="fans-list">
				<div class="list-headers">
					<div class="fans-icon">
						<img src="https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3427721999,292838447&fm=26&gp=0.jpg"
							 alt="">
					</div>
					<div class="fans-textgroup">
						<div class="fans-name">bangoludorcas</div>
						<div class="fans-text">bangoludorcas</div>
					</div>
				</div>
				<div><button class="fans-btn">Follow</button></div>
			</div>
			<div class="fans-list">
				<div class="list-headers">
					<div class="fans-icon">
						<img src="https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3363067319,2126479047&fm=15&gp=0.jpg"
							 alt="">
					</div>
					<div class="fans-textgroup">
						<div class="fans-name">paglinawanmanilyn</div>
						<div class="fans-text">Manilyn Villamor Paglinawan</div>
					</div>
				</div>
				<div><button class="fans-btn">Follow</button></div>
			</div>
			<div class="fans-list">
				<div class="list-headers">
					<div class="fans-icon">
						<img src="https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2386847201,3939426394&fm=26&gp=0.jpg"
							 alt="">
					</div>
					<div class="fans-textgroup">
						<div class="fans-name">rauwalejandro</div>
						<div class="fans-text">RA'RAUW</div>
					</div>
				</div>
				<div><button class="fans-btn">Follow</button></div>
			</div>
			<div class="fans-list">
				<div class="list-headers">
					<div class="fans-icon">
						<img src="https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3544464364,1804156664&fm=26&gp=0.jpg"
							 alt="">
					</div>
					<div class="fans-textgroup">
						<div class="fans-name">amandascogorman</div>
						<div class="fans-text">Amanda Gorman</div>
					</div>
				</div>
				<div><button class="fans-btn">Follow</button></div>
			</div>
		</div>
	</div>
	<div class="Focus" id="Focus">
		<div class="Focus-headers">
			<div></div>
			<div>Following</div>
			<div id="FocusCloseBtn">X</div>
		</div>
		<div class="Focus-body">
			<div class="Focus-tabs">
				<div class="Focus-btn">Users</div>
				<div class="Focus-btn">Tag</div>
			</div>
			<!-- 用户 -->
			<div class="Focus-items user focusActive">
				<div class="Focus-item">
					<div class="list-headers">
						<div class=" Focus-icon ">
							<img src="./image/male.png" alt="">
						</div>
						<div class="fans-textgroup">
							<div class="fans-name">rauwalejandro <span> </span></div>
							<div class="fans-text">RA'RAUW</div>
						</div>
					</div>
					<div><button class="fans-btn">Follow</button></div>
				</div>
				<div class="Focus-item">
					<div class="list-headers">
						<div class=" Focus-icon ">
							<img src="https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1594903615,3689357974&fm=15&gp=0.jpg"
								 alt="">
						</div>
						<div class="fans-textgroup">
							<div class="fans-name">rauwalejandro <span> </span></div>
							<div class="fans-text">RA'RAUW</div>
						</div>
					</div>
					<div><button class="fans-btn">Follow</button></div>
				</div>
				<div class="Focus-item">
					<div class="list-headers">
						<div class=" Focus-icon ">
							<img src="https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=337181696,633690347&fm=15&gp=0.jpg"
								 alt="">
						</div>
						<div class="fans-textgroup">
							<div class="fans-name">amandascgorman <span> </span></div>
							<div class="fans-text">Amanda Gorman</div>
						</div>
					</div>
					<div><button class="fans-btn">Follow</button></div>
				</div>
				<div class="Focus-item">
					<div class="list-headers">
						<div class=" Focus-icon ">
							<img src="https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2620299005,2522801282&fm=15&gp=0.jpg"
								 alt="">
						</div>
						<div class="fans-textgroup">
							<div class="fans-name">grahamelloot <span> </span></div>
							<div class="fans-text">GRAHAM ELLIOT</div>
						</div>
					</div>
					<div><button class="fans-btn">Follow</button></div>
				</div>
				<div class="Focus-item">
					<div class="list-headers">
						<div class=" Focus-icon ">
							<img src="https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1518854441,2276837890&fm=15&gp=0.jpg"
								 alt="">
						</div>
						<div class="fans-textgroup">
							<div class="fans-name">evanfunke <span> </span></div>
							<div class="fans-text">EVAN FUNKE</div>
						</div>
					</div>
					<div><button class="fans-btn">Follow</button></div>
				</div>
				<div class="Focus-item">
					<div class="list-headers">
						<div class=" Focus-icon ">
							<img src="https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3052425860,661413889&fm=26&gp=0.jpg"
								 alt="">
						</div>
						<div class="fans-textgroup">
							<div class="fans-name">chefmarcela <span> </span></div>
							<div class="fans-text">Marcela Valladolid</div>
						</div>
					</div>
					<div><button class="fans-btn">Follow</button></div>
				</div>
				<div class="Focus-item">
					<div class="list-headers">
						<div class=" Focus-icon ">
							<img src="https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3119205313,1229202629&fm=26&gp=0.jpg"
								 alt="">
						</div>
						<div class="fans-textgroup">
							<div class="fans-name">fork_knife <span> </span></div>
							<div class="fans-text">Jordan Andino</div>
						</div>
					</div>
					<div><button class="fans-btn">Follow</button></div>
				</div>
				<div class="Focus-item">
					<div class="list-headers">
						<div class=" Focus-icon ">
							<img src="https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1860330989,1446321258&fm=26&gp=0.jpg"
								 alt="">
						</div>
						<div class="fans-textgroup">
							<div class="fans-name">kelis <span> </span></div>
							<div class="fans-text">kelis</div>
						</div>
					</div>
					<div><button class="fans-btn">Follow</button></div>
				</div>
			</div>
			<!-- 话题标签 -->
			<div class="Focus-items set"></div>
		</div>
	</div>
</div>
</body>
<script>

</script>

</html>