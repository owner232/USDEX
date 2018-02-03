
#For extra security against potential buffer overflows: enable GCCs Stack Smashing Protection
QMAKE_CXXFLAGS *= -fstack-protector-all --param ssp-buffer-size=1
QMAKE_LFLAGS *= -fstack-protector-all --param ssp-buffer-size=1

#Detect 32bit
*-g++-32 {
    message("32bit platform detected, adding -msse2 flag")
    QMAKE_CXXFLAGS += -msse2
    QMAKE_CFLAGS += -msse2
}

#Is this still necessary? commented until figured out
#QMAKE_CXXFLAGS += -march=i686

#Set warnings
QMAKE_CXXFLAGS_WARN_ON = -Wformat -Wformat-security -Wstack-protector
!isEmpty(GCC_ALL_WARNINGS):QMAKE_CXXFLAGS_WARN_ON *= -Wall -Wextra -fdiagnostics-show-option -Wno-ignored-qualifiers -Wno-unused-parameter