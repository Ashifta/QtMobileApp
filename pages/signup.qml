
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

    Flickable{
           flickableDirection: Flickable.VerticalFlick
           anchors.fill: parent
           contentHeight: whileBackground.height
           bottomMargin: 500
    Rectangle {
        id: whileBackground
        width: stackView.availableWidth - 40.
        height: stackView.availableHeight -60
        anchors.centerIn: parent

        //opacity: .5
        ColumnLayout{
            id:layout
            anchors.top:   parent.top
            anchors.horizontalCenter: whileBackground.horizontalCenter
            //height: whileBackground.height/2
            width: whileBackground.width
            //spacing: 10
          //  Rectangle{
            //    id:iconRect
                //implicitHeight:  fb.width*2
                //anchors.horizontalCenter: layout.horizontalCenter
                //Layout.preferredWidth:whileBackground.width-fb.width/2
                //Layout.margins: fb.width/2

            MyIconRow
            {
                anchors.horizontalCenter: layout.horizontalCenter
                spacing: 25
                anchors.margins: 5
                icon1:  "qrc:/res/drawable/fb_icon.png"
                icon2:  "qrc:/res/drawable/google_logo.png"
            }
            //}

            Rectangle
            {
                id:line
                border.width: 1
                Layout.preferredWidth:whileBackground.width-10
                Layout.margins: 5
                height: 1
                color: "gray"
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

            MyTextField
            {
               id:userName
               Layout.preferredWidth:whileBackground.width-10
               imageIcon: "qrc:/res/drawable/user.png"
               placeHolder: qsTr("UserName")
            }

            MyTextField
            {
               id:fullName
               Layout.preferredWidth:whileBackground.width-10
               imageIcon: "qrc:/res/drawable/user.png"
               placeHolder: qsTr("FullName")
            }


            Row{
                id:phoneNumber
                spacing: 20
                Layout.margins: 5
                Layout.preferredWidth:whileBackground.width-10

              TextField {
                id:contryCode
                width: whileBackground.width/4
                placeholderText: qsTr("+91")
            }

            TextField {
                id:phoneNum
                width: whileBackground.width/2
                placeholderText: qsTr("7760889950")
            }
            }

            TextField {
                id:mailId
                Layout.margins: 5
                Layout.preferredWidth:whileBackground.width-10
                placeholderText: qsTr("Mail id")
            }


            MyTextField
            {
               id:password
               Layout.preferredWidth:whileBackground.width-10
               imageIcon: "qrc:/res/drawable/pass.png"
               placeHolder: qsTr("Password")
            }

            Text{
                id:referelCodeText
                Layout.margins: 5
                Layout.preferredWidth:whileBackground.width-10
                text:"<a href='www.google.com'>Have a referel code?</a>"
                onLinkActivated: {
                    referelInput.visible = true
                }
                wrapMode: Text.Wrap
            }

            TextField {
                Layout.margins: 5
                Layout.preferredWidth:whileBackground.width-10

                id:referelInput
                visible: false
                placeholderText: qsTr("Referral Code")
            }

            Label{
                id:agreementLink
                Layout.margins: 5
                Layout.preferredWidth:whileBackground.width-10
                color: "green"
                wrapMode: Text.Wrap
                text:"<i>By signing up with Location you agree to our</><a href='www.google.com'>Terms and Conditions</a>"
                onLinkActivated: {networkManager.termsandconditionsAction()}
            }
            MyButton
            {
                Layout.margins: 5
                Layout.preferredWidth:whileBackground.width-10
                text:"REGISTER NOW!"
                onClicked:
                {
                    networkManager.registerAction( userName.text,password.text, fullName.text, contryCode.text+phoneNum.text, mailId.text, referelInput.text)
                }
            }
        }
    }

    }
    Component.onCompleted: {
        appWindow.showPostHomeState = true
    }

}

