#!/bin/bash

### Add repositories to file /etc/apk/repositories
# http://mirror.leaseweb.com/alpine/v3.5/main
# http://mirror.leaseweb.com/alpine/v3.5/community
# http://mirror.leaseweb.com/alpine/edge/main
# http://mirror.leaseweb.com/alpine/edge/community
# http://mirror.leaseweb.com/alpine/edge/testing

apk update && apk upgrade

CPUN=`cat /proc/cpuinfo | grep processor | wc -l`

mkdir /build

./qt.sh

./ice.sh
