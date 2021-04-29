import QtQuick 2.13
import QtQuick.Dialogs 1.2

MButton {
    id: button
    property bool multiple: false
    property string accept: ''

    signal change(var url_list)

    onClicked: {
        file_dialog.open()
    }

    FileDialog {
        id: file_dialog
        selectMultiple: multiple
        nameFilters: {
            let ans = []
            switch (button.accept) {
                case "srt":
                    ans.push("字幕文件 (*.srt)")
                    break
            }
            ans.push("所有文件 (*)")
            return ans
        }
        onAccepted: {
            let ans = []
            for (let i = 0; i < fileUrls.length; i++) {
                let path_text = fileUrls[i]
                if (path_text.indexOf('file:///') === 0) {
                    path_text = path_text.substring(8, path_text.length)
                    ans.push(path_text)
                }
            }
            change(ans)
        }
    }
}
