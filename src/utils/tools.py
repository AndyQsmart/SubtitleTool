import platform
import time


class Tools:
    @classmethod
    def isWindows(cls):
        return platform.system() == 'Windows'

    @classmethod
    def isLinux(cls):
        return platform.system() == 'Linux'

    @classmethod
    def isMac(cls):
        return platform.system() == 'Darwin'

    @classmethod
    def getTimeStampFloat(cls):
        return time.time()
