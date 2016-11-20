#include "baidutranslate.h"
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

BaiduTranslate::BaiduTranslate(QObject *parent) : TranslateCore(parent)
{
    accessManager = new QNetworkAccessManager(this);
    connect(accessManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(finished(QNetworkReply*)));
}

void BaiduTranslate::translateText(int id, QString fromText, QString from, QString to)
{
    from = getLanguage(getLanguageId(from));
    to = getLanguage(getLanguageId(to));

    fromText.replace("\n", "|");//换行符翻译后丢失问题。
    QUrl url("http://fanyi.baidu.com/v2transapi");
    QNetworkRequest request(url);
    request.setRawHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
    request.setRawHeader("Accept-Language", "zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3");
    //request.setRawHeader("Connection", "keep-alive");
    request.setRawHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
    request.setRawHeader("Host", "fanyi.baidu.com");
    request.setRawHeader("Referer", "http://fanyi.baidu.com");
    request.setRawHeader("User-Agent", "Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Firefox/38.0");

    QByteArray data = "";
    data.append("query=" + fromText + "&from="+from+"&to="+to);//&total=true&limit=60");
    ids[accessManager->post(request, data)] = id;
}

void BaiduTranslate::finished(QNetworkReply *reply)
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
    emit finished(ids[reply], ans);
    ids.remove(reply);
}

QString BaiduTranslate::getLanguage(int kind)
{
    switch (kind)
    {
        case AUTO: return "auto";
        case ARA: return "ara";
        case DE: return "de";
        case RU: return "ru";
        case FRA: return "fra";
        case KOR: return "kor";
        case NL: return "nl";
        case PT: return "pt";
        case JP: return "jp";
        case TH: return "th";
        case WYW: return "wyw";
        case SPA: return "spa";
        case EL: return "el";
        case IT: return "it";
        case EN: return "en";
        case YUE: return "yue";
        case ZH: return "zh";
    };
    return "auto";
}

int BaiduTranslate::getLanguageId(QString kind)
{
    if (kind.compare("自动检测") == 0)
        return AUTO; //=> '自动检测',
    if (kind.compare("阿拉伯语") == 0)
        return ARA; //=> '阿拉伯语',
    if (kind.compare("德语") == 0)
        return DE;// => '德语',
    if (kind.compare("俄语") == 0)
        return RU;// => '俄语',
    if (kind.compare("法语") == 0)
        return FRA;// => '法语',
    if (kind.compare("韩语") == 0)
        return KOR;// => '韩语',
    if (kind.compare("荷兰语") == 0)
        return NL;// => '荷兰语',
    if (kind.compare("葡萄牙语") == 0)
        return PT;// => '葡萄牙语',
    if (kind.compare("日语") == 0)
        return JP;// => '日语',
    if (kind.compare("泰语") == 0)
        return TH;// => '泰语',
    if (kind.compare("文言文") == 0)
        return WYW;// => '文言文',
    if (kind.compare("西班牙语") == 0)
        return SPA;// => '西班牙语',
    if (kind.compare("希腊语") == 0)
        return EL;// => '希腊语',
    if (kind.compare("意大利语") == 0)
        return IT;// => '意大利语',
    if (kind.compare("英语") == 0)
        return EN;// => '英语',
    if (kind.compare("粤语") == 0)
        return YUE;// => '粤语',
    if (kind.compare("中文") == 0)
        return ZH;// => '中文'
    return AUTO;
}
