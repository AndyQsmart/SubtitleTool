import QtQuick 2.13
import "../../../common_js/Color.js" as Color
import "../Typography/FontSize.js" as FontSize

TextInput {
    id: textInput
    property string color: Color.primary
    property string placeholder: ''

    verticalAlignment: Text.AlignVCenter
    clip: true
    selectByMouse: true
    selectionColor: textInput.color
    padding: 10
    font.pointSize: FontSize.body2

    Rectangle {
        z: -1
        anchors.fill: parent
        enabled: false
        radius: 5
        border.width: textInput.activeFocus ? 2 : 1
        border.color: textInput.activeFocus ? textInput.color : Color.text_secondary
    }

    Text {
        visible: textInput.text ? false : true
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        leftPadding: 10
        text: placeholder
        color: Color.text_secondary
        font.pointSize: FontSize.body2
    }

    MouseArea {
        cursorShape: Qt.IBeamCursor
        anchors.fill: parent
        enabled: false
    }
}
