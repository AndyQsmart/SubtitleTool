import QtQuick 2.13
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.0
import "../Typography/FontSize.js" as FontSize
import "../../../common_js/Color.js" as Color

TextField {
    id: textField
    property string color: Color.primary
    font.pointSize: FontSize.body2
    Material.accent: textField.color
}
