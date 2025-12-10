controladdin ShowHTML
{
    Scripts = 'src/ControlAddin/ShowHTML/Script/Script.js';
    StartupScript = 'src/ControlAddin/ShowHTML/Script/Start.js';
    StyleSheets = 'src/ControlAddin/ShowHTML/StyleSheet/Default.css';

    HorizontalStretch = true;
    HorizontalShrink = true;
    VerticalStretch = true;
    VerticalShrink = true;

    event ControlAddInReady();
    procedure AddPictureFromUrl(picturePath: Text; pictureSize: Text);
    procedure AddPictureFromBase64(pictureBase64: Text; pictureSize: Text);

    procedure BuildHTML(html: Text);
    procedure AppendHTMLDefault(elementText: Text);
    procedure AppendHTML(elementId: Text; elementText: Text);
}