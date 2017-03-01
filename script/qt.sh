#!/bin/bash

cd /build

wget http://download.qt.io/official_releases/qt/5.6/5.6.1/submodules/qtbase-opensource-src-5.6.1.7z

7z x qtbase-opensource-src-5.6.1.7z && mv qtbase-opensource-src-5.6.1.7 qtbase && cd qtbase

wget https://raw.githubusercontent.com/lexesv/static-murmurd/master/files/qt-musl-iconv-no-bom.patch

wget https://raw.githubusercontent.com/lexesv/static-murmurd/master/files/libressl-compat.patch

patch -p1 < libressl-compat.patch && patch -p1 < qt-musl-iconv-no-bom.patch

./configure -prefix /opt/qt -opensource -confirm-license -static -openssl-linked -nomake examples -no-icu -no-gui -no-widgets -no-cups -no-opengl -no-sql-odbc -no-sql-odbc -no-sql-mysql -no-sql-psql -no-sql-tds -qt-sql-sqlite

make -j4

make install
