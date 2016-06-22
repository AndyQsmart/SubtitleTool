#include "translatecore.h"
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>

TranslateCore::TranslateCore(QObject *parent) : QObject(parent)
{
    accessManager = new QNetworkAccessManager(this);
    connect(accessManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(finished(QNetworkReply*)));
}

void TranslateCore::translateText(int id, QString fromText)
{
    this->id = id;
    fromText.replace("\n", "|");
    QUrl url("http://fanyi.baidu.com/v2transapi");
    QNetworkRequest request(url);
    request.setRawHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
    request.setRawHeader("Accept-Language", "zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3");
    request.setRawHeader("Connection", "keep-alive");
    request.setRawHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
    request.setRawHeader("Host", "fanyi.baidu.com");
    request.setRawHeader("Referer", "http://fanyi.baidu.com");
    request.setRawHeader("User-Agent", "Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Firefox/38.0");

    QByteArray data = "";
    data.append("query=" + fromText + "&from=jp&to=zh");//&total=true&limit=60");
    accessManager->post(request, data);
}

void TranslateCore::finished(QNetworkReply *reply)
{
    QByteArray data = reply->readAll();
    QJsonParseError err;
    QJsonDocument json = QJsonDocument::fromJson(data, &err);
    if (err.error != QJsonParseError::NoError)
        return;
    QJsonObject obj = json.object().find("trans_result").value().toObject();
    QJsonArray objList = obj.find("data").value().toArray();
    QString ans = objList.at(0).toObject().find("dst").value().toString();
    ans.replace("|", "\n");
    emit finished(id, ans);
}
