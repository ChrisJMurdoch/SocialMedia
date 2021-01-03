
// Show/hide elements
function show(id1, id2) {
    document.getElementById(id1).style.visibility = "visible";
    if (id2) document.getElementById(id2).style.visibility = "visible";
}
function hide(id1, id2) {
    document.getElementById(id1).style.visibility = "hidden";
    if (id2) document.getElementById(id2).style.visibility = "hidden";
}
function switchDisplayed(from, to) {
	document.getElementById(from).style.visibility = "hidden";
    document.getElementById(to).style.visibility = "visible";
}

// Image submission preview

function displayImage(event) {
    document.getElementById('file_label').style.backgroundImage = "url('" + URL.createObjectURL(event.target.files[0]) + "')";
    document.getElementById('file_label').style.color = "rgba(0,0,0,0)";
}
