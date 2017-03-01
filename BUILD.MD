**1. INSTALL VIRTUALBOX 5**

min 20Gb dinamic VDI

**2. INSTALL ALPINE LINUX**

[https://nl.alpinelinux.org/alpine/v3.5/releases/x86_64/alpine-extended-3.5.1-x86_64.iso]()


**3. QT5**

[CPU-N] - `cat /proc/cpuinfo | grep processor | wc -l`

`mkdir /build && cd /build`

`apk add mc mesa-dev libice-dev libsm-dev libx11-dev libxext-dev libressl-dev fontconfig-dev freetype-dev glib-dev libpng-dev zlib-dev sqlite-dev dbus-dev perl bison cups-dev eudev-dev  flex freetds-dev gawk gperf gtk+2.0-dev hicolor-icon-theme icu-dev libjpeg-turbo-dev libxkbcommon-dev libxi-dev libxrandr-dev libxrender-dev libxslt-dev libxv-dev mariadb-dev pcre-dev postgresql-dev unixodbc-dev xcb-util-dev xcb-util-image-dev xcb-util-keysyms-dev xcb-util-wm-dev 7zip speex-dev speexdsp-dev libcap-dev protobuf-dev libsndfile-dev boost-dev avahi-dev`

`wget http://download.qt.io/official_releases/qt/5.6/5.6.1/submodules/qtbase-opensource-src-5.6.1.7z`

`7z x qtbase-opensource-src-5.6.1.7z && mv qtbase-opensource-src-5.6.1.7 qtbase && cd qtbase`

`wget http://git.alpinelinux.org/cgit/aports/plain/main/qt5-qtbase/qt-musl-iconv-no-bom.patch`

`wget http://git.alpinelinux.org/cgit/aports/plain/main/qt5-qtbase/libressl-compat.patch`

`patch -p1 < libressl-compat.patch && patch -p1 < qt-musl-iconv-no-bom.patch`

`./configure -prefix /opt/qt -opensource -confirm-license -static -openssl-linked -nomake examples -no-icu -no-gui -no-widgets -no-cups -no-opengl -no-sql-odbc -no-sql-odbc -no-sql-mysql -no-sql-psql -no-sql-tds -qt-sql-sqlite`

`make -j[CPU-N]`

`make install`


**4. ZEROC-ICE**

`apk add mcpp-libs mcpp mcpp-dev bzip2 bzip2-libs`

`cd /build`

`git clone -b 3.6 https://github.com/zeroc-ice/ice.git`

`cd ice/config`

In Make.rules or Make.common.rules add **STATICLIBS = yes**

`cd ../cpp/config`

In config/Make.rules.linux replace -Werror  to -Wno-error 

`sed -ri "s/-lIceUtil/\1 -lbz2 -lmcpp -lcrypto/" Make.rules.Linux`

`cd ../include`

Edit IceUtil/Exception.cpp:34:24

`--- #if defined(__GNUC__) && !defined(__sun) && !defined(__FreeBSD__) && !defined(__MINGW32__) && \`

`+++ #if defined(__GNUC__) && defined(__GLIBC__) && !defined(__sun) && !defined(__FreeBSD__) && !defined(__MINGW32__) && \`

In IceUtil/RecMutex.cpp & IceUtil/Mutex.h add **&& defined(PTHREAD_MUTEX_ERRORCHECK_NP)** 

`cd /build/ice && mv test test.off`

`make -j[CPU-N]`

`make install`

**5. GLIB**

**6. DBUS**


**7. MUMBLE**

`cd /build`

`git clone https://github.com/mumble-voip/mumble.git`

`cd mumble/src`

Edit file (mc F4) SSL.cpp (function **void MumbleSSL::qsslSanityCheck()**) comment lines: 

//	qFatal("SSL: could not dlopen program binary");

//	qFatal("SSL: unable to acquire link_map: %s", dlerror());

//	qFatal("SSL: link_map is NULL");

//	qFatal("SSL library query failed: %i libcrypto's and %i libssl's found.", libcrypto.size(), libssl.size());

//	qCritical("Found multiple libssl.so copies in binary: %s", qPrintable(libssl.join(QLatin1String(", "))));

//	qCritical("Found multiple libcrypto.so copies in binary: %s", qPrintable(libcrypto.join(QLatin1String(", "))));

//	ok = false;

`cd murmur`

Replace in murmur.pro  path to Ice /opt/Ice-3.3 to /opt/3.6.x

`sed -ri "s%opt/Ice-3.3%opt/3.6.3%g" murmur.pro`

cd `murmur_ice`

Replace in murmur_ice.pro path to Ice /opt/Ice-3.3 to /opt/3.6.x

`sed -ri "s%opt/Ice-3.3%opt/3.6.3%g" murmur_ice.pro`

`/opt/qt/bin/qmake -recursive main.pro QMAKE_LFLAGS+="-L/opt/dbus/lib -L/opt/glib/lib" CONFIG+="static no-bonjour no-dbus no-client"`

`make -j[CPU-N] release`