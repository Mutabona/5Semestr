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
import QtQuick.LocalStorage 2.0

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All
    backgroundColor: "#f8f8ff"

    property string surname: ""
    property string name: ""
    property string secondName: ""
    property var noteModel: ListModel {
        ListElement {
            note: "Донец Николай Олегович"
        }
        ListElement {
            note: "Крюкова Ксения Максимовна"
        }
    }

    function addNote() {
        if (surname !== "" && name !== "" && secondName !== "") {
            noteModel.append({"note": surname + "" + name + "" + secondName})
        }
    }

    function deleteNote(index) {
        noteModel.remove(index)
    }

    SilicaFlickable {
        anchors.fill: parent

        Column {
            id: column
            y: 30
            width: parent.width

            TextField {
                id: noteSurname
                placeholderText: "Фамилия"
                width: parent.width
                onTextChanged: surname = text
                EnterKey.onClicked: noteName.focus = true
                placeholderColor: noteSurname.highlighted ? "#423189" : Theme.darkSecondaryColor
            }

            TextField {
                id: noteName
                placeholderText: "Имя"
                onTextChanged: name = text
                EnterKey.onClicked: noteSecondName.focus = true
                placeholderColor: noteSurname.highlighted ? "#423189" : Theme.darkSecondaryColor
            }

            TextField {
                id: noteSecondName
                placeholderText: "Отчество"
                onTextChanged: secondName = text
                EnterKey.onClicked: focus = false
                placeholderColor: noteSurname.highlighted ? "#423189" : Theme.darkSecondaryColor
            }

            Button {
                id: addButton
                text: "Добавить"
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#423189"
                highlightBackgroundColor: "#b4a8e0"
                highlightColor:"#b69eff"
                onClicked: addNote()
            }
        }

        ListView {
            id: noteListView
            width: parent.width
            height: parent.height/2
            model: noteModel
            anchors.top: column.bottom
            delegate: Item {
                width: parent.width
                height: Theme.itemSizeMedium
                Row {
                    x: 20
                    Label {
                        text: model.note
                        wrapMode: Text.Wrap
                        width: 600
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.primaryColor
                        font.family: "Liberation Mono"
                        font.pixelSize: Theme.fontSizeSmall
                    }
                    IconButton {
                        id: btnDelete
                        icon.source: "delete.png"
                        onClicked: deleteNote(index)
                    }
                }
            }
        }
    }
    function initializeDatabase() {
        var db = LocalStorage.openDatabaseSync("notesDB", "1.0", "Notes Database", 1000000)
        db.transaction(function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS notes(note TEXT)')
            console.log("Таблица создана")
        })
    }
    Component.onCompleted: initializeDatabase()
}
