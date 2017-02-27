#include "translatecore.h"
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>

TranslateCore::TranslateCore(QObject *parent) : QObject(parent)
{
    accessManager = NULL;
}
