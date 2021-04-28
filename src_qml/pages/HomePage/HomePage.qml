import QtQuick 2.13
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.11
import "../../common_component/Button/QButton"
import "../../common_component/Button/MenuItem"
import "../../common_component/Divider"
import "../../common_component/Icon"
import "../../common_component/Text/Typography"
import "../../common_component/Text/Toast"
import "../../common_component/Route"
import "../../instance_component/Navbar"
import "../../instance_component/CreateRecordDialog"
import "../../instance_component/DataProcessor/LiveRecordProcessor"
import "../../common_js/Color.js" as Color
import "../../common_js/Tools.js" as Tools

Pane {
    property var task_list: []
    property int current_menu_index: -1

    id: container
    x: 0
    y: 0
    padding: 0

    function requestList() {
        console.log("(HomePage.qml)try request list")
        LiveRecordProcessor.getLiveRecordList({
            min_end_time_stamp: Tools.getTimeStamp(),
            order_key: ['start_time_stamp', true],
        }, null, null, function (result_id, ans) {
            if (result_id === 0) {
                //                console.log('(HomePage.qml)requestList: ans', JSON.stringify(ans))
                let new_task_list = []
                Object.assign(new_task_list, task_list, ans.task_list)
                container.task_list = new_task_list
            }
        })
    }

    function resetList() {
        task_list = []
        requestList()
    }

    function tryEditItem(index) {
        createDialog.show(task_list[index].id)
    }

    Component.onCompleted: {
        requestList()
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

                    QButton {
                        variant: 'outlined'
                        text: qsTr("新建")
                        color: Color.text_secondary
                        onClicked: {
                            createDialog.show()
                        }
                        ToolTip.text: qsTr("新建直播任务")
                        ToolTip.visible: hovered
                        ToolTip.timeout: 3000
                        ToolTip.delay: 0
                    }
                }

                Divider {
                    ColumnLayout.fillWidth: true
                }

                ListView {
                    id: record_list
                    clip: true
                    ColumnLayout.fillWidth: true
                    ColumnLayout.fillHeight: true
                    model: task_list.length
                    orientation: ListView.Vertical
                    delegate: MenuItem {
                        width: record_list.width
                        height: children[1].height

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            onClicked: {
                                if (mouse.button === Qt.RightButton) {
                                    current_menu_index = index
                                    itemMenu.popup()
                                }
                                else if (mouse.button === Qt.LeftButton) {
                                    Route.navigateTo('/live/liverecordpage', {
                                        id: task_list[index].id,
                                        title: task_list[index].title,
                                    })
                                }
                            }
                        }

                        RowLayout {
                            anchors.fill: parent
                            spacing: 0
                            anchors.leftMargin: parent.leftPadding
                            anchors.rightMargin: parent.rightPadding + 10
                            height: {
                                let height = 0
                                for (let i = 0; i < children.length; i++) {
                                    height = Math.max(height, children[i].height)
                                }
                                return height
                            }

                            Icon {
                                size: 20
                                name: 'video-camera'
                                color: Color.primary
                            }

                            Item {
                                RowLayout.fillWidth: true
                                Layout.leftMargin: 10

                                height: children[0].height

                                ColumnLayout {
                                    Typography {
                                        topPadding: 15
                                        text: task_list[index].title
                                    }

                                    Typography {
                                        text: {
                                            let item = task_list[index]
                                            const { start_time_stamp, end_time_stamp } = item
                                            const begin_time = Tools.getDateByStamp(start_time_stamp)
                                            const end_time = Tools.getDateByStamp(end_time_stamp)
                                            const format_str = "%y.%MM.%dd %hh:%mm"
                                            if (
                                                begin_time.getFullYear() === end_time.getFullYear() &&
                                                begin_time.getMonth() === end_time.getMonth() &&
                                                begin_time.getDate() === end_time.getDate()
                                            ) {
                                                return Tools.getTimeByStamp(start_time_stamp, format_str) + ' - ' + Tools.getTimeByStamp(end_time_stamp, '%hh:%mm')
                                            }
                                            else {
                                                return Tools.getTimeByStamp(start_time_stamp, format_str) + ' - ' + Tools.getTimeByStamp(end_time_stamp, format_str)
                                            }
                                        }
                                        color: Color.text_secondary
                                        variant: 'caption'
                                        bottomPadding: 15
                                    }
                                }
                            }

                            Icon {
                                size: 20
                                name: 'cog'
                                color: Color.primary

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                                    onClicked: {
                                        tryEditItem(index)
                                    }

                                }
                            }
                        }
                    }

                    ScrollBar.vertical: ScrollBar {       //滚动条
                        //                        anchors.right: lview.left
                        //                        width: 50
                        //                        active: true
                        //                        background: Item {            //滚动条的背景样式
                        //                            Rectangle {
                        //                                anchors.centerIn: parent
                        //                                height: parent.height
                        //                                width: parent.width * 0.2
                        //                                color: 'grey'
                        //                                radius: width/2
                        //                            }
                        //                        }

                        //                        contentItem: Rectangle {
                        //                            radius: width/3        //bar的圆角
                        //                            color: Color.gray
                        //                        }
                    }
                }
            }
        }
    }

    CreateRecordDialog {
        id: createDialog
        x: (parent.width - createDialog.width) / 2
        y: (parent.height - createDialog.height) / 2
        onFinish: {
            if (id) {
                toast.success(qsTr('任务修改成功'))
            }
            else {
                toast.success(qsTr('任务创建成功'))
            }

            resetList()
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
