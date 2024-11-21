/*******************************************************************************
**
** Copyright (C) 2022 ru.auroraos
**
** This file is part of the Моё приложение для ОС Аврора project.
**
** Redistribution and use in source and binary forms,
** with or without modification, are permitted provided
** that the following conditions are met:
**
** * Redistributions of source code must retain the above copyright notice,
**   this list of conditions and the following disclaimer.
** * Redistributions in binary form must reproduce the above copyright notice,
**   this list of conditions and the following disclaimer
**   in the documentation and/or other materials provided with the distribution.
** * Neither the name of the copyright holder nor the names of its contributors
**   may be used to endorse or promote products derived from this software
**   without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
** AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
** THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
** FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
** IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
** FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
** OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
** PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS;
** OR BUSINESS INTERRUPTION)
** HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
** WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE)
** ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
** EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
*******************************************************************************/

import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All
    backgroundColor: "#ffebcd"

    ListModel {
        id: jsonModel
    }

    ListView {
        anchors.fill: parent
        model: jsonModel
        spacing: 130

        delegate: Item {
            Row {
                spacing: 30
                x: 30

                Text {
                    text: "ID: " + model.id
                    color: "#ff6800"
                    font.pointSize: 30
                    font.family: "monospace"
                }
                Text {
                    text: "Completed: " + model.completed
                    color: "#4d0000"
                    font.pointSize: 30
                    font.family: "monospace"
                }
            }
        }
    }

    function processData(data) {
        for(var i = 0; i < data.length; i++) {
            jsonModel.append({
                "id": data[i].id,
                "completed": data[i].completed
            });
        }
    }
    Component.onCompleted: {
        var request = new XMLHttpRequest();
        request.onreadystatechange = function() {
            if(request.readyState === XMLHttpRequest.DONE) {
                if(request.status === 200) {
                    var response = JSON.parse(request.responseText);
                    processData(response);
                } else {
                    console.error("Failed to fetch JSON data", request.status, request.statusText);
                }
            }
        }
        request.open("GET", "https://jsonplaceholder.typicode.com/todos", true);
        request.send();
    }
}
