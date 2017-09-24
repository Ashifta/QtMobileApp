
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0
import Qt.labs.controls.universal 1.0

Rectangle
{
    width: appWindow.width -20
    height:text.height+indicator.height+layout.height
    color: "white"
    radius: 10
    ColumnLayout
    {
        id:layout
        spacing: 20
        anchors.centerIn: parent

    Text
    {
        id:text
        anchors.horizontalCenter: parent.horizontalCenter
        text:"Please wait..."
    }

    BusyIndicator {
        id:indicator
        running:true
        anchors.horizontalCenter: parent.horizontalCenter
    }
    }
}

