/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.6
import QtQuick.Layouts 1.3
import Qt.labs.controls 1.0
import Qt.labs.controls.material 1.0
import Qt.labs.controls.universal 1.0
import QtQuick.Controls.Styles 1.3
import Qt.labs.settings 1.0
import "./controls"

ApplicationWindow {
    id: app
    property variant map
    property variant minimap
    property variant parameters
    width: 360
    height: 600
    visible: true
    title: "Location"
    property ApplicationWindow appWindow : app
    property bool hideHeader: false
    property bool showMapBackground: false
    property bool showPostHomeState: false
    header:ToolBar {
        id:header

        Item{
            anchors.fill: parent
            RowLayout {
                spacing: 25
                anchors.fill: parent

                Image {
                   source: "qrc:/res/drawable/car_icon.png"
                   MouseArea{
                       anchors.fill: parent
                       onClicked: {
                           console.log("popup")
                            stackView.pop()
                       }
                   }
                }
                Text {
                    //visible: (!hideHeader || showPostHomeState)
                    id: titleLabel
                    text: "Location"
                    color: "white"
                    font.pixelSize: 25
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                }
                ToolButton {
                    label: Image {
                        visible: true
                        anchors.centerIn: parent
                        source: "qrc:/res/drawable-mdpi/nav_drawer_icon.png"
                    }
                    onClicked: drawer.open()
                }
            }
        }
    }

    Drawer {
        id: drawer
        edge: Qt.RightEdge

        Pane {
            padding: 0
            width: Math.min(app.width, app.height) / 3 * 2
            height: app.height
            background: Rectangle{color: "transparent"}

            ListView {
                id: listView
                currentIndex: -1
                anchors.fill: parent

                delegate: ItemDelegate {

                    width: parent.width
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 40
                        color: "black"

                    }


                    label:
                        Row{
                        spacing: 20

                        leftPadding : 20
                        Rectangle
                        {
                            color: "black"
                            width: 100
                            height: (index === 0)?100:0
//                            width:20
                            radius: 10
                            Image {
                                id: name
                                width:(index === 0)?100:20
                                height: (index === 0)?100:20
                                source: model.menuIcon
                            }
                        }
                        Text {
                            text: model.title
                            visible: (index != 0)
                            color: "white"
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    highlighted: ListView.isCurrentItem
                    onClicked: {
                        if (listView.currentIndex != index) {
                            listView.currentIndex = index
                            titleLabel.text = model.title

                            stackView.push(model.source)
                        }
                        drawer.close()
                    }
                }

                model: ListModel {
                    id:menuModel
                    ListElement { title: "LoginForm"; source: "qrc:/pages/loginform.qml"; menuIcon:"qrc:/res/drawable/car_front_icon.png" }
                    ListElement { title: "MapView"; source: "qrc:/pages/mapview.qml"; menuIcon:"qrc:/res/drawable/car_front_icon.png" }
                    ListElement { title: "SignUp"; source: "qrc:/pages/signup.qml";menuIcon:"qrc:/res/drawable/car_front_icon.png" }
                    ListElement { title: "ValidateOTP"; source: "qrc:/pages/validateotp.qml"; menuIcon:"qrc:/res/drawable/car_front_icon.png"}
                    }
            }
        }
        onClicked: close()
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem:{ Qt.resolvedUrl("qrc:/launch/launchscreen.qml") }

    }
    ConfirmationMessage
    {
        id:errrorDialog
        visible: false
        anchors.centerIn: parent
        headerText: "Text"
        messageText: "Internet connection is not available"
    }

    ProgressCircle
    {
        id:progressIndicator
        visible: false
        anchors.centerIn: parent
    }

    Connections{
        target: networkManager
        onSwitchScreen:{
            var page = "qrc:/pages/"+name+".qml";
            stackView.push(page)
        }
        onErrorResponse:{
            errrorDialog.visible = true;
            errrorDialog.headerText = actionName
            errrorDialog.messageText = error
        }

        onShowServerProgress:
        {
            progressIndicator.visible = isShow;
        }
    }
}


