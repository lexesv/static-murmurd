**1. INSTALL VIRTUALBOX 5**

min 20Gb dinamic VDI

**2. INSTALL ALPINE LINUX**

[Download] (https://nl.alpinelinux.org/alpine/v3.5/releases/x86_64/alpine-extended-3.5.1-x86_64.iso)

Edit file /etc/apk/repositories

> \# /media/cdrom/apks

> http://mirror.leaseweb.com/alpine/v3.5/main

> http://mirror.leaseweb.com/alpine/v3.5/community

> http://mirror.leaseweb.com/alpine/edge/main

> http://mirror.leaseweb.com/alpine/edge/community

> http://mirror.leaseweb.com/alpine/edge/testing

`apk update && apk upgrade

**3. QT5**

``CPUN=`cat /proc/cpuinfo | grep processor | wc -l```

`mkdir /build && cd /build`

`apk add mc mesa-dev libice-dev libsm-dev libx11-dev libxext-dev libressl-dev fontconfig-dev freetype-dev glib-dev libpng-dev zlib-dev sqlite-dev dbus-dev perl bison cups-dev eudev-dev  flex freetds-dev gawk gperf gtk+2.0-dev hicolor-icon-theme icu-dev libjpeg-turbo-dev libxkbcommon-dev libxi-dev libxrandr-dev libxrender-dev libxslt-dev libxv-dev mariadb-dev pcre-dev postgresql-dev unixodbc-dev xcb-util-dev xcb-util-image-dev xcb-util-keysyms-dev xcb-util-wm-dev 7zip xz speex-dev speexdsp-dev libcap-dev protobuf-dev libsndfile-dev boost-dev avahi-dev`

`wget http://download.qt.io/official_releases/qt/5.6/5.6.1/submodules/qtbase-opensource-src-5.6.1.7z`

`7z x qtbase-opensource-src-5.6.1.7z && mv qtbase-opensource-src-5.6.1.7 qtbase && cd qtbase`

`wget http://git.alpinelinux.org/cgit/aports/plain/main/qt5-qtbase/qt-musl-iconv-no-bom.patch`

`wget http://git.alpinelinux.org/cgit/aports/plain/main/qt5-qtbase/libressl-compat.patch`

`patch -p1 < libressl-compat.patch && patch -p1 < qt-musl-iconv-no-bom.patch`

`./configure -prefix /opt/qt -opensource -confirm-license -static -openssl-linked -nomake examples -no-icu -no-gui -no-widgets -no-cups -no-opengl -no-sql-odbc -no-sql-odbc -no-sql-mysql -no-sql-psql -no-sql-tds -qt-sql-sqlite`

`make -j$CPUN`

`make install`


**4. ZEROC-ICE**

`apk add mcpp-libs mcpp mcpp-dev bzip2 bzip2-libs`

`cd /build`

`git clone -b 3.6 https://github.com/zeroc-ice/ice.git`

`cd ice`

`sed -ri "s/MACHINE_TYPE/STATICLIBS = yes\n\n\0/" config/Make.common.rules`

`sed -ri "s/-Werror/-Wno-error/" cpp/config/Make.rules.Linux`

`sed -ri "s/-lIceUtil/\0 -lbz2 -lmcpp -lcrypto/" cpp/config/Make.rules.Linux`

`sed -ri "s/__GNUC__\)/\0 \&\& defined(__GLIBC__)/" cpp/src/IceUtilException.cpp`

`sed -ri "s/defined\(__linux\) \&\& \!defined\(__USE_UNIX98\)/\0 \&\& defined(PTHREAD_MUTEX_ERRORCHECK_NP)/" cpp/src/IceUtil/RecMutex.cpp`

`sed -ri "s/defined\(__linux\) \&\& \!defined\(__USE_UNIX98\)/\0 \&\& defined(PTHREAD_MUTEX_ERRORCHECK_NP)/" cpp/include/IceUtil/Mutex.h`

`mv test test.off`

`make -j$CPUN`

`make install`

**5. GLIB**

`cd /build`

`wget https://ftp.gnome.org/pub/gnome/sources/glib/2.50/glib-2.50.3.tar.xz`

`xz -d glib-2.50.3.tar.xz && cd glib-2.50.3`

`./autogen.sh && ./configure --enable-static --prefix=/opt/glib`

`make -j$CPUN && make install`

**6. DBUS**

`cd /build`

`wget https://dbus.freedesktop.org/releases/dbus/dbus-1.10.16.tar.gz`

`tar xf dbus-1.10.16.tar.gz && cd dbus-1.10.16`

`./autogen.sh && ./configure --enable-static --prefix=/opt/dbus`

`make -j$CPUN && make install`


**7. MUMBLE**

`cd /build`

`git clone https://github.com/mumble-voip/mumble.git`

`cd mumble`

`sed -ri "s%qFatal\(\"SSL%//\0%g" src/SSL.cpp`

`sed -ri "s%qCritical\(\"Found%//\0%g" src/SSL.cpp`

`sed -ri "s%ok = false;%//\0%g" src/SSL.cpp`

`sed -ri "s%opt/Ice-3.3%opt/3.6.3%g" src/murmur/murmur.pro`

`sed -ri "s%opt/Ice-3.3%opt/3.6.3%g" src/murmur/murmur_ice/murmur_ice.pro`

`/opt/qt/bin/qmake -recursive main.pro QMAKE_LFLAGS+="-L/opt/dbus/lib -L/opt/glib/lib" CONFIG+="static no-bonjour no-client"`

`make -j$CPUN release`
