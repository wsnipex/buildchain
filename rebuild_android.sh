#!/bin/bash

which curl &> /dev/null || { echo "please install curl first!"; exit 1; }

. ./variables.sh

ANDROID_BUILD_IMAGE () {
[ -d ${PERSISTENT_CD}/android-build ] || mkdir -p ${PERSISTENT_CD}/android-build/scripts

sed -e "s|@UNAME@|${UNAME}|g" \
    -e "s|@BASETAG@|${BASETAG}|" \
    -e "s|@SDKZIP@|${SDKZIP}|" \
    -e "s|@SDKINSTALL@|${SDKINSTALL}|" \
    ./dfiles/android-build.Dockerfile | \
docker build --tag ${UNAME}/android-build:omega_alpha --tag ${UNAME}/android-build:latest -
}
ANDROID_BUILD_IMAGE
