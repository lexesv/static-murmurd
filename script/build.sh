#!/bin/bash

### Add repositories to file /etc/apk/repositories
# http://mirror.leaseweb.com/alpine/v3.5/main
# http://mirror.leaseweb.com/alpine/v3.5/community
# http://mirror.leaseweb.com/alpine/edge/main
# http://mirror.leaseweb.com/alpine/edge/community
# http://mirror.leaseweb.com/alpine/edge/testing

#CPUN=`cat /proc/cpuinfo | grep processor | wc -l`

apk update && apk upgrade

apk add build-base autoconf make grep mc sed git libzip-dev libxml2-dev libxml2-utils zlib-dev bzip2-dev mcpp-libs mcpp mcpp-dev bzip2 lbzip2 \
mesa-dev libice-dev libsm-dev libx11-dev libxext-dev libressl-dev fontconfig-dev freetype-dev glib-dev libpng-dev zlib-dev sqlite-dev \
dbus-dev perl bison cups-dev eudev-dev flex freetds-dev gawk gperf gtk+2.0-dev hicolor-icon-theme icu-dev libjpeg-turbo-dev libxkbcommon-dev \
libxi-dev libxrandr-dev libxrender-dev libxslt-dev libxv-dev mariadb-dev pcre-dev postgresql-dev unixodbc-dev xcb-util-dev xcb-util-image-dev \
xcb-util-keysyms-dev xcb-util-wm-dev tar 7zip xz speex-dev speexdsp-dev libcap-dev protobuf-dev libsndfile-dev boost-dev avahi-dev

mkdir /build

./qt.sh

./ice.sh

./glib.sh

./dbus.sh

./murmurd.sh
