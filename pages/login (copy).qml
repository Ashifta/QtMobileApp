
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0
import Qt.labs.controls.universal 1.0
import "../controls"

Item {

    Image {
        id: background
        width: stackView.availableWidth
        height: stackView.availableHeight
        anchors.centerIn: parent

        fillMode: Image.PreserveAspectFit
        source: "qrc:/res/drawable-mdpi/login_background.png"
    }

    Rectangle {
        id: whileBackground
        width: stackView.availableWidth - 40.
        height: stackView.availableHeight -60
        anchors.centerIn: parent
        //opacity: .5
        ColumnLayout{
            anchors.top:   parent.top
            width: whileBackground.width
            height: whileBackground.height/2
            Image {
                id: logo
                anchors.top:  parent.top
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "qrc:/res/drawable-xhdpi/ic_launcher.png"
            }

            TextField {
                id:userName
                height: whileBackground.height/10
                anchors.top: logo.bottom
                anchors.topMargin: 10
                //anchors.horizontalCenter: logo.horizontalCenter

                anchors.left: parent.left
                anchors.right: parent.right

                placeholderText: qsTr("Username")
            }
            TextField {
                id:password
                height: whileBackground.height/10
                anchors.top: userName.bottom
                anchors.topMargin: 10
                //anchors.horizontalCenter: userName.horizontalCenter

                anchors.left: parent.left
                anchors.right: parent.right
                placeholderText: qsTr("Password")
            }
            MyButton{
                id:buttonLogin
                anchors.top: password.bottom
                height: 10

                anchors.topMargin: 10
                //anchors.horizontalCenter: password.horizontalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                text: "LOGIN"
            }
            Text{
                id:forgotLabel
                anchors.top: buttonLogin.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: buttonLogin.horizontalCenter
                text:"Forgot password?"
                font.pixelSize: 10
                anchors.bottomMargin: 50

            }
            Rectangle
            {
                id:line
                anchors.top: forgotLabel.bottom
                anchors.horizontalCenter: forgotLabel.horizontalCenter
                border.width: 1
                anchors.topMargin: 30
                width: whileBackground.width
                height: 1
                color: "gray"
                //anchors.centerIn: whileBackground

                Rectangle{
                    border.width: 3
                    width: 30
                    height: 30
                    radius: 15
                    border.color: "gray"

                    color: "white"
                    anchors.centerIn: line
                }
                Text{
                    text: "Or"
                    anchors.centerIn: line
                    color: "gray"
                }
            }
            Text{
                id:loginUsing
                text: "Login using"
                anchors.top: line.bottom
                //height: whileBackground.height/10
                anchors.topMargin: 20
                anchors.horizontalCenter: line.horizontalCenter
                color: "gray"
            }
            Rectangle{
                id:fbgoogleIcon
                anchors.top: loginUsing.bottom
                //height: whileBackground.height/10
                anchors.horizontalCenter: loginUsing.horizontalCenter
                Row{
                    spacing: 50
                    anchors.horizontalCenter: fbgoogleIcon.horizontalCenter
                    Image {
                        id: fb
                        source: "qrc:/res/drawable/fb_icon.png"
                    }Image {
                        id: google
                        source: "qrc:/res/drawable/google_logo.png"
                    }
                }

            }
        }

    }

}

