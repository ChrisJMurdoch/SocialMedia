
function action(post_id, post_id) {
	elem = document.getElementById('like_button_'+post_id);

	// Get current state
	let liked = elem.getAttribute('liked') === 'true';
	let url = window.location.href + ( liked ? 'unlike' : 'like' );

	// POST data
	let req = new XMLHttpRequest();
	req.open("POST", url);
	req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	req.send('post_id='+post_id);

	// Toggle and update local data
	liked = !liked;
	elem.setAttribute('liked', liked);
	elem.setAttribute('src', liked ? '../images/heart-filled.png' : '../images/heart-empty.png');

	// Change like number
	let change = liked ? 1 : -1;
	let number = document.getElementById('like_number_'+post_id);
	number.innerText = parseInt(number.innerText) + change;
}
