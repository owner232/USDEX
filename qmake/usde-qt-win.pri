
##################################################
#### Dependency Path's
##################################################

#If opening with Notepad++, "Makefile" syntax highlighting is recommended.
#Its not exact, but its close enough.

#The DEPENDENCY_FOLDER is the root folder for all the dependencies libraries.
#This can be provided on the command line such as:
#  qmake_vs.bat "DEPENDENCY_FOLDER=<Path>"
#
#If all your dependencies are not in the same directory as DEPENDENCY_FOLDER, you may
#override them individually on the command line in the same way.

!isEmpty(DEPENDENCY_FOLDER) {
	message("Custom Dependency Root: " $$DEPENDENCY_FOLDER)
} else {
	DEPENDENCY_FOLDER=G:/Programming/Libraries
}

#Boost
isEmpty(BOOST_LIB_SUFFIX):BOOST_LIB_SUFFIX=-vc141-mt-1_65
isEmpty(BOOST_INCLUDE_PATH):BOOST_INCLUDE_PATH=$$DEPENDENCY_FOLDER/boost_1_65_0
isEmpty(BOOST_LIB_PATH):BOOST_LIB_PATH=$$DEPENDENCY_FOLDER/boost_1_65_0/stage/lib	

#BerkeleyDB
isEmpty(BDB_INCLUDE_PATH):BDB_INCLUDE_PATH=$$DEPENDENCY_FOLDER/db-5.3.21/build_windows
isEmpty(BDB_LIB_PATH):BDB_LIB_PATH=$$DEPENDENCY_FOLDER/db-5.3.21/build_windows/Win32/Release	

#OpenSSL
isEmpty(OPENSSL_INCLUDE_PATH):OPENSSL_INCLUDE_PATH=$$DEPENDENCY_FOLDER/OpenSSL_1_0_2-stable/inc32
isEmpty(OPENSSL_LIB_PATH):OPENSSL_LIB_PATH=$$DEPENDENCY_FOLDER/OpenSSL_1_0_2-stable/out32

#LevelDB
isEmpty(LEVELDB_INCLUDE_PATH):LEVELDB_INCLUDE_PATH=$$DEPENDENCY_FOLDER/leveldb-master/include
isEmpty(LEVELDB_HELPER_INCLUDE_PATH):LEVELDB_HELPER_INCLUDE_PATH=$$DEPENDENCY_FOLDER/leveldb-master/helpers
isEmpty(LEVELDB_LIB_PATH):LEVELDB_LIB_PATH=$$DEPENDENCY_FOLDER/leveldb-master/bin/Release

#MiniUPNPC
isEmpty(MINIUPNPC_LIB_SUFFIX):MINIUPNPC_LIB_SUFFIX=-miniupnpc
isEmpty(MINIUPNPC_INCLUDE_PATH):MINIUPNPC_INCLUDE_PATH=$$DEPENDENCY_FOLDER
isEmpty(MINIUPNPC_LIB_PATH):MINIUPNPC_LIB_PATH=$$DEPENDENCY_FOLDER/miniupnpc/msvc/Release

#QRenCode
isEmpty(QRENCODE_INCLUDE_PATH):QRENCODE_INCLUDE_PATH=$$DEPENDENCY_FOLDER/qrencode-3.4.4
isEmpty(QRENCODE_LIB_PATH):QRENCODE_LIB_PATH=$$DEPENDENCY_FOLDER/qrencode-3.4.4/.libs

##################################################
#### Compiler Flags
##################################################

#Configure warning level, Release=1, Debug=3
Debug|!isEmpty(MSVC_WARNINGLEVEL_3): QMAKE_CXXFLAGS_WARN_ON *= /W3
else: QMAKE_CXXFLAGS_WARN_ON *= /W1

win32-msvc* {
    #MSVC
	#For extra security on Windows: enable ASLR and DEP
    QMAKE_LFLAGS *= /DYNAMICBASE,/NXCOMPAT,/LARGEADDRESSAWARE
	
	#Explicitly enable buffer security (/GS), this is usually the default but just to be sure.
    QMAKE_CXXFLAGS *= /GS
	
} else {
    #GCC	
	#For extra security on Windows: enable ASLR and DEP
    QMAKE_LFLAGS *= -Wl,--dynamicbase,--nxcompat,--large-address-aware,-static
	
	#Add gcc and stdc++ libs under GCC/MingGW
    QMAKE_LFLAGS += -static-libgcc -static-libstdc++
	
	#Include GCC specific settings.
	include(gcc.pri)
}

#Output targets
OBJECTS_DIR = $$PWD/../build/obj
MOC_DIR = $$PWD/../build/obj
RCC_DIR = $$PWD/../build/obj
UI_DIR = $$PWD/../build/obj
DESTDIR = $$PWD/../bin

##################################################
#### Windows Specifics
##################################################

DEFINES += WIN32
RC_FILE = src/qt/res/bitcoin-qt.rc

#Fix for cross compiling. Ignored by MSVC.
!win32-msvc* {
	!contains(MINGW_THREAD_BUGFIX, 0) {
        # At least qmake's win32-g++-cross profile is missing the -lmingwthrd
        # thread-safety flag. GCC has -mthreads to enable this, but it doesn't
        # work with static linking. -lmingwthrd must come BEFORE -lmingw, so
        # it is perpended to QMAKE_LIBS_QT_ENTRY.
        # It can be turned off with MINGW_THREAD_BUGFIX=0, just in case it causes
        # any problems on some untested qmake profile now or in the future.
        DEFINES += _MT BOOST_THREAD_PROVIDES_GENERIC_SHARED_MUTEX_ON_WIN
        QMAKE_LIBS_QT_ENTRY = -lmingwthrd $$QMAKE_LIBS_QT_ENTRY	
	}
}

##################################################
#### Include/Lib Paths
##################################################

INCLUDEPATH += $$BOOST_INCLUDE_PATH 
INCLUDEPATH += $$BDB_INCLUDE_PATH 
INCLUDEPATH += $$OPENSSL_INCLUDE_PATH 
INCLUDEPATH += $$QRENCODE_INCLUDE_PATH 
INCLUDEPATH += $$LEVELDB_INCLUDE_PATH 
INCLUDEPATH += $$LEVELDB_HELPER_INCLUDE_PATH

LIBS += $$join(BOOST_LIB_PATH,,-L,) 
LIBS += $$join(BDB_LIB_PATH,,-L,) 
LIBS += $$join(OPENSSL_LIB_PATH,,-L,) 
LIBS += $$join(QRENCODE_LIB_PATH,,-L,)
LIBS += $$join(LEVELDB_LIB_PATH,,-L,)

##################################################
#### Libs
##################################################

#LevelDB
win32-msvc* {
    LIBS += -lleveldb
} else {
    include(leveldb_nonmsvc.pri)
}

#OpenSSL
LIBS += -llibeay32 -lssleay32

#BerkeleyDB
LIBS += -llibdb53

#Boost
LIBS += -llibboost_system$$BOOST_LIB_SUFFIX 
LIBS += -llibboost_filesystem$$BOOST_LIB_SUFFIX 
LIBS += -llibboost_program_options$$BOOST_LIB_SUFFIX 
LIBS += -llibboost_thread$$BOOST_LIB_SUFFIX
LIBS += -llibboost_chrono$$BOOST_LIB_SUFFIX

#Misc
LIBS += -lws2_32 -lshlwapi -lmswsock -lole32 -loleaut32 -luuid -lgdi32


















