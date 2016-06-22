#-------------------------------------------------
#
# Project created by QtCreator 2016-06-22T12:58:14
#
#-------------------------------------------------

QT       += core gui network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = SubtitleTool
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    translatecore.cpp \
    subtitle.cpp

HEADERS  += mainwindow.h \
    translatecore.h \
    subtitle.h

FORMS    += mainwindow.ui
