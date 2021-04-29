pragma Singleton

import QtQuick 2.0

QtObject {
    function analyseSubtitleText(sub_text) {
        let lines = sub_text.split('\n')

        let regex = RegExp("\\d\\d:\\d\\d:\\d\\d,\\d\\d\\d --> \\d\\d:\\d\\d:\\d\\d,\\d\\d\\d", "g")
        let subtitle_text = "", pre = ""
        let ans = []

        for (let i = 0; i < lines.length; i++) {
            let the_line = lines[i]
            if (the_line.search(regex) !== -1) {
                if (subtitle_text.length) {
                    if (ans.length) {
                        ans[ans.length-1].text = subtitle_text
                    }
                }
                ans.push({
                    time: the_line,
                })
                subtitle_text = ''
                pre = ''
            }
            else {
                if (pre.length) {
                    if (subtitle_text.length) subtitle_text += '\n'
                    subtitle_text += pre
                }
                pre = the_line
            }
        }
        if (subtitle_text.length) subtitle_text += '\n'
        subtitle_text += pre
        if (ans.length) {
            ans[ans.length-1].text = subtitle_text
        }
        return ans
    }
}
