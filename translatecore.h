#ifndef TRANSLATECORE_H
#define TRANSLATECORE_H

#include <QObject>

class QNetworkReply;
class QNetworkAccessManager;

class TranslateCore : public QObject
{
        Q_OBJECT
    public:
        explicit TranslateCore(QObject *parent = 0);
        void translateText(int id, QString fromText);

    signals:
        void finished(int id, QString ans);

    protected slots:
        void finished(QNetworkReply *reply);

    protected:
        int id;
        QNetworkAccessManager *accessManager;
};

#endif // TRANSLATECORE_H
