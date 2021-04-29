import QtQuick 2.13
import QtQuick.Dialogs 1.2

MButton {
    signal change(string url)

    onClicked: {
        file_dialog.open()
    }

    FileDialog {
        id: file_dialog
        selectFolder: true
        onAccepted: {
            let path_text = folder.toString()
            if (path_text.indexOf('file:///') === 0) {
                path_text = path_text.substring(8, path_text.length)
            }

            change(path_text)
        }
    }
}
