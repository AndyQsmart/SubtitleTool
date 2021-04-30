import QtQuick 2.13
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Styles 1.4
import "./styles"
import "./colors"

Button {
    id: button
    property string color: 'default'
    property bool disabled: false
    property string size: 'medium'
    property bool mini: false
    property string variant: 'text' // contained、outlined、text(flat)、fab, default: text
    property string textColor

    enabled: !disabled
    topPadding: 3 * Palatte.unit
    bottomPadding: 3 * Palatte.unit
    leftPadding: 4 * Palatte.unit
    rightPadding: 4 * Palatte.unit
    font.pointSize: TypographyStyle.button.font_size
    flat: !(variant === "contained")

    state: {
        switch (variant) {
            case 'contained':
                return 'contained'
            case 'outlined':
                return 'outlined'
            case 'fab':
                return 'fab'
            default:
                return 'text'
        }
    }

    states: [
        State {
            name: "contained"
            PropertyChanges {
                target: button
                Material.foreground: textColor ? textColor : (button.color === 'primary' || button.color === 'secondary' ? Colors.commonWhite : Colors.commonBlack)
                Material.background: button.color ? Palatte.string2Color(button.color) : Grey._300
            }
        },
        State {
            name: "outlined"
            PropertyChanges {
                target: button
                Material.foreground: Palatte.string2Color(button.color)
                Material.background: Colors.commonTransparent
            }
        },
        State {
            name: "text"
            PropertyChanges {
                target: button
                Material.foreground: Colors.commonBlack
                Material.background: Colors.commonTransparent
            }
        }
    ]

    Repeater {
        model: variant === 'outlined' ? 1 : 0
        delegate: Rectangle {
            z: -1
            enabled: false
            border.color: Palatte.string2Color(button.color)
            border.width: 1
            radius: 5
            anchors.fill: parent
            anchors.bottomMargin: 5
            anchors.topMargin: 5
        }
    }

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        enabled: false
    }
}
