function BuildHTML(html) {
	document.getElementById("controlAddIn").innerHTML = html;
}

function AppendHTMLDefault(elementText) {
	//overloaded functions are not supported
	AppendHTML('HTMLBox', elementText)
}

function AppendHTML(elementId, elementText) {
	var BoxElement = document.getElementById(elementId);
	if (BoxElement == null) {
		BoxElement = document.createElement('div');

		BoxElement.setAttribute('id', elementId);
		BoxElement.setAttribute('class', 'HTMLBox');

		BoxElement.innerHTML = elementText;

		document.getElementById("controlAddIn").appendChild(BoxElement);
	} else {
		BoxElement.innerHTML = elementText;
	}
}

function AddPictureFromUrl(picturePath, pictureSize) {
	AppendHTML('NoPictureMessage', '');
	if (picturePath == '' || picturePath == 'data:image;base64,') {
		AppendHTML('NoPictureMessage', 'No picture');

		document.getElementById("Picture").remove();
		window.frameElement.style.minHeight = '100px';
		window.frameElement.style.height = '100px';

		return;
	}

	var PictureDiv = document.getElementById("PictureDiv");
	if (PictureDiv == null) {
		PictureDiv = document.createElement('div');

		PictureDiv.setAttribute('id', 'PictureDiv');
		PictureDiv.setAttribute('class', 'PictureDiv');
	}

	var Picture = document.getElementById("Picture");
	if (Picture == null) {
		Picture = document.createElement('img');
		Picture.setAttribute('id', 'Picture');
		Picture.setAttribute('class', 'Picture');
	}

	Picture.setAttribute('src', picturePath);

	document.getElementById("controlAddIn").appendChild(PictureDiv);
	document.getElementById("PictureDiv").appendChild(Picture);

	window.frameElement.style.minHeight = pictureSize + 'px';
	window.frameElement.style.maxHeight = pictureSize + 'px';
	window.frameElement.style.height = pictureSize + 'px';
}

function AddPictureFromBase64(pictureBase64, pictureSize) {
	AddPictureFromUrl('data:image;base64,' + pictureBase64, pictureSize)
}