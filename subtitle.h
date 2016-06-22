#ifndef SUBTITLE_H
#define SUBTITLE_H

#include <QObject>
#include <QVector>

class Subtitle : public QObject
{
        Q_OBJECT
    public:
        explicit Subtitle(QObject *parent = 0);
        void getFromFile(QString dir);
        void saveToFile(QString dir);

    public:
        QString filedir;
        QVector<QString> postion;
        QVector<QString> line;
};

#endif // SUBTITLE_H
