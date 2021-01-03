
function show(id) {
    document.getElementById(id).style.visibility = "visible";
}

function switchDisplayed(from, to) {
	document.getElementById(from).style.visibility = "hidden";
    document.getElementById(to).style.visibility = "visible";
}
