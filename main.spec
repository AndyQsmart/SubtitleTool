# -*- mode: python ; coding: utf-8 -*-
import os
import site

block_cipher = None

add_files = [
    ('src_qml', 'src_qml'),
]

a = Analysis(['main.py'],
             pathex=['C:\\Users\\AndyQsmart\\Documents\\Qt\\SubtitleTool'],
             binaries=[],
             datas=add_files,
             hiddenimports=['PySide2.QtMultimedia', 'PySide2.QtSql', 'PyQt5'],
             hookspath=[],
             runtime_hooks=[],
             excludes=[],
             win_no_prefer_redirects=False,
             win_private_assemblies=False,
             cipher=block_cipher,
             noarchive=False)
pyz = PYZ(a.pure, a.zipped_data,
             cipher=block_cipher)
exe = EXE(pyz,
          a.scripts,
          [],
          exclude_binaries=True,
          name='字幕工具',
          debug=True,
          bootloader_ignore_signals=False,
          strip=False,
          upx=True,
          console=True,
          icon='C:\\Users\\AndyQsmart\\Documents\\Qt\\LiveToolsQt\\build_res\\logo.ico' )
coll = COLLECT(exe,
               a.binaries,
               a.zipfiles,
               a.datas,
               strip=False,
               upx=True,
               upx_exclude=[],
               name='字幕工具')
