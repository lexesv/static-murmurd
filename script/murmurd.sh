#!/bin/bash

cd /build

git clone https://github.com/mumble-voip/mumble.git

cd mumble

sed -ri "s%qFatal\(\"SSL%//\0%g" src/SSL.cpp

sed -ri "s%qCritical\(\"Found%//\0%g" src/SSL.cpp

sed -ri "s%ok = false;%//\0%g" src/SSL.cpp

sed -ri "s%opt/Ice-3.3%opt/3.6.3%g" src/murmur/murmur.pro

sed -ri "s%opt/Ice-3.3%opt/3.6.3%g" src/murmur/murmur_ice/murmur_ice.pro

#/opt/dbus/lib needed because I was not able to build a QT without it.
#And when compiling Murmur, the QT need this library :-).

/opt/qt/bin/qmake -recursive main.pro QMAKE_LFLAGS+="-L/opt/dbus/lib -L/opt/glib/lib" CONFIG+="static no-bonjour no-dbus no-client"

make -j4 release

