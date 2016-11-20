#ifndef TRANSLATECORE_H
#define TRANSLATECORE_H

#include <QObject>
#include <QMap>

class QNetworkReply;
class QNetworkAccessManager;

class TranslateCore : public QObject
{
    Q_OBJECT
public:
    TranslateCore(QObject *parent = 0);
    virtual void translateText(int id, QString fromText, QString from, QString to) = 0;

signals:
    void finished(int id, QString ans);

protected slots:
    virtual void finished(QNetworkReply *reply) = 0;

protected:
    QNetworkAccessManager *accessManager;
    QMap<QNetworkReply *, int> ids;
};

#endif // TRANSLATECORE_H
