from PySide2.QtCore import QObject, Slot
import chardet

class FileUtil(QObject):
    @Slot(str, result='QVariant')
    def readFile(self, file_path):
        print(file_path)
        # the_file = open(file_path, 'r', encoding ='utf-8')
        the_file = open(file_path, 'rb')
        data_byte = the_file.read()
        result = chardet.detect(data_byte)
        the_file.close()
        the_encoding = result.get('encoding')
        the_file = open(file_path, 'r', encoding=the_encoding)
        data_text = the_file.read()
        return data_text
