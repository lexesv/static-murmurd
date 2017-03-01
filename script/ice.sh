#!/bin/bash

apk add mcpp-libs mcpp mcpp-dev bzip2 bzip2-libs

cd /build

wget https://github.com/zeroc-ice/ice/archive/v3.6.3.tar.gz  && tar xf v3.6.3.tar.gz

cd ice-3.6.3

sed -ri "s/^MACHINE_TYPE/STATICLIBS = yes\n\n\0/" config/Make.common.rules

sed -ri "s/-Werror/-Wno-error/" cpp/config/Make.rules.Linux

sed -ri "s/-lIceUtil/\0 -lbz2 -lmcpp -lcrypto/" cpp/config/Make.rules.Linux

sed -ri "s/__GNUC__\)/\0 \&\& defined(__GLIBC__)/" cpp/src/IceUtil/Exception.cpp

sed -ri "s/defined\(__linux\) \&\& \!defined\(__USE_UNIX98\)/\0 \&\& defined(PTHREAD_MUTEX_ERRORCHECK_NP)/" cpp/src/IceUtil/RecMutex.cpp

sed -ri "s/defined\(__linux\) \&\& \!defined\(__USE_UNIX98\)/\0 \&\& defined(PTHREAD_MUTEX_ERRORCHECK_NP)/" cpp/include/IceUtil/Mutex.h

wget https://raw.githubusercontent.com/lexesv/static-murmurd/master/files/icessl.patch -O cpp/icessl.patch

patch -p0 < cpp/icessl.patch

mv cpp/test cpp/test.off

cd cpp && make -j$CPUN

make install
