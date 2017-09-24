
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0
import Qt.labs.controls.universal 1.0

Row{
    property alias icon1: icon1.source
    property alias icon2: icon2.source
    Image {
        id: icon1
        width:   64
        height:  64


    }Image {
        id: icon2
        width: 64
        height: 64
    }
}
