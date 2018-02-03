
##################################################
#### Dependency Path's
##################################################

#Root include path, blank by default, will default to /usr/include in gcc.
isEmpty(UNIX_INCLUDE_PATH):UNIX_INCLUDE_PATH=

#Root lib path, by default blank by default, will default to /usr/lib in gcc.
isEmpty(UNIX_INCLUDE_PATH):UNIX_LIB_PATH=

#Dependency directories, each can be overridden on the command line individually
#for example:
# qmake "BOOST_INCLUDE_PATH=<Path>" "BOOST_LIB_PATH=<Path>"

#UNIX: By default, all paths are set to the root path's above (Blank by default)

#Boost
isEmpty(BOOST_LIB_SUFFIX):BOOST_LIB_SUFFIX=
isEmpty(BOOST_INCLUDE_PATH):BOOST_INCLUDE_PATH=$$UNIX_INCLUDE_PATH
isEmpty(BOOST_LIB_PATH):BOOST_LIB_PATH=$$UNIX_LIB_PATH

#BerkeleyDB
isEmpty(BDB_INCLUDE_PATH):BDB_INCLUDE_PATH=$$UNIX_INCLUDE_PATH
isEmpty(BDB_LIB_PATH):BDB_LIB_PATH=$$UNIX_LIB_PATH

#OpenSSL
isEmpty(OPENSSL_INCLUDE_PATH):OPENSSL_INCLUDE_PATH=$$UNIX_INCLUDE_PATH
isEmpty(OPENSSL_LIB_PATH):OPENSSL_LIB_PATH=$$UNIX_LIB_PATH

#MiniUPNPC
isEmpty(MINIUPNPC_LIB_SUFFIX):MINIUPNPC_LIB_SUFFIX=
isEmpty(MINIUPNPC_INCLUDE_PATH):MINIUPNPC_INCLUDE_PATH=$$UNIX_INCLUDE_PATH
isEmpty(MINIUPNPC_LIB_PATH):MINIUPNPC_LIB_PATH=$$UNIX_LIB_PATH

#QRenCode
isEmpty(QRENCODE_INCLUDE_PATH):QRENCODE_INCLUDE_PATH=$$UNIX_INCLUDE_PATH
isEmpty(QRENCODE_LIB_PATH):QRENCODE_LIB_PATH=$$UNIX_LIB_PATH

##################################################
#### Compiler Flags
##################################################

# Release Mode: qmake "RELEASE=1"
contains(RELEASE, 1) {
	#Tier 1 warnings, static linking
    LIBS += -Wl,-Bstatic
	
	#Tier 1 warnings, dynamic linking
	#LIBS += -Wl,-Bdynamic
}

#Output targets
OBJECTS_DIR = $$PWD/../build/obj
MOC_DIR = $$PWD/../build/obj
RCC_DIR = $$PWD/../build/obj
UI_DIR = $$PWD/../build/obj
DESTDIR = $$PWD/../bin

#Include GCC specific settings.
include(gcc.pri)

#Enable DBUS (Freedesktop notifications) by default on linux
count(USE_DBUS, 0) {
    USE_DBUS=1
}

##################################################
#### Linux Specifics
##################################################

DEFINES += LINUX
LIBS += -lrt -ldl

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














