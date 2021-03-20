const myCanvas = document.getElementById('canvas');
const ctx = canvas.getContext('2d');

function DownloadCanvasAsImage() {
	let downloadLink = document.createElement('a');
	downloadLink.setAttribute('download', 'newAvatarPic.png');
	let myCanvas = document.getElementById('canvas');
 	let dataURL = myCanvas.toDataURL('image/png');
  	let url = dataURL.replace(/^data:image\/png/,'data:application/octet-stream');
	downloadLink.setAttribute('href',url);
	downloadLink.click();
}	