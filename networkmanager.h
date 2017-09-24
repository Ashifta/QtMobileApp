#ifndef NETWORKMANAGER_H
#define NETWORKMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QList>
#include <QSslError>

class NetworkManager: public QObject
{
    Q_OBJECT

public:

    Q_ENUMS(Actions)
    enum Actions {
        login,
        registerpassenger,
        verifyaccount,
        forgotpassword,
        setlocation,
        termsandconditions,
        resendotp,
        nearestdrivers,
        bookjourney,
        assignmydriver,
        checkmydriver,
        trackdriver,
        tripcancel,
        showbalance,
        ratedriver,
        rates
         };


    NetworkManager();

    Q_PROPERTY(QString userImage READ userImage NOTIFY userImageChanged)
    Q_PROPERTY(QString response READ response NOTIFY responseRecieved)

    QString userImage() const
    {
        return m_userImage;
    }

    QString response() const
    {
        return m_response;
    }

    Q_INVOKABLE void loginAction(QString userName, QString password);

    Q_INVOKABLE void loginDriverAction(QString userName, QString password);

    Q_INVOKABLE void registerAction(QString userName, QString password, QString fullname, QString mobileNumber, QString email, QString referelcode);

    Q_INVOKABLE void verifyaccountAction( QString  OTP);

    Q_INVOKABLE void forgotpasswordAction(QString  mobileNumber);

    Q_INVOKABLE void setlocationAction(QString latitude, QString longitude, QString status );

    Q_INVOKABLE void resendotpAction();

    Q_INVOKABLE void termsandconditionsAction();

    Q_INVOKABLE void nearestdriversAction(QString latitude, QString longitude);

    Q_INVOKABLE void bookjourneyAction(QString fromLat, QString fromLongitude, QString toLat, QString toLongitude, QString cabType, QString paymentMode, QString coupenID);

    Q_INVOKABLE void assignmydriverAction(QString tripID);

    Q_INVOKABLE void checkmydriverAction(QString tripID);

    Q_INVOKABLE void trackdriverAction();

    Q_INVOKABLE void tripcancelAction(QString isLate, QString reason);

    Q_INVOKABLE void showbalanceAction();

    Q_INVOKABLE void ratedriverAction(QString tripID, QString rate, QString comment);

    Q_INVOKABLE void ratesAction();

public slots:
    void slotReadyRead();
    void slotError(QNetworkReply::NetworkError);
    void slotSslErrors(QList<QSslError>);

signals:
    void userImageChanged();
    void responseRecieved();
    void switchScreen(QString name);
    void errorResponse(QString actionName, QString error);
    void showServerProgress(bool isShow);

private:
    void postRequest(QUrlQuery& postData, QString actionName);


    bool loginActionResponse( const QJsonObject &json );
    bool registerActionResponse( const QJsonObject &json );
    bool verifyaccountActionResponse( const QJsonObject &json );
    bool forgotpasswordActionResponse( const QJsonObject &json );
    bool setlocationActionResponse( const QJsonObject &json );
    bool resendotpActionResponse( const QJsonObject &json );
    bool termsandconditionsResponse(const QJsonObject &json);
    bool nearestdriversActionResponse( const QJsonObject &json );
    bool bookjourneyActionResponse( const QJsonObject &json );
    bool assignmydriverActionResponse( const QJsonObject &json );
    bool checkmydriverActionResponse( const QJsonObject &json );
    bool trackdriverActionResponse( const QJsonObject &json );
    bool tripcancelActionResponse( const QJsonObject &json );
    bool showbalanceActionResponse( const QJsonObject &json );
    bool ratedriverActionResponse( const QJsonObject &json );
    bool ratesActionResponse( const QJsonObject &json );


    void read(const QJsonObject &json);
    QNetworkAccessManager *m_manager;
    QString m_userImage;
    QString m_response;
    QNetworkRequest m_NetworkRequest;
    Actions m_currentActionType;
    QString m_userID;

};

#endif // NETWORKMANAGER_H
