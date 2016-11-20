#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

class TranslateCore;
class Subtitle;

namespace Ui {
    class MainWindow;
}

class MainWindow : public QMainWindow
{
        Q_OBJECT

    public:
        explicit MainWindow(QWidget *parent = 0);
        ~MainWindow();

    protected slots:
        void translate();
        void getTranslation(int id, QString ans);
        void openFromFile();
        void saveToFile();

    private:
        Ui::MainWindow *ui;
        Subtitle *subtitle;
        Subtitle *newSubtitle;
        TranslateCore *translateCore;
};

#endif // MAINWINDOW_H
