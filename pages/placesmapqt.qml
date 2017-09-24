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

//! [Imports]
import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.6
//! [Imports]

Rectangle {
    width: 360
    height: 640

    //! [Initialize Plugin]
//    Plugin {
//        id: myPlugin
//        name: "osm"
//        //specify plugin parameters if necessary
//        //PluginParameter {...}
//        //PluginParameter {...}
//        //...
//    }

//    Plugin {
//        id:myPlugin
//        name: "mapbox"
//        PluginParameter { name: "mapbox.access_token"; value: "pk.eyJ1IjoiYXNoaWZpbmRpYW4iLCJhIjoiY2lvZDVrcXprMDRoa3Z3bHpvamNnaGFseSJ9.fe4bIP1wk2UMrfiKK397gg" }
//        PluginParameter { name: "mapbox.map_id"; value: "ashifindian.map-zr0njcqy" }
//    }

    Plugin {
        id:myPlugin
        name: "here"
        PluginParameter { name: "here.app_id"; value: "TJwZCFhmcJBQPU915E22" }
        PluginParameter { name: "here.token"; value: "fWevx3vsvtwc5i4IKKKzDw" }
    }
    //! [Initialize Plugin]

    //! [Current Location]
    PositionSource {
        id: positionSource
        property variant lastSearchPosition: locationOslo
        active: true
        updateInterval: 120000 // 2 mins
        onPositionChanged:  {
            var currentPosition = positionSource.position.coordinate
            map.center = currentPosition
            var distance = currentPosition.distanceTo(lastSearchPosition)
            if (distance > 500) {
                // 500m from last performed pizza search
                lastSearchPosition = currentPosition
                searchModel.searchArea = QtPositioning.circle(currentPosition)
                searchModel.update()
            }
        }
    }
    //! [Current Location]

    //! [PlaceSearchModel]
    property variant locationOslo: QtPositioning.coordinate( 74, 35)

    PlaceSearchModel {
        id: searchModel

        plugin: myPlugin

        searchTerm: "mosque"
        searchArea: QtPositioning.circle(locationOslo)

        Component.onCompleted: update()
    }
    //! [PlaceSearchModel]

    ListModel{
        id:centrePos
        ListElement{
            title:"You are here"
            imageIcon:"qrc:/res/drawable/bg_pin.png"
        }
    }

    //! [Places MapItemView]
    Map {
        id: map
        anchors.fill: parent
        plugin: myPlugin;
       // center: locationOslo
        zoomLevel: 13

        MapItemView {
            model: searchModel
            delegate: MapQuickItem {
                coordinate: place.location.coordinate

                anchorPoint.x: image.width * 0.5
                anchorPoint.y: image.height

                sourceItem: Column {
                    Image { id: image; width:32; height:32;source: "qrc:/res/drawable/car_front_icon.png" }
                    //Text { text: title; font.bold: true }
                }
            }
        }

        MapItemView {
            model: centrePos
            delegate: MapQuickItem {
                coordinate: map.center

                anchorPoint.x: image.width * 0.5
                anchorPoint.y: image.height

                sourceItem: Column {
                    Image { id: image; width:32; height:32;source: imageIcon }
                    Text { text: title; font.bold: true }
                }
            }
        }
//        MapQuickItem {
//            id: marker
//            anchors.centerIn: parent
//            sourceItem: Rectangle
//            {
//            width:text.width
//            height:text.height
//                color:"white"
//                TextInput{
//                    id:text
//                color: "red"
//                text:"location"
//            }
//        }
//        }

    }
    //! [Places MapItemView]

    Connections {
        target: searchModel
        onStatusChanged: {
            if (searchModel.status == PlaceSearchModel.Error)
                console.log(searchModel.errorString());
        }
    }
}
