import QtQuick 2.13
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.11
import "../../common_qml"
import "../../common_component/MaterialUI"
import "../../common_component/Route"
import "../../instance_component/Navbar"

Pane {
    property var subtitle_list: []
    property var translate_list: []
    property int current_menu_index: -1

    id: container
    x: 0
    y: 0
    padding: 0

    function startTranslate() {
        for (let i = 0; i < 1; i++) {
            let the_subtitle = subtitle_list[i].text
            let result = BaiduTranslate.translateText(the_subtitle, 'auto', 'en')
        }
    }

    function onSelectSrt(url_list) {
        let sub_text = FileUtil.readFile(url_list[0])
        subtitle_list = SubtitleUtil.analyseSubtitleText(sub_text)
        translate_list = []
        for (let i = 0; i < subtitle_list.length; i++) {
            translate_list.push("")
        }
        console.log(JSON.stringify(subtitle_list))
    }

    Component.onCompleted: {
    }

    RowLayout {
        id: main_area
        anchors.fill: parent
        spacing: 0

        Navbar {
            RowLayout.fillHeight: true
        }

        Rectangle {
            RowLayout.fillHeight: true
            RowLayout.fillWidth: true

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                RowLayout {
                    id: top_bar
                    Layout.margins: 10
                    ColumnLayout.fillWidth: true

                    FileButton {
                        accept: 'srt'
                        variant: 'contained'
                        color: 'primary'
                        text: qsTr("打开")
                        ToolTip.text: qsTr("打开字幕文件")
                        ToolTip.visible: hovered
                        ToolTip.timeout: 3000
                        ToolTip.delay: 0
                        onChange: onSelectSrt(url_list)
                    }
                }

                Divider {
                    ColumnLayout.fillWidth: true
                }

                RowLayout {
                    ColumnLayout.fillWidth: true
                    ColumnLayout.fillHeight: true

                    ColumnLayout {
                        ColumnLayout.fillWidth: true
                        ColumnLayout.fillHeight: true
                        spacing: 0

                        ComboBox {
//							model: [].concat(defaultResolution).concat(['自定义'])
                            model: ['自动检测', '中文', '英语', '日语']
                        }

                        ListView {
                            id: record_list
                            clip: true
                            ColumnLayout.fillWidth: true
                            ColumnLayout.fillHeight: true
                            model: subtitle_list.length
                            orientation: ListView.Vertical
                            delegate: MListItem {
                                width: record_list.width
                                height: children[0].height

                                Typography {
                                    width: parent.width
                                    text: subtitle_list[index].text
                                }

                            }

                            ScrollBar.vertical: ScrollBar {       //滚动条
                            }
                        }
                    }

                    ColumnLayout {
                        spacing: 0

                        ComboBox {
                            model: ['百度翻译', '谷歌翻译']
                        }

                        MButton {
                            text: qsTr("翻译")
                            onClicked: startTranslate()
                        }
                    }

                    ColumnLayout {
                        ColumnLayout.fillWidth: true
                        ColumnLayout.fillHeight: true
                        spacing: 0

                        ComboBox {
                            model: ['自动检测', '中文', '英语', '日语']
                        }


                        ListView {
                            id: translate_list_view
                            clip: true
                            ColumnLayout.fillWidth: true
                            ColumnLayout.fillHeight: true
                            model: subtitle_list.length
                            orientation: ListView.Vertical
                            delegate: MListItem {
                                width: translate_list_view.width
                                height: children[0].height

                                Typography {
                                    text: subtitle_list[index].text
                                    wrapMode: Text.WrapAnywhere
                                }

                            }

                            ScrollBar.vertical: ScrollBar {       //滚动条
                            }
                        }
                    }
                }
            }
        }
    }

    Toast {
        id: toast
    }

    Menu {
        id: itemMenu

        MenuItem {
            text: "修改"
            onClicked: {
                if (current_menu_index === -1) {
                    return
                }

                itemMenu.close()
                tryEditItem(current_menu_index)
            }
        }
        MenuItem {
            text: "删除"
            onClicked: {
                if (current_menu_index === -1) {
                    return
                }

                console.log("(HomePage.qml)Delete item", current_menu_index)
                LiveRecordProcessor.deleteLiveRecord({
                    id: task_list[current_menu_index].id,
                }, function(result_id) {
                    if (result_id === 0) {
                        itemMenu.close()
                        toast.success(qsTr("任务删除成功"))
                        current_menu_index = -1
                        resetList()
                    }
                })
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
