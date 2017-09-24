
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

        Row{
            id:phoneNumber
            spacing: 20
            Layout.margins: 5
            Layout.preferredWidth:root.width-10

          TextField {
            id:contryCode
            width: root.width/4-10
            placeholderText: qsTr("+91")
        }

        TextField {
            id:phoneNum
            width: root.width/2-10
            placeholderText: qsTr("7760889950")
        }
        }

        MyButton{
            id:verifyOTP
            enabled: ( contryCode.text.length != 0 && phoneNum.text.length != 0 )
            Layout.preferredWidth: root.width -10
            Layout.margins: 5
            text: "SEND VERIFICATION CODE"
            onClicked: {
                networkManager.forgotpasswordAction(contryCode.text+phoneNum.text)
            }
        }
    }

   Component.onCompleted: {
        appWindow.hideHeader =  true
   }
}

