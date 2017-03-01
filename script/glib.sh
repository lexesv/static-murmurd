#!/bin/bash

cd /build

wget https://ftp.gnome.org/pub/gnome/sources/glib/2.50/glib-2.50.3.tar.xz

xz -d glib-2.50.3.tar.xz && cd glib-2.50.3

./autogen.sh && ./configure --enable-static --prefix=/opt/glib

make -j$CPUN && make install
