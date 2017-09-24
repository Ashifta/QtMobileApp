
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0
import Qt.labs.controls.universal 1.0
import "../controls"

Rectangle {
    id:root
    color: "green"
    Image {
        id: name
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        source: "qrc:/res/drawable/car_front_icon.png"
    }
    RowLayout{
               anchors.bottom: parent.bottom
    MyButton{
        id:loginControl
       anchors.left: parent.left
       backroundColor:"white"
       textColor:"gray"
       Layout.preferredWidth: root.width/2 -10
       Layout.margins: 5
       text: "Login"
       onClicked: {
            stackView.push("qrc:/pages/login.qml")
       }
    }
    MyButton{
        id:logoutControl
        Layout.preferredWidth: root.width/2 -10
        backroundColor:"gray"
        textColor:"black"
        Layout.margins: 5
        text: "Signup"
        onClicked: {
            stackView.push("qrc:/pages/signup.qml")
        }

    }



    }

   Component.onCompleted: {
        appWindow.hideHeader =  true
   }
}

