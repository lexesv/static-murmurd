#!/bin/bash

cd /build

wget https://dbus.freedesktop.org/releases/dbus/dbus-1.10.16.tar.gz

tar xf dbus-1.10.16.tar.gz && cd dbus-1.10.16`

./autogen.sh && ./configure --enable-static --prefix=/opt/dbus

make -j4 && make install
