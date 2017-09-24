
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0
import Qt.labs.controls.universal 1.0

Rectangle
{
    id:errorBackground
    property alias headerText : errorheader.text
    property alias messageText : errorContent.text
    width: appWindow.width -20
    height: errorheader.height + lineRect.height + errorContent.height + okButton.height +(20*4)
    color: "white"
    radius: 5
    anchors.centerIn: parent
    ColumnLayout
    {
        anchors.centerIn: parent
        spacing: 20
        Text {
            id: errorheader
            Layout.preferredWidth:errorBackground.width-10
            color: "blue"
            wrapMode:Text.Wrap
            //text: qsTr("text")
        }
        Rectangle
        {
            id:lineRect
            color: "green"
            Layout.preferredWidth:errorBackground.width-10
            height: 2
        }
        Text {
            id: errorContent
            Layout.preferredWidth:errorBackground.width-10
            color: "blue"
            //text: qsTr("there is no internet connection!!!!")
            wrapMode:Text.Wrap
        }
        MyButton{
            id:okButton
           anchors.right: parent.right
           Layout.preferredWidth: errorBackground.width/3-10
           text: "OK"
           onClicked: {
                errorBackground.visible = false
           }
        }
    }
}
