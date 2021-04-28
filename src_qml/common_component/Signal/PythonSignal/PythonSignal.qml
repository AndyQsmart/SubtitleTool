pragma Singleton

import QtQuick 2.0
import "../../../common_js/Tools.js" as Tools

Item {
    readonly property var signalCmd: ({
        REFRESH_MEDIA_STREAM_INFO: 1,
        AUDIO_AVG_DATA: 2,
    })

    property var signalCallback: ({})

    function registerCallback(cmd, func) {
        signalCallback[cmd] = func
    }

    function unregisterCallback(cmd, func) {
        delete signalCallback[cmd]
    }

    function runCallback(cmd, data) {
        let func = signalCallback[cmd]
        if (func) {
            func(data)
        }
    }
}
