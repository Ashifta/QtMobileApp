import QtQuick 2.6
import QtQuick.Layouts 1.3
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0
import Qt.labs.controls.universal 1.0

Item{
    id:root

Pane {
           id: pane
           anchors.fill: parent
           Image {
               id: background
               width: stackView.availableWidth
               height: stackView.availableHeight
               anchors.centerIn: parent
               fillMode: Image.PreserveAspectFit
               source: "qrc:/res/drawable-mdpi/login_background.png"
           }


           Image {
               id: logo
               x: stackView.availableWidth/2
               y: stackView.availableHeight/4
               fillMode: Image.PreserveAspectFit
               source: "qrc:/res/drawable/car_front_icon.png"
               transform: Rotation {angle: 218}
               }


           Image {
               id: locationLogo
               x: stackView.availableWidth/2+locationLogo.width/4
               y: stackView.availableHeight/2-locationLogo.height/2
               width: logo.width*2
               fillMode: Qt.KeepAspectRatio
               source: "qrc:/res/drawable/car_front_icon.png"
               }

           Text
           {
               id:label
               x:locationLogo.x
               y:stackView.availableHeight/2
               text: "Get Around With Us";
           }

       SequentialAnimation {
           id:seqAnumation
           running: true
           NumberAnimation {  easing.type: Easing.OutBounce;
               target: logo; property: "y"; to: stackView.availableHeight/2+logo.height/2; duration: 1000 }
           NumberAnimation {
               target: logo; property: "rotation"; to: 152; duration: 300 }
           NumberAnimation { target: logo; property: "x"; to: logo.width; duration: 400 }
           PropertyAnimation { target: locationLogo; property: "visible"; to: true; }
           NumberAnimation { target: locationLogo; property: "x"; to: locationLogo.width/1.5; duration: 400 }
           PropertyAnimation { target: label; property: "visible"; to: true; }
           NumberAnimation { target: label; property: "y"; from:locationLogo.x; to: logo.x+logo.width/3; duration: 400 }

           onStopped: {
               stackView.replace("qrc:/pages/loginform.qml")
           }
       }


}
Component.onCompleted: {
    locationLogo.visible = false
    label.visible = false
}

Component.onDestruction:  {
    console.log("onDestroy")
}
}
