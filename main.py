# This Python file uses the following encoding: utf-8
import sys
import os

from PySide2.QtCore import QCoreApplication, Qt
from PySide2.QtGui import QGuiApplication, QFont
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtQuickControls2 import QQuickStyle

from src.utils.file_util import FileUtil
from src.utils.qml_signal import QMLSignal
from src.utils.translate.baidu_translate import BaiduTranslate

if __name__ == "__main__":
    # 高分辨率适配
    QCoreApplication.setAttribute(Qt.AA_EnableHighDpiScaling)
    QGuiApplication.setHighDpiScaleFactorRoundingPolicy(Qt.HighDpiScaleFactorRoundingPolicy.PassThrough)

    app = QGuiApplication(sys.argv)
    QQuickStyle.setStyle('Material')
    defualt_font = QFont()
    defualt_font.setFamily("Arial")
    app.setFont(defualt_font)
    app.setOrganizationName('AndyQsmart')
    app.setOrganizationDomain('www.andyqsmart.com')

    engine = QQmlApplicationEngine()

    # 文件工具
    file_util = FileUtil()
    engine.rootContext().setContextProperty('FileUtil', file_util)
    # 翻译接口
    baidu_translate = BaiduTranslate()
    engine.rootContext().setContextProperty('BaiduTranslate', baidu_translate)
    # 连接信号
    engine.rootContext().setContextProperty('QMLSignal', QMLSignal.instance())

    engine.load(os.path.join(os.path.dirname(__file__), "src_qml/main.qml"))
    # print(engine.offlineStoragePath())

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
