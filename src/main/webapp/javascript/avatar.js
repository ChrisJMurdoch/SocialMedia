window.onload = function () {
		
var avatarHead = new Image();
var numHead = Math.floor(Math.random()*5)+1;

var avatarEyes = new Image();
var numEyes = Math.floor(Math.random()*5)+1;

var avatarMouth = new Image();
var numMouth = Math.floor(Math.random()*5)+1;
				
avatarHead.src="avatars/head"+numHead+".png";
avatarEyes.src="avatars/eyes"+numEyes+".png";
avatarMouth.src="avatars/mouth"+numMouth+".png";

		
avatarHead.onload = function () {
	buildAvatar();
}

avatarEyes.onload = function () {
	buildAvatar();
}

avatarMouth.onload = function () {
	buildAvatar();
}
		
function buildAvatar() {
	var canvas=document.getElementById('canvas');
	var ctx = canvas.getContext('2d');
			
	canvas.width=400;
	canvas.height=400;
			
	ctx.drawImage(avatarHead, ((400-avatarHead.width)/2),5);
	ctx.drawImage(avatarEyes, ((400-avatarEyes.width)/2),-20);
	ctx.drawImage(avatarMouth, ((400-avatarMouth.width)/2),80);

	}
		
}