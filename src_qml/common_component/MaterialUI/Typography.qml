import QtQuick 2.13
import "./styles"

Text {
    property string variant: 'body2'
    property bool noWrap: false
    property string textColor: 'initial'
//                               | 'primary'
//                               | 'secondary'
//                               | 'textPrimary'
//                               | 'textSecondary'
//                               | 'error'
    color: {
        switch (textColor) {
            case 'primary':
            case 'secondary':
            case 'textPrimary':
            case 'textSecondary':
            case 'error':
                return Palatte.string2Color(textColor)
            default:
                return Colors.commonBlack
        }
    }

    //    wrapMode: noWrap ? Text.NoWrap : Text.Wrap
    font.pointSize: {
        if (!variant) {
            return TypographyStyle.fontSizeList.body2
        }

        return TypographyStyle.fontSizeList[variant] ? TypographyStyle.fontSizeList[variant] : TypographyStyle.fontSizeList.body2
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

