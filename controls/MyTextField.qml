
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0
import Qt.labs.controls.universal 1.0

TextField {
    id:root
    property alias placeHolder: root.placeholderText
    property alias imageIcon: textIcon.source
    leftPadding: 30
    Layout.margins: 5
    font.pixelSize:12
    placeholderText: qsTr("Username")
    Image {
        id:textIcon
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
     }
}
