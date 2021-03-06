import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.15
import Qt.labs.platform 1.1
import "./common_component/Route"
import "./common_component/Signal/PythonSignal"
import "./instance_component/SQLTable/SettingData"
import "./instance_component/SystemTray"
import "./pages/HomePage"

Window {
    id: mainWindow
    width: 900
    height: 600
    minimumWidth: 900
    minimumHeight: 600
    visible: true
    title: qsTr("字幕工具")

    function onPythonSignal(cmd, data) {
        PythonSignal.runCallback(cmd, data)
//        console.log(cmd)
//        console.log(JSON.stringify(data))
    }

    // 可能是qmltype信息不全，有M16警告，这里屏蔽下
    // @disable-check M16
    onClosing: function(closeevent) {
        let route_stack = Route.getStack()
        console.log("(main.qml)Save route", JSON.stringify(route_stack))
        SettingData.setValue('RouteStack', route_stack)
        mainWindow.hide()
//        CloseEvent的accepted设置为false就能忽略该事件
        closeevent.accepted = false
    }

    StackView {
        id: stackView
        x: 0
        y: 0
        padding: 0
        width: parent.width
        height: parent.height
        initialItem: home_page

        Component.onCompleted: {
            QMLSignal.qmlSignal.connect(onPythonSignal)
            SettingData.getValue('RouteStack', function(value) {
                console.log("(main.qml)Recover route", JSON.stringify(value))
                if (!value || value.length === 0) {
                    return
                }

                if (value.length === 1 && value[0].url === '/') {
                    return
                }

                Route.setStack(value)

                stackView.pop()
                for (let i = 0; i < value.length; i++) {
                    let url = value[i].url
                    console.log(url)
                    stackView.push(route_map[url], StackView.Immediate)
                }
            })
        }
    }

    Component {
        id: home_page
        HomePage { }
    }

    property var route_map: {
        "/": home_page,
//        "/live/historyrecordpage": history_record_page,
//        "/live/liverecordpage": live_record_page,
    }

    Connections {
        target: Route

        function onSwitchToCallback(url) {
            stackView.push(route_map[url], StackView.Immediate)
        }

        function onRedirectToCallback(url) {
            stackView.pop()
            stackView.push(route_map[url], StackView.Immediate)
        }

        function onNavigateToCallback(url) {
            stackView.push(route_map[url])
        }

        function onNavigateBackCallback(count) {
            for (let i = 0; i < count; i++) {
                stackView.pop()
            }
        }
    }

    SystemTray {
        onShowWindow: {
            mainWindow.show()
            mainWindow.requestActivate()
        }
    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/
