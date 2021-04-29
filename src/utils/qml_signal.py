from PySide2.QtCore import Signal, QObject


class QMLSignalCMD:
    REFRESH_MEDIA_STREAM_INFO = 1
    AUDIO_AVG_DATA = 2


class QMLSignal(QObject):
    qmlSignal = Signal(int, 'QVariant')
    _instance = None

    @classmethod
    def instance(cls):
        if cls._instance is None:
            cls._instance = QMLSignal()
        return cls._instance

    def emitSignal(self, cmd, data=None):
        self.qmlSignal.emit(cmd, data)
