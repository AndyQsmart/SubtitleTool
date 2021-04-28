import QtQuick 2.13
import "../../../common_js/Color.js" as Color
import "./FontSize.js" as FontSize

Text {
    property string variant
    property bool noWrap: false

    //    wrapMode: noWrap ? Text.NoWrap : Text.Wrap

    font.pointSize: {
        if (!variant) {
            return FontSize.body2
        }

        return FontSize[variant] ? FontSize[variant] : FontSize.body2
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
