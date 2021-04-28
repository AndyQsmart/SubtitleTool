import QtQuick 2.13
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Styles 1.4
import "../../../common_js/Color.js" as Color
import "../../../common_js/ComponentConfig.js" as ComponentConfig
import "../../Text/Typography/FontSize.js" as FontSize

Button {
    id: button
    property string variant
    property string color
    property string text_color

    topPadding: 3*ComponentConfig.space_unit
    bottomPadding: 3*ComponentConfig.space_unit
    leftPadding: 4*ComponentConfig.space_unit
    rightPadding: 4*ComponentConfig.space_unit
    font.pointSize: FontSize.button

//    background: Rectangle {
//        border.color: Color.primary
//    }

    Repeater {
        model: variant === 'outlined' ? 1 : 0
        delegate: Rectangle {
            z: -1
            enabled: false
            border.color: button.color
            border.width: 1
            radius: 5
            anchors.fill: parent
            anchors.bottomMargin: 5
            anchors.topMargin: 5
        }
    }

    flat: {
        switch (variant) {
            case "contained":
                return false
            case "outlined":
                return true
            default:
                return true
        }
    }

    Material.foreground: {
        switch (variant) {
            case "contained":
                return text_color ? text_color : Color.white
            case "outlined":
                return button.color === Color.text_secondary ? Color.text_primary : button.color
            default:
                return button.color
        }
    }

    Material.background: {
        if (variant === 'contained') {
            if (button.color) {
                return button.color
            }
        }
    }

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        enabled: false
    }
}
