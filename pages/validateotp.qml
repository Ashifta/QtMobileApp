
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0
import Qt.labs.controls.universal 1.0
import "../controls"

Rectangle {
    id:root
    color: "white"
    ColumnLayout{
        anchors.top: parent.top

        Text{
            id:forgotLabel
            Layout.leftMargin:  5
            Layout.rightMargin: 5
            Layout.preferredWidth:root.width -10
            text:"Verify OTP?"
            font.pixelSize: 10
            anchors.bottomMargin: 50
        }
        Text{
            Layout.margins: 5
            Layout.preferredWidth:root.width-10
            id:referelCodeText
            text:"<a href='www.google.com'>Resend OTP?</a>"
            onLinkActivated: {
                networkManager.resendotpAction()
            }
            wrapMode: Text.Wrap

        }
        MyTextField
        {
            id:otp
            Layout.preferredWidth:root.width -10
            imageIcon: "qrc:/res/drawable/user.png"
            placeHolder: qsTr("ENTER OTP")
        }
        MyButton{
            id:verifyOTP
            enabled: ( otp.text.length != 0 )
            Layout.preferredWidth: root.width -10
            Layout.margins: 5
            text: "Verify"
            onClicked: {
                networkManager.verifyaccountAction(otp.text)
            }
        }
    }

   Component.onCompleted: {
        appWindow.hideHeader =  true
   }
}

