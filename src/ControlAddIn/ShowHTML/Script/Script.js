// Ensure the container exists
function GetContainer() {
    var container = document.getElementById("controlAddIn");
    if (container == null) {
        container = document.createElement('div');
        container.id = "controlAddIn";
        document.body.appendChild(container);
    }
    return container;
}

function EncodeHtml(text) {
    var element = document.createElement('span');
    element.innerText = text;
    return element.innerHTML;
}

function InitializeControlAddIn() {
    var container = GetContainer();
    container.innerHTML = '';

    var clickArea = document.createElement('div');
    clickArea.id = 'ClickArea';
    clickArea.style.border = '1px solid #666';
    clickArea.style.padding = '8px';
    clickArea.style.cursor = 'pointer';
    clickArea.style.display = 'inline-block';
    clickArea.innerText = 'click me';
    clickArea.addEventListener('click', function () {
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('AddInClicked', ['The add-in was clicked']);
    });

    container.appendChild(clickArea);
}

// BuildHTML / SetHtml
function BuildHTML(html) {
    var container = GetContainer();
    container.innerHTML = html;
}

function SetHtml(htmlText) {
    BuildHTML(htmlText);
}

// AppendHTMLDefault
function AppendHTMLDefault(elementText) {
	//overloaded functions are not supported
	AppendHTML('HTMLBox', elementText);
}

function AppendHTML(elementId, elementText) {
    var BoxElement = document.getElementById(elementId);
    if (BoxElement == null) {
        BoxElement = document.createElement('div');

        BoxElement.setAttribute('id', elementId);
        BoxElement.setAttribute('class', 'HTMLBox');
        document.getElementById("controlAddIn").appendChild(BoxElement);
    }
    BoxElement.innerHTML = elementText;
}

// Add picture from URL
function AddPictureFromUrl(picturePath, pictureSize) {
    AppendHTML('NoPictureMessage', '');
    if (!picturePath || picturePath == 'data:image;base64,') {
        AppendHTML('NoPictureMessage', 'No picture');
        var pic = document.getElementById("Picture");
        if (pic) pic.remove();
        window.frameElement.style.height = '100px';
        return;
    }

    var PictureDiv = document.getElementById("PictureDiv");
    if (!PictureDiv) {
        PictureDiv = document.createElement('div');
        PictureDiv.id = 'PictureDiv';
        PictureDiv.className = 'PictureDiv';
        GetContainer().appendChild(PictureDiv);
    }

    var Picture = document.getElementById("Picture");
    if (!Picture) {
        Picture = document.createElement('img');
        Picture.id = 'Picture';
        Picture.className = 'Picture';
        PictureDiv.appendChild(Picture);
    }

    Picture.src = picturePath;

    window.frameElement.style.height = pictureSize + 'px';
}

// Add picture from Base64
function AddPictureFromBase64(pictureBase64, pictureSize) {
    AddPictureFromUrl('data:image;base64,' + pictureBase64, pictureSize);
}

function ShowTwoTexts(firstName, lastName) {
    SetHtml(
        '<span style="color:red;">' + EncodeHtml(firstName) + '</span> ' +
        '<span style="color:green;">' + EncodeHtml(lastName) + '</span>'
    );
}