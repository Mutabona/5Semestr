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
import QtQuick.XmlListModel 2.0

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All

    XmlListModel {
        id: model
        source: "https://cbr.ru/scripts/XML_val.asp?d=0"
        query: "/Valuta/Item"
        XmlRole {
            name: "name";
            query: "Name/string()"
        }
        XmlRole {
            name: "nominal";
            query: "Nominal/string()"
        }
        XmlRole {
            name: "parentCode";
            query: "ParentCode/string()"
        }

        onStatusChanged: {
            if (status === XmlListModel.Ready) {
                console.log("Got", count, "Market Lib");
            } else if (status === XmlListModel.Error){
                console.error("Error loading Market Libs:", errorString());
            }
        }
    }

    ListView {
        anchors.fill: parent
        model: model
        spacing: 100
        delegate: Item {
            width: parent.width
            height: 60
            Column {
                Text {
                    text: "Name:" + name
                }
                Text {
                    text: "Nominal:" + nominal
                }
                Text {
                    text: "ParentCode:" + parentCode
                }
            }
        }
    }
}
