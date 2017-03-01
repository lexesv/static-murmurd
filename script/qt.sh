#!/bin/bash

cd /build

apk add mc mesa-dev libice-dev libsm-dev libx11-dev libxext-dev libressl-dev fontconfig-dev freetype-dev glib-dev libpng-dev zlib-dev sqlite-dev dbus-dev perl bison cups-dev eudev-dev  flex freetds-dev gawk gperf gtk+2.0-dev hicolor-icon-theme icu-dev libjpeg-turbo-dev libxkbcommon-dev libxi-dev libxrandr-dev libxrender-dev libxslt-dev libxv-dev mariadb-dev pcre-dev postgresql-dev unixodbc-dev xcb-util-dev xcb-util-image-dev xcb-util-keysyms-dev xcb-util-wm-dev 7zip xz speex-dev speexdsp-dev libcap-dev protobuf-dev libsndfile-dev boost-dev avahi-dev

wget http://download.qt.io/official_releases/qt/5.6/5.6.1/submodules/qtbase-opensource-src-5.6.1.7z

7z x qtbase-opensource-src-5.6.1.7z && mv qtbase-opensource-src-5.6.1.7 qtbase && cd qtbase

wget https://raw.githubusercontent.com/lexesv/static-murmurd/master/files/qt-musl-iconv-no-bom.patch

wget https://raw.githubusercontent.com/lexesv/static-murmurd/master/files/libressl-compat.patch

patch -p1 < libressl-compat.patch && patch -p1 < qt-musl-iconv-no-bom.patch

./configure -prefix /opt/qt -opensource -confirm-license -static -openssl-linked -nomake examples -no-icu -no-gui -no-widgets -no-cups -no-opengl -no-sql-odbc -no-sql-odbc -no-sql-mysql -no-sql-psql -no-sql-tds -qt-sql-sqlite

make -j$CPUN

make install
