import QtQuick 2.13
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import "../../common_qml"
import "../../common_component/MaterialUI"
import "../../common_component/Icon"
import "../../common_component/Route"
import "../../instance_component/AboutDialog"

Pane {
    id: navbar
    x: 0
    y: 0
    padding: 0
    width: 250
    Material.background: Color.primary

    Item {
        anchors.fill: parent

        ColumnLayout {
            anchors.fill: parent
            anchors.bottomMargin: 10
            anchors.topMargin: 10

            MListItem {
                id: button_task_list
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                ColumnLayout.fillWidth: true
                color: Color.white

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: parent.rightPadding
                    anchors.rightMargin: parent.rightPadding

                    Icon {
                        name: "list-ul"
                        size: 14
                        color: Color.white
                    }

                    Typography {
                        RowLayout.fillWidth: true
                        leftPadding: 10
                        text: qsTr("字幕翻译")
                        color: Color.white
    //                    font.weight: Font.Bold
                    }
                }

                onClicked: {
                    Route.redirectTo('/')
                }
            }


//            MListItem {
//                id: button_history_list
//                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
//                ColumnLayout.fillWidth: true
//                color: Color.white

//                RowLayout {
//                    anchors.fill: parent
//                    anchors.leftMargin: parent.rightPadding
//                    anchors.rightMargin: parent.rightPadding

//                    Icon {
//                        name: "history"
//                        size: 14
//                        color: Color.white
//                    }

//                    Typography {
//                        RowLayout.fillWidth: true
//                        leftPadding: 10
//                        text: qsTr("历史任务")
//                        color: Color.white
//    //                    font.weight: Font.Bold
//                    }
//                }

//                onClicked: {
//                    Route.redirectTo('/live/historyrecordpage')
//                }
//            }

            Item {
                ColumnLayout.fillHeight: true
            }

            MListItem {
                id: button_about
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                ColumnLayout.fillWidth: true
                color: Color.white

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: parent.rightPadding
                    anchors.rightMargin: parent.rightPadding

                    Icon {
                        name: "info-circle"
                        size: 14
                        color: Color.white
                    }

                    Typography {
                        RowLayout.fillWidth: true
                        leftPadding: 10
                        text: qsTr("关于")
                        color: Color.white
        //                    font.weight: Font.Bold
                    }
                }

                onClicked: {
                    aboutDialog.open()
                }
            }
        }
    }

    AboutDialog {
        id: aboutDialog
        x: (parent.parent.parent.width-aboutDialog.width)/2
        y: (parent.parent.parent.height-aboutDialog.height)/2
    }
}
