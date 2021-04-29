import QtQuick 2.13
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.15
import "./styles"

Rectangle {
    property bool light: false

    height: 1
    color: light ? Palatte.lightTextDivider : Palatte.lightTextDivider
}
