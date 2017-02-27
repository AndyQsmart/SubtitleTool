#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "common/translatecore.h"
#include "baidutranslate.h"
#include "subtitle.h"
#include <QFileDialog>
#include <QScrollBar>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    subtitle = new Subtitle();
    newSubtitle = new Subtitle();
    connect(ui->translateButton, SIGNAL(clicked(bool)), this, SLOT(translate()));
    connect(ui->openFile, SIGNAL(triggered(bool)), this, SLOT(openFromFile()));
    connect(ui->saveSubtitle, SIGNAL(triggered(bool)), this, SLOT(saveToFile()));
    connect(ui->textFromEdit->verticalScrollBar(), SIGNAL(sliderMoved(int)), ui->textToEdit->verticalScrollBar(), SLOT(setValue(int)));
    connect(ui->textToEdit->verticalScrollBar(), SIGNAL(sliderMoved(int)), ui->textFromEdit->verticalScrollBar(), SLOT(setValue(int)));
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::translate()
{
    translateCore = new BaiduTranslate();
    for (int i = 0; i < subtitle->line.size(); ++i)
    {
        connect(translateCore, SIGNAL(finished(int, QString)), this, SLOT(getTranslation(int, QString)));
        translateCore->translateText(i, subtitle->line[i],
                                     ui->fromLanguageBox->currentText(),
                                     ui->toLanguageBox->currentText());
    }
    //delete translateCore;
}

void MainWindow::getTranslation(int id, QString ans)
{
    newSubtitle->line[id] = ans;
    ui->textToEdit->setItem(id, 0, new QTableWidgetItem(ans));
    //ui->textToEdit->append(QString("'%1'").arg(id) + ans);
}

void MainWindow::openFromFile()
{
    QString fileDir = QFileDialog::getOpenFileName(
                this,
                tr("添加"),
                ".",
                tr("srt 字幕文件(*.srt)"));
    subtitle->getFromFile(fileDir);
    newSubtitle = subtitle;
    for (int i = 0; i < subtitle->line.size(); ++i)
    {
        ui->textFromEdit->insertRow(i);
        ui->textToEdit->insertRow(i);
        ui->textFromEdit->setItem(i, 0, new QTableWidgetItem(subtitle->line[i]));
    }
}

void MainWindow::saveToFile()
{
    QString fileDir = QFileDialog::getSaveFileName(
                this,
                tr("保存"),
                newSubtitle->filedir+".srt",
                tr("srt 字幕文件(*.srt)"));
    newSubtitle->saveToFile(fileDir);
}
