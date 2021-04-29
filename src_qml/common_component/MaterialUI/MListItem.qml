import QtQuick 2.13
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.15
import "./styles"

TabButton {
    property string color: Palatte.lightTextPrimary
//    dense: false,
//          disabled: false,
//          disableGutters: false,
//          divider: false,
//          button: false,
    id: button
    topPadding: 3*Palatte.unit
    bottomPadding: 3*Palatte.unit
    leftPadding: 4*Palatte.unit
    rightPadding: 4*Palatte.unit
    font.pointSize: TypographyStyle.fontSizeList.body2
    checked: false
    checkable: false
    Material.foreground: button.color
    Material.accent: button.color
}

