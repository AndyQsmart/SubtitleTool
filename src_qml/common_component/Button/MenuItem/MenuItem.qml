import QtQuick 2.13
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.15
import "../../../common_js/Color.js" as Color
import "../../../common_js/ComponentConfig.js" as ComponentConfig
import "../../Text/Typography/FontSize.js" as FontSize

TabButton {
    property string color: Color.text_primary
    id: button
    topPadding: 3*ComponentConfig.space_unit
    bottomPadding: 3*ComponentConfig.space_unit
    leftPadding: 4*ComponentConfig.space_unit
    rightPadding: 4*ComponentConfig.space_unit
    font.pointSize: FontSize.body2
    checked: false
    checkable: false
    Material.foreground: button.color
    Material.accent: button.color
}
