#include "subtitle.h"

#include <QFile>
#include <QTextStream>
#include <QRegExp>

Subtitle::Subtitle(QObject *parent) : QObject(parent)
{

}

void Subtitle::getFromFile(QString dir)
{
    this->filedir = dir;
    this->line.clear();
    this->postion.clear();
    QFile file(dir);
    if (!file.exists()) return;
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream read(&file);
    QRegExp regex("\\d\\d:\\d\\d:\\d\\d,\\d\\d\\d --> \\d\\d:\\d\\d:\\d\\d,\\d\\d\\d");
    QString line, pre = "", str;
    while (!read.atEnd())
    {
        str = read.readLine();
        if (regex.exactMatch(str))
        {
            if (line.length()) this->line.push_back(line);
            this->postion.push_back(str);
            line.clear();
            pre.clear();
        }
        else
        {
            if (line.length()) line += '\n';
            line += pre;
            pre = str;
        }
    }
    if (line.length()) line += '\n';
    line += pre;
    this->line.push_back(line);
}

void Subtitle::saveToFile(QString dir)
{
    QFile file(dir);
    //if (!file.exists())
    file.open(QIODevice::ReadWrite | QIODevice::Text);
    QTextStream write(&file);
    for (int i = 0; i < postion.size(); ++i)
    {
        write << i+1 << endl;
        write << postion[i] << endl;
        write << line[i] << endl << endl;
    }
}
