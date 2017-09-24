
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0
import Qt.labs.controls.universal 1.0

Button{
    id:control
    property bool isAppType: false
    property string backroundColor: "green"
    property string textColor: "white"
    background: Rectangle {
         width:  control.width
         height: control.height


         opacity: enabled ? 1 : 0.3
         color: control.pressed ? "lightgreen":  backroundColor
         border.color: control.pressed ? "lightgreen" : backroundColor
     }


    label: Text {
          x: control.leftPadding
          y: control.topPadding
          width: control.availableWidth
          height: control.availableHeight
          text: control.text
          font: control.font
          opacity: enabled || highlighted ? 1 : 0.3
          color: textColor
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          elide: Text.ElideRight
      }
}
