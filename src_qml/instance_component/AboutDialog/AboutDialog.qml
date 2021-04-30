import QtQuick 2.13
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Window 2.14
import "../../common_qml"
import "../../common_component/MaterialUI"

Popup {
    id: aboutPopup
    width: 600
    height: 200
    padding: 20
    visible: false
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        RowLayout {
            ColumnLayout.fillWidth: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            spacing: 0

            Typography {
                variant: 'h6'
                text: qsTr("关于")
                RowLayout.fillWidth: true
            }

            MouseArea {
                width: 32
                height: 32
                cursorShape: Qt.PointingHandCursor

                Icon {
                    name: 'close'
                    size: 20
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                onClicked: {
                    aboutDialog.close()
                }
            }
        }

        Rectangle {
            Layout.topMargin: 20
            ColumnLayout.fillWidth: true
            ColumnLayout.fillHeight: true

            Typography {
                anchors.fill: parent
                wrapMode: Text.WrapAnywhere
                text: qsTr('字幕工具')
            }
        }

        Typography {
            topPadding: 10
            ColumnLayout.fillWidth: true
            horizontalAlignment: Text.AlignRight
            text: qsTr('版本号：ver'+Strings.version)
            textColor: 'textSecondary'
            variant: 'caption'
        }

        Typography {
            topPadding: 10
            ColumnLayout.fillWidth: true
            horizontalAlignment: Text.AlignRight
            text: qsTr('Copyright © 2021')
            textColor: 'textSecondary'
            variant: 'caption'
        }
    }
}
