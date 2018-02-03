
##################################################
#### Dependency Path's
##################################################

#Dependency directories, each can be overridden on the command line individually
#for example:
# qmake "BOOST_INCLUDE_PATH=<Path>" "BOOST_LIB_PATH=<Path>"

#Boost
isEmpty(BOOST_LIB_SUFFIX):BOOST_LIB_SUFFIX=
isEmpty(BOOST_INCLUDE_PATH):BOOST_INCLUDE_PATH=/usr/local/opt/boost@1.55/include
isEmpty(BOOST_LIB_PATH):BOOST_LIB_PATH=/usr/local/opt/boost@1.55/lib

#BerkeleyDB
isEmpty(BDB_INCLUDE_PATH):BDB_INCLUDE_PATH=/opt/local/include/db48
isEmpty(BDB_LIB_PATH):BDB_LIB_PATH=/opt/local/lib/db48

#OpenSSL
isEmpty(OPENSSL_INCLUDE_PATH):OPENSSL_INCLUDE_PATH=/opt/local/include
isEmpty(OPENSSL_LIB_PATH):OPENSSL_LIB_PATH=/opt/local/lib/

#MiniUPNPC
isEmpty(MINIUPNPC_LIB_SUFFIX):MINIUPNPC_LIB_SUFFIX=
isEmpty(MINIUPNPC_INCLUDE_PATH):MINIUPNPC_INCLUDE_PATH=/opt/local/include
isEmpty(MINIUPNPC_LIB_PATH):MINIUPNPC_LIB_PATH=/opt/local/lib/

#QRenCode
isEmpty(QRENCODE_INCLUDE_PATH):QRENCODE_INCLUDE_PATH=/opt/local/include
isEmpty(QRENCODE_LIB_PATH):QRENCODE_LIB_PATH=/opt/local/lib

##################################################
#### Compiler Flags
##################################################

# Release Mode: use qmake "RELEASE=1"
contains(RELEASE, 1) {
# Mac: compile for maximum compatibility (10.5, 32-bit)
# You may need to provide the correct path to your SDK using:
#   qmake "MACOSX_SDKPATH=<Path>"
    isEmpty(MACOSX_SDKPATH):MACOSX_SDKPATH=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk
    QMAKE_CXXFLAGS += -mmacosx-version-min=10.5 -arch x86_64 -isysroot $$MACOSX_SDKPATH
}

#Output targets
OBJECTS_DIR = $$PWD/../build/obj
MOC_DIR = $$PWD/../build/obj
RCC_DIR = $$PWD/../build/obj
UI_DIR = $$PWD/../build/obj
DESTDIR = $$PWD/../bin

#Include GCC specific settings.
include(gcc.pri)

##################################################
#### OSX Specifics
##################################################

HEADERS += src/qt/macdockiconhandler.h
OBJECTIVE_SOURCES += src/qt/macdockiconhandler.mm
LIBS += -framework Foundation -framework ApplicationServices -framework AppKit
DEFINES += MAC_OSX MSG_NOSIGNAL=0
ICON = src/qt/res/icons/bitcoin.icns
TARGET = "USDEX-Qt"
QMAKE_CFLAGS_THREAD += -pthread
QMAKE_LFLAGS_THREAD += -pthread
QMAKE_CXXFLAGS_THREAD += -pthread

##################################################
#### Include/Lib Paths
##################################################

INCLUDEPATH += $$BOOST_INCLUDE_PATH 
INCLUDEPATH += $$BDB_INCLUDE_PATH 
INCLUDEPATH += $$OPENSSL_INCLUDE_PATH 
INCLUDEPATH += $$QRENCODE_INCLUDE_PATH

LIBS += $$join(BOOST_LIB_PATH,,-L,) 
LIBS += $$join(BDB_LIB_PATH,,-L,) 
LIBS += $$join(OPENSSL_LIB_PATH,,-L,) 
LIBS += $$join(QRENCODE_LIB_PATH,,-L,)

##################################################
#### Libs
##################################################

#LevelDB
include(leveldb_nonmsvc.pri)

#OpenSSL
LIBS += -lssl -lcrypto 

#BerkeleyDB
LIBS += -ldb_cxx

#Boost
LIBS += -lboost_system$$BOOST_LIB_SUFFIX 
LIBS += -lboost_filesystem$$BOOST_LIB_SUFFIX 
LIBS += -lboost_program_options$$BOOST_LIB_SUFFIX 
LIBS += -lboost_thread$$BOOST_THREAD_LIB_SUFFIX





























