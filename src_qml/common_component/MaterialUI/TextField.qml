import QtQuick 2.13
import "./styles"

TextInput {
    id: textInput
    property string variant: 'standard' // 'filled' | 'outlined' | 'standard'
    property string color: 'primary'
    property string placeholder: ''
    property string _main_color: Palatte.string2Color('primary', Palatte.primaryMain)
    property var _padding: {
        if (variant === 'outlined') {
            return [10, 10, 10, 10]
        }
        else {
            return [5, 0, 5, 0]
        }
    }

    verticalAlignment: Text.AlignVCenter
    clip: true
    selectByMouse: true
    selectionColor: textInput._main_color
    topPadding: _padding[0]
    rightPadding: _padding[1]
    bottomPadding: _padding[2]
    leftPadding: _padding[3]

    font.pointSize: TypographyStyle.fontSizeList.body2

    // outlined外边框
    Repeater {
        model: variant === 'outlined' ? 1 : 0
        delegate: Rectangle {
            z: -1
            anchors.fill: parent
            enabled: false
            radius: 5
            border.width: textInput.activeFocus ? 2 : 1
            border.color: textInput.activeFocus ? textInput._main_color : Palatte.lightTextSecondary
        }
    }

    // 下划线
    Repeater {
        id: repeater
        model: variant !== 'outlined' ? 1 : 0
        delegate: Rectangle {
            z: -1
            width: textInput.width
            height: textInput.activeFocus ? 2 : 1
            anchors.bottom: parent.bottom
            enabled: false
            color: textInput.activeFocus ? textInput._main_color : Palatte.lightTextSecondary
        }
    }

    // placeholder
    Text {
        visible: textInput.text ? false : true
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        leftPadding: {
            if (variant === 'outlined') {
                return 10
            }
            else {
                return 0
            }
        }
        text: placeholder
        color: Palatte.lightTextSecondary
        font.pointSize: TypographyStyle.fontSizeList.body2
    }

    MouseArea {
        cursorShape: Qt.IBeamCursor
        anchors.fill: parent
        enabled: false
    }
}
