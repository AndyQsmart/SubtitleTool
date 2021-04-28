import QtQuick 2.10
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.0
import "../Typography/FontSize.js" as FontSize
import "../../../common_js/Color.js" as Color

ToolTip {
    padding: 10
    visible: false
    font.bold: true
    font.pointSize: FontSize.body1
    x: (parent.width-width)/2
    y: (parent.height-height)/2
    opacity: 0.8
    timeout: 3000

    function success(message) {
        Material.background = Color.green
        show(message, timeout)
    }

    function warning(message) {
        Material.background = Color.dark_yellow
        show(message, timeout)
    }

    function error(message) {
        Material.background = Color.orange_red
        show(message, timeout)
    }
}
