import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0
import Qt.labs.controls.universal 1.0
import "../controls"
import networkmanager 1.0

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
            id:column
            //anchors.top:   parent.top
            anchors.horizontalCenter: whileBackground.horizontalCenter
            //height: whileBackground.height/2
            width: whileBackground.width
            Image {
                id: logo
                Layout.margins: 5
                Layout.preferredWidth:whileBackground.width-10
                fillMode: Image.PreserveAspectFit
                source: "qrc:/res/drawable/car_front_icon.png"
            }

            MyTextField
            {
               id:userName
               Layout.preferredWidth:whileBackground.width-10
               imageIcon: "qrc:/res/drawable/user.png"
               placeHolder: qsTr("UserName")
            }
            MyTextField
            {
               id:password
               Layout.preferredWidth:whileBackground.width-10
               imageIcon: "qrc:/res/drawable/pass.png"
               placeHolder: qsTr("Password")
               echoMode: TextInput.Password
            }
            MyButton{
                id:buttonLogin
                enabled: ( userName.text.length != 0 && password.text.length != 0 )
                Layout.margins: 5
                Layout.preferredWidth:whileBackground.width-10
                text: "LOGIN"
                onClicked:
                {
                    networkManager.loginAction(userName.text, password.text)
                }
            }

            Text{
                Layout.leftMargin:  5
                Layout.rightMargin: 5
                Layout.preferredWidth:whileBackground.width-10
                font.pixelSize: 10
                anchors.bottomMargin: 50

                id:referelCodeText
                text:"<a href='www.google.com'>Forget Password?</a>"
                onLinkActivated: {
                    stackView.push("qrc:/pages/forgetpassword.qml")
                }
                wrapMode: Text.Wrap

            }
            Rectangle
            {
                id:line
                Layout.margins: 5
                Layout.preferredWidth:whileBackground.width-10
                border.width: 1
                //anchors.topMargin: 30

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
                anchors.horizontalCenter:  line.horizontalCenter
                Layout.topMargin: 20
                Layout.bottomMargin: 5
//                Layout.preferredWidth:whileBackground.width-10
                color: "gray"
            }
            MyIconRow
            {
                anchors.horizontalCenter: column.horizontalCenter
                spacing: 25
                anchors.margins: 5
                icon1:  "qrc:/res/drawable/fb_icon.png"
                icon2:  "qrc:/res/drawable/google_logo.png"
            }
        }

    }
    Component.onCompleted:{

        appWindow.showPostHomeState = true
    }
    Component.onDestruction:{
        console.log("login destroid")
    }
    Connections{
        target: networkManager
        onResponseRecieved:{
            //console.log("networkManager")
               //var resPonse = JSON.parse(networkManager.response)
               //console.log(resPonse)
        }
    }
}

