#ifndef BAIDUTRANSLATE_H
#define BAIDUTRANSLATE_H

#include <common/translatecore.h>

class BaiduTranslate : public TranslateCore
{
    Q_OBJECT
public:
    BaiduTranslate(QObject *parent = 0);
    void translateText(int id, QString fromText, QString from, QString to);
    enum
    {
        AUTO, // => '自动检测',
        ARA, // => '阿拉伯语',
        DE, // => '德语',
        RU, // => '俄语',
        FRA, // => '法语',
        KOR, // => '韩语',
        NL, // => '荷兰语',
        PT, // => '葡萄牙语',
        JP, // => '日语',
        TH, // => '泰语',
        WYW, // => '文言文',
        SPA, // => '西班牙语',
        EL, // => '希腊语',
        IT, // => '意大利语',
        EN, // => '英语',
        YUE, // => '粤语',
        ZH// => '中文'
    };

protected slots:
    void finished(QNetworkReply *reply);

signals:
    void finished(int id, QString ans);

private:
    QString getLanguage(int kind);
    int getLanguageId(QString kind);
};

#endif // BAIDUTRANSLATE_H
