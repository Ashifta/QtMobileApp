TEMPLATE = app
TARGET = gallery
QT += quick network webview

SAMPLE_FILES += \
              pages\index.html
android {
    # android platform
    # From: http://community.kde.org/Necessitas/Assets
    SAMPLES_INSTALL_PATH=/assets/Samples
# - setup the 'make install' step
samples.path = $$SAMPLES_INSTALL_PATH
samples.files += $$SAMPLE_FILES
samples.depends += FORCE
DEFINES +=  QT_ANDROID
INSTALLS += samples
}
else

{
    DEFINES +=  QT_UBUNTUU

}




 CONFIG+=qml_debug

SOURCES += \
    main.cpp \
    networkmanager.cpp

OTHER_FILES += \
    main.qml

RESOURCES += \
    pages.qrc \
    menudrawer.qrc \
    launch.qrc \
    controls.qrc \
    commmonIcon.qrc

#target.path = /home/ashif/Desktop/bin
#INSTALLS += target

DESTDIR += "/home/ashif/Desktop/bin"

DISTFILES += \
    scratchpad \
    loginform.qml \
    utils.js

HEADERS += \
    networkmanager.h
