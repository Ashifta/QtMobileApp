#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QJsonDocument>
#include <QJsonObject>

#include <QUrlQuery>
#include <QMessageAuthenticationCode>
#include "networkmanager.h"

const static QString APPKEYVALUE = "4ee73f8a589a89d835614f4be0c7fbbe";
const static QString APPKEY = "appKey";
const static QString USERNKEY = "username";
const static QString PASSWORDKEY = "password";
const static QString ACC_TYPEKEY = "acc_type";

const static QString USER_ID = "userid";

const static QString FULLNAMEKEY = "fullname";
const static QString PHONEKEY = "phone";
const static QString MOBILEKEY = "mobile";


const static QString EMAILKEY = "email";
const static QString REFERRAL_CODEKEY = "referral_code";
const static QString OTPKEY = "otp";

const static QString LATITUDEKEY = "latitude";
const static QString LONGITUDEKEY = "longitude";

const static QString STATUSKEY = "status";
const static QString TIMEKEY = "time";

const static QString FROM_LATITUDEKEY = "from_latitude";
const static QString TO_LATITUDEKEY = "to_latitude";

const static QString FROM_LONGITUDEKEY = "from_longitude";
const static QString TO_LONGITUDEKEY = "to_longitude";
const static QString CAB_TYPE = "cab_type";

const static QString PAY_MODEKEY = "pay_mode";
const static QString COUPON_IDKEY = "coupon_id";

const static QString TRIPIDKEY = "tripid";
const static QString REASONKEY = "reason";

const static QString LATEKEY = "late";
const static QString WAITINGKEY = "waiting";
const static QString DISTANCEKEY = "distance";

const static QString AMOUNTKEY = "amount";
const static QString RATEKEY = "rate";
const static QString COMMENTKEY = "comment";

//This link is not working, you can add valid url.
const static QString BASEURL("http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/admin/android/Passenger/");

NetworkManager::NetworkManager()
    :QObject()
    ,m_userID("10")
{
    m_manager = new QNetworkAccessManager(this);
}

void NetworkManager::loginAction(QString userName, QString password)
{
    QUrlQuery queryData;
    queryData.addQueryItem(USERNKEY, userName);
    queryData.addQueryItem(PASSWORDKEY, password);
    queryData.addQueryItem(ACC_TYPEKEY, "normal");


    QString actionName("login");

    m_currentActionType = login;
    postRequest(queryData, actionName);
}

//This should be removed Ashif
void NetworkManager::loginDriverAction(QString userName, QString password)
{
    QUrlQuery queryData;
    queryData.addQueryItem(USERNKEY, userName);
    queryData.addQueryItem(PASSWORDKEY, password);
   // queryData.addQueryItem(ACC_TYPEKEY, "normal");


    QString actionName("login");

    m_currentActionType = login;
    postRequest(queryData, actionName);
}

void NetworkManager::registerAction(QString userName, QString password, QString fullname, QString mobileNumber, QString email, QString referelcode)
{
    QUrlQuery queryData;
    queryData.addQueryItem(USERNKEY, userName);
    queryData.addQueryItem(PASSWORDKEY, password);
    queryData.addQueryItem(FULLNAMEKEY, fullname);
    //TODO
    //This is not proper way.
    queryData.addQueryItem(MOBILEKEY,   mobileNumber.replace("+", "00"));
    queryData.addQueryItem(EMAILKEY,  email);
    queryData.addQueryItem(REFERRAL_CODEKEY,  referelcode);
    queryData.addQueryItem(ACC_TYPEKEY,  "normal");

    m_currentActionType = registerpassenger;
    QString actionName("register");
    postRequest(queryData, actionName);
}

void NetworkManager::verifyaccountAction( QString OTP)
{
    QUrlQuery queryData;
    queryData.addQueryItem(OTPKEY, OTP);
    queryData.addQueryItem(USER_ID, m_userID);

    m_currentActionType = verifyaccount;
    QString actionName("verifyaccount");
    postRequest(queryData, actionName);
}

void NetworkManager::forgotpasswordAction(QString mobileNumber)
{
   QUrlQuery queryData;
   queryData.addQueryItem(PHONEKEY, mobileNumber.replace("+", "00"));

   m_currentActionType = forgotpassword;
   QString actionName("forgotpassword");
   postRequest(queryData, actionName);
}

void NetworkManager::setlocationAction(QString latitude, QString longitude, QString status)
{
    QUrlQuery queryData;
    queryData.addQueryItem(LATITUDEKEY, latitude);
    queryData.addQueryItem(LONGITUDEKEY,longitude);
    queryData.addQueryItem(USERNKEY, "2");
    queryData.addQueryItem(TIMEKEY,  "1954-12-12 12:33:45");
    queryData.addQueryItem(STATUSKEY,status);

    m_currentActionType = setlocation;
    QString actionName("location");
    postRequest(queryData, actionName);
}

void NetworkManager::resendotpAction()
{
    QUrlQuery queryData;
    queryData.addQueryItem(USER_ID, m_userID);

    m_currentActionType = resendotp;
    QString actionName("resendotp");
    postRequest(queryData, actionName);
}


void NetworkManager::termsandconditionsAction()
{
    QUrlQuery queryData;
    m_currentActionType = termsandconditions;
    QString actionName("termsandconditions");
    postRequest(queryData, actionName);
}


void NetworkManager::nearestdriversAction(QString latitude, QString longitude)
{
    QUrlQuery queryData;
    queryData.addQueryItem(LATITUDEKEY, latitude);
    queryData.addQueryItem(LONGITUDEKEY, longitude);

    m_currentActionType = nearestdrivers;
    QString actionName("nearestdrivers");
    postRequest(queryData, actionName);
}

void NetworkManager::bookjourneyAction(QString fromLat, QString fromLongitude, QString toLat, QString toLongitude, QString cabType, QString paymentMode, QString coupenID)
{
    QUrlQuery queryData;
    queryData.addQueryItem(FROM_LATITUDEKEY,fromLat);
    queryData.addQueryItem(FROM_LONGITUDEKEY, fromLongitude);
    queryData.addQueryItem(TO_LATITUDEKEY, toLat);
    queryData.addQueryItem(TO_LONGITUDEKEY, toLongitude);
    queryData.addQueryItem(CAB_TYPE, cabType);
    queryData.addQueryItem(PAY_MODEKEY,  paymentMode);
    queryData.addQueryItem(COUPON_IDKEY,  coupenID);

    m_currentActionType = bookjourney;
    QString actionName("bookjourney");
    postRequest(queryData, actionName);
}

void NetworkManager::assignmydriverAction(QString tripID)
{
    QUrlQuery queryData;
    queryData.addQueryItem(TRIPIDKEY,  tripID);

    m_currentActionType = assignmydriver;
    QString actionName("assignmydriver");
    postRequest(queryData, actionName);
}

void NetworkManager::checkmydriverAction(QString tripID)
{
    QUrlQuery queryData;
    queryData.addQueryItem(TRIPIDKEY,  tripID);

    m_currentActionType = checkmydriver;
    QString actionName("checkmydriver");
    postRequest(queryData, actionName);
}

void NetworkManager::trackdriverAction()
{
    QUrlQuery queryData;
    queryData.addQueryItem(USERNKEY,"10");

    m_currentActionType = trackdriver;
    QString actionName("trackdriver");
    postRequest(queryData, actionName);
}

void NetworkManager::tripcancelAction(QString isLate, QString reason)
{
    QUrlQuery queryData;
    queryData.addQueryItem(USERNKEY, "10");
    queryData.addQueryItem(REASONKEY, reason);
    queryData.addQueryItem(LATEKEY, isLate);

    m_currentActionType = tripcancel;
    QString actionName("tripcancel");
    postRequest(queryData, actionName);

}

void NetworkManager::showbalanceAction()
{
    QUrlQuery queryData;
    queryData.addQueryItem(USERNKEY, "10");

    m_currentActionType = showbalance;
    QString actionName("showbalance");
    postRequest(queryData, actionName);

}

void NetworkManager::ratedriverAction(QString tripID, QString rate, QString comment)
{
    QUrlQuery queryData;
    queryData.addQueryItem(TRIPIDKEY, tripID);
    queryData.addQueryItem(RATEKEY,  rate);
    queryData.addQueryItem(COMMENTKEY, comment);

    m_currentActionType = ratedriver;
    QString actionName("ratedriver");
    postRequest(queryData, actionName);
}

void NetworkManager::ratesAction()
{
    QUrlQuery queryData;

    m_currentActionType = rates;
    QString actionName("rates");
    postRequest(queryData, actionName);
}

void NetworkManager::postRequest(QUrlQuery& postData, QString actionName)
{
    emit showServerProgress(true);
    QUrl   url(BASEURL+actionName);
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,"application/x-www-form-urlencoded");

    postData.addQueryItem("appkey",  "4ee73f8a589a89d835614f4be0c7fbbe");
   // postData.addQueryItem("appkey",  "c5113a5a9ee3d16baa274d2d0080f7bd");

    QNetworkReply *reply =    m_manager->post(request, postData.toString(QUrl::FullyEncoded).toUtf8());
    connect(reply, SIGNAL(readyRead()), this, SLOT(slotReadyRead()));
    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)),
            this, SLOT(slotError(QNetworkReply::NetworkError)));
    connect(reply, SIGNAL(sslErrors(QList<QSslError>)),
            this, SLOT(slotSslErrors(QList<QSslError>)));

}

bool NetworkManager::loginActionResponse(const QJsonObject &json)
{
    if( json["status"].toBool() == true &&
        json["message"].toString() == "Login Success!")
    {
         qDebug()<< "Login Success!";
         emit switchScreen("mapview");
    }
    else if(json["message"].toString().contains("Username or Password Incorrect!") )
    {
          emit errorResponse("login", "Username or Password Incorrect!");
    }
}

bool NetworkManager::registerActionResponse(const QJsonObject &json)
{
    if( json["status"].toBool() == true &&
        json["message"].toString() == "Registered Successfully. Confirm your account by entering the verification number received.")
    {
         qDebug()<< "Login Success!";
         emit switchScreen("validateotp");
    }
    else if(json["message"].toString().contains("Mobile Already Registered!") )
    {
          emit errorResponse("Register", "Mobile Already Registered!");
    }
    else if(json["message"].toString().contains("Email Already Registered!") )
    {
          emit errorResponse("Register", "Email Already Registered!");
    }
    else if(json["message"].toString().contains("Username Already Registered") )
    {
          emit errorResponse("Register", "Username Already Registered!");
    }

    qDebug()<<json["message"].toString();

}

bool NetworkManager::verifyaccountActionResponse(const QJsonObject &json)
{
        if( json["status"].toBool() == true &&
            json["message"].toString() == "Account Verified Successfully.")
        {
             emit switchScreen("mapview");
        }
        else if(json["message"].toString().contains("Account Verification Failed") )
        {
             emit errorResponse("VerifyAccount", "Account Verification Failed!");
        }
        else
        {

        }
        qDebug()<<json["message"].toString();
}

bool NetworkManager::forgotpasswordActionResponse(const QJsonObject &json)
{
    if( json["status"].toBool() == true &&
        json["message"].toString() == "OTP Send!")
    {
         m_userID = json["data"].toObject()["user_id"].toString();
         qDebug()<< m_userID;
         emit switchScreen("validateotp");
    }
    else if(json["message"].toString().contains("Phone not registered!") )
    {
         emit errorResponse("ForgotPassword", "Phone not registered!");
    }
    else
    {

    }
}

bool NetworkManager::setlocationActionResponse(const QJsonObject &json)
{

}

bool NetworkManager::resendotpActionResponse(const QJsonObject &json)
{
    if( json["status"].toBool() == true &&
        json["message"].toString() == "Verification number Resend!")
    {
        // emit switchScreen("mapview");
    }
    else if(json["message"].toString().contains("Resend Failed, Please try again!") )
    {
         emit errorResponse("VerifyAccount", "Resend Failed, Please try again!");
    }
    else
    {

    }
}

bool NetworkManager::termsandconditionsResponse(const QJsonObject &json)
{
    if( json["status"].toBool() == true &&
        json["message"].toString() == "Content")
    {
        // emit switchScreen("mapview");
    }
    else
    {

    }
}

bool NetworkManager::nearestdriversActionResponse(const QJsonObject &json)
{

}

bool NetworkManager::bookjourneyActionResponse(const QJsonObject &json)
{

}

bool NetworkManager::assignmydriverActionResponse(const QJsonObject &json)
{

}

bool NetworkManager::checkmydriverActionResponse(const QJsonObject &json)
{

}

bool NetworkManager::trackdriverActionResponse(const QJsonObject &json)
{

}

bool NetworkManager::tripcancelActionResponse(const QJsonObject &json)
{

}

bool NetworkManager::showbalanceActionResponse(const QJsonObject &json)
{

}

bool NetworkManager::ratedriverActionResponse(const QJsonObject &json)
{

}

bool NetworkManager::ratesActionResponse(const QJsonObject &json)
{

}
void NetworkManager::slotReadyRead()
{
    QNetworkReply* object = qobject_cast<QNetworkReply*>(sender());
    QByteArray saveData = object->readAll();

    //Bug in Qt, so we use this to strip out
    int index = saveData.indexOf(" array{");
    QByteArray& arrayStripped = saveData.remove(0, index+6);

    qDebug()<<arrayStripped;

       QJsonDocument loadDoc(QJsonDocument::fromJson(arrayStripped));


       read(loadDoc.object());


    //qDebug()<< m_response;
}

void NetworkManager::read(const QJsonObject &json)
{
    emit showServerProgress(false);
    switch (m_currentActionType) {
    case login:
        loginActionResponse(json);
        break;
    case registerpassenger:
        registerActionResponse(json);
        break;
    case verifyaccount:
        verifyaccountActionResponse(json);
        break;
    case forgotpassword:
        forgotpasswordActionResponse(json);
        break;
    case setlocation:

        break;
    case resendotp:
        resendotpActionResponse(json);
        break;
    case termsandconditions:
        termsandconditionsResponse(json);
        break;
    case nearestdrivers:

        break;
    case bookjourney:

        break;
    case assignmydriver:

        break;
    case checkmydriver:

        break;
    case trackdriver:

        break;
    case tripcancel:

        break;
    case showbalance:

        break;
    case ratedriver:

        break;
    case rates:

        break;
    default:
        break;
    }

}

void NetworkManager::slotError(QNetworkReply::NetworkError err)
{
    showServerProgress(false);
    errorResponse("Error", "Network Error!!!");

}

void NetworkManager::slotSslErrors(QList<QSslError> ls)
{
    showServerProgress(false);
    errorResponse("Error", "Network Error!!!");
}



//void NetworkManager::login(QString userName, QString password)
//{
////    QNetworkRequest request;
////    request.setUrl(QUrl("http://qt-project.org"));
////    request.setRawHeader("User-Agent", "MyOwnBrowser 1.0");


////    QNetworkReply *reply = m_manager->get(request);
////    connect(reply, SIGNAL(readyRead()), this, SLOT(slotReadyRead()));
////    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)),
////            this, SLOT(slotError(QNetworkReply::NetworkError)));
////    connect(reply, SIGNAL(sslErrors(QList<QSslError>)),
////            this, SLOT(slotSslErrors(QList<QSslError>)));

//    QUrlQuery postData;

////    QByteArray key = "Infinite_MLM_Cab_Management_System@passenger_login";
////      //QByteArray message = "The quick brown fox jumps over the lazy dog";
////      QMessageAuthenticationCode code(QCryptographicHash::Md5);
////      code.setKey(key);
////      //code.addData(message);
////      qDebug()<<code.result().toHex();
////      QString str(code.result());

//   // This is not required for us, this is for driver app.
//    //http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/admin/android/Driver/login
////        postData.addQueryItem("appkey",  "c5113a5a9ee3d16baa274d2d0080f7bd");
////        postData.addQueryItem("username", "driver1");
////        postData.addQueryItem("password", "password");
////        postData.addQueryItem("acc_type", "driver");

////    //http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/admin/android/Passenger/login
////        postData.addQueryItem("appkey",  "4ee73f8a589a89d835614f4be0c7fbbe");

//    //"http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/admin/android/Passenger/register"
//    //    postData.addQueryItem("appkey",  "4ee73f8a589a89d835614f4be0c7fbbe");
//    //    postData.addQueryItem("username", "ashif.ta");
//    //    postData.addQueryItem("password", "qazXSW");
//    //    postData.addQueryItem("fullname", "ashif.ta");
//    //    postData.addQueryItem("mobile",  "00917760889950");
//    //    postData.addQueryItem("email", "lintukh@yahoo.co.in");
//    //    postData.addQueryItem("referral_code", "");
//    //    postData.addQueryItem("acc_type", "normal");


////    //"http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/admin/android/Passenger/verifyaccount"
////     postData.addQueryItem("appkey",  "4ee73f8a589a89d835614f4be0c7fbbe");
////     postData.addQueryItem("otp", "130297");
////     postData.addQueryItem("userid", "10");

//////      //"http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/admin/android/Passenger/forgotpassword"
////      postData.addQueryItem("appkey",  "4ee73f8a589a89d835614f4be0c7fbbe");
////      postData.addQueryItem("phone", "00917760889950");


//////    //"http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/admin/android/Driver/cation"
////    postData.addQueryItem("appkey",  "c5113a5a9ee3d16baa274d2d0080f7bd");
////    postData.addQueryItem("latitude", "10.0718");
////    postData.addQueryItem("longitude", "76.5488");
////    postData.addQueryItem("userid", "2");
////    postData.addQueryItem("time",  "1954-12-12 12:33:45");
////    postData.addQueryItem("status", "true");


//    //"http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/admin/android/Passenger/+=+++++++cation"
////    postData.addQueryItem("appkey",  "4ee73f8a589a89d835614f4be0c7fbbe");
////    postData.addQueryItem("latitude", "10.0718");
////    postData.addQueryItem("longitude", "76.5488");
////    postData.addQueryItem("userid", "10");
////    postData.addQueryItem("time",  "2016-07-27 09:33:45");
////    postData.addQueryItem("status", "true");


////    //"http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/admin/android/Passenger/resendotp"
////    postData.addQueryItem("appkey",  "4ee73f8a589a89d835614f4be0c7fbbe");
////    postData.addQueryItem("userid", "10");


////        //    //"http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/admin/android/Passenger/nearestdrivers/*"
////            postData.addQueryItem("appkey",  "4ee73f8a589a89d835614f4be0c7fbbe");
////            postData.addQueryItem("latitude", "10.0718");
////            postData.addQueryItem("longitude", "76.5488");

//            //"http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/admin/android/Passenger/bookjourney"
//    //first create tem trip details, user must call "checkmydriver" api with trip id so the request will be go to corresponding driver.
////            postData.addQueryItem("appkey",  "4ee73f8a589a89d835614f4be0c7fbbe");
////            postData.addQueryItem("from_latitude", "10.0718");
////            postData.addQueryItem("from_longitude", "76.5488");
////            postData.addQueryItem("to_latitude", "10.0798");
////            postData.addQueryItem("to_longitude", "76.5498");
////            postData.addQueryItem("cabtype", "sedan");
////            postData.addQueryItem("pay_mode",  "cash");
////            postData.addQueryItem("coupon_id",  "W9Eyh");
////            postData.addQueryItem("userid", "10");


//    //"http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/admin/android/Passenger/assignmydriver" and checkmydriver
////////    //assignmydriver should not have no response. since it is nothing t do, we use checkmydriver for polling status of booking confirmation.
////    postData.addQueryItem("appkey",  "4ee73f8a589a89d835614f4be0c7fbbe");
////    postData.addQueryItem("tripid",  "CM_1016");


//    //"http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/admin/android/Passenger/trackdriver"
////    //*temp Trip id need to display
////    postData.addQueryItem("appkey",  "4ee73f8a589a89d835614f4be0c7fbbe");
////    postData.addQueryItem("tripid",  "CM_1010");
////    postData.addQueryItem("userid", "10");


//    //"http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/admin/android/Passenger/tripcancel"
////    //*temp Trip id need to display
////    postData.addQueryItem("appkey",  "4ee73f8a589a89d835614f4be0c7fbbe");
////    postData.addQueryItem("tripid",  "CM_1015");
////    postData.addQueryItem("userid", "10");
////    postData.addQueryItem("reason",  "chumma");
////    postData.addQueryItem("late", "yes");

////    //"http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/admin/android/Driver/updatetriprequest"
//////    if status is 1, then driver is accespted, then message will be recieved on
//////    //any driver can accept the call, whoever press first can be accepted. meseege will be recied in driver app too.
////////    //Now driver can move to the specified location to pick up customer.
////    postData.addQueryItem("appkey",  "c5113a5a9ee3d16baa274d2d0080f7bd");
////    postData.addQueryItem("tripid",  "CM_1016");
////    postData.addQueryItem("userid", "1");
////    postData.addQueryItem("status", "1");//if driver accepted.then temptrip table, driver id will be displayed.


//    //"http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/admin/android/Driver/tripcancel"
////    if status is 1, then driver is accespted, then message will be recieved on
////    //any driver can accept the call, whoever press first can be accepted. meseege will be recied in driver app too.
//////    //Now driver can move to the specified location to pick up customer.
////    postData.addQueryItem("appkey",  "c5113a5a9ee3d16baa274d2d0080f7bd");
////    postData.addQueryItem("tripid",  "CM_1010");
////    postData.addQueryItem("userid", "1");
////    postData.addQueryItem("reason", "passenger is not good");//if driver accepted.then temptrip table, driver id will be displayed.


////    //setarrival
////    //    //Now driver can move to the specified location to pick up customer.
////        postData.addQueryItem("appkey",  "c5113a5a9ee3d16baa274d2d0080f7bd");
////        postData.addQueryItem("tripid",  "CM_1010");
////        postData.addQueryItem("userid", "1");

//    //starttrip
////        //Now driver can move to the specified location to pick up customer.
////        postData.addQueryItem("appkey",  "c5113a5a9ee3d16baa274d2d0080f7bd");
////        postData.addQueryItem("tripid",  "CM_1011");
////        postData.addQueryItem("userid", "1");
////        postData.addQueryItem("time", "2016-07-27 09:33:45");
////        postData.addQueryItem("passenger_id", "10");
////        postData.addQueryItem("from_latitude", "10.0718");
////        postData.addQueryItem("from_longitude", "76.5488");


//    //endtrip
//    //    //Now driver can move to the specified location to pick up customer.
////        postData.addQueryItem("appkey",  "c5113a5a9ee3d16baa274d2d0080f7bd");
////        postData.addQueryItem("tripid",  "CM_1013");
////        postData.addQueryItem("userid", "1");
////        postData.addQueryItem("time", "2016-07-27 10:33:45");//if driver accepted.then temptrip table, driver id will be displayed.
////        postData.addQueryItem("passenger_id", "10");
////        postData.addQueryItem("to_latitude", "10.0718");
////        postData.addQueryItem("to_longitude", "76.5488");
////        postData.addQueryItem("waiting", "1000");
////        postData.addQueryItem("distance", "7");


//    //addto_passenger_ewallet
////    //    //Now driver can move to the specified location to pick up customer.
////        postData.addQueryItem("appkey",  "c5113a5a9ee3d16baa274d2d0080f7bd");
////        postData.addQueryItem("tripid",  "CM_1011");
////        postData.addQueryItem("amount", "1000");

////    //showbalance
////    postData.addQueryItem("appkey",  "4ee73f8a589a89d835614f4be0c7fbbe");
////    postData.addQueryItem("userid", "10");

//        //ratedriver
////        postData.addQueryItem("appkey",  "4ee73f8a589a89d835614f4be0c7fbbe");
////        postData.addQueryItem("trip_id", "CM_1011");
////        postData.addQueryItem("rate",  "5");
////        postData.addQueryItem("comment", "good cab");

//    //rates
//        postData.addQueryItem("appkey",  "4ee73f8a589a89d835614f4be0c7fbbe");




////http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/
//    QNetworkRequest request(QUrl("http://ec2-52-77-210-227.ap-southeast-1.compute.amazonaws.com/admin/android/Passenger/rates"));
//    request.setHeader(QNetworkRequest::ContentTypeHeader,
//        "application/x-www-form-urlencoded");

//    QNetworkReply *reply =    m_manager->post(request, postData.toString(QUrl::FullyEncoded).toUtf8());
//    connect(reply, SIGNAL(readyRead()), this, SLOT(slotReadyRead()));
//    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)),
//            this, SLOT(slotError(QNetworkReply::NetworkError)));
//    connect(reply, SIGNAL(sslErrors(QList<QSslError>)),
//            this, SLOT(slotSslErrors(QList<QSslError>)));



//}

