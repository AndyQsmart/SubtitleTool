pragma Singleton

import QtQuick 2.0

QtObject {
     readonly property int fontSize: 14 // The default font size of the Material Specification.
     readonly property int fontWeightLight: 300
     readonly property int fontWeightRegular: 400
     readonly property int fontWeightMedium: 500
     readonly property var button: ({
        font_size: fontSize,
        font_weight: fontWeightMedium,
    })
    readonly property var fontSizeList: ({
        "h1": 96, "h2": 60, "h3": 48, "h4": 34, "h5": 24, "h6": 20,
        "subtitle1": 16, "subtitle2": 14, "body1": 16, "body2": 14,
        "caption": 12, "button": 14, "overline": 12, "little": 10
    })
}
