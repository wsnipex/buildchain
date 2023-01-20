#!/bin/bash

which curl &> /dev/null || { echo "please install curl first!"; exit 1; }

. ./variables.sh

USERSETUP_IMAGE () {
sed -e "s|@UNAME@|${UNAME}|" \
    -e "s|@BASEIMG@|${BASEIMG}|" \
    -e "s|@BASETAG@|${BASETAG}|" \
    ./dfiles/usersetup.Dockerfile | \
docker build --tag ${UNAME}/${BASEIMG}:${BASETAG} -
}

BUILDERS_IMAGE () {
sed -e "s|@UNAME@|${UNAME}|" \
    -e "s|@BASEIMG@|${BASEIMG}|" \
    -e "s|@BASETAG@|${BASETAG}|" \
    ./dfiles/builders.Dockerfile | \
docker build --tag ${UNAME}/builders:${BASETAG} -
}

LE_BUILD_IMAGE () {
[ -d ${PERSISTENT_CD}/le-build ] || mkdir -p ${PERSISTENT_CD}/le-build/scripts

sed -e "s|@UNAME@|${UNAME}|" \
    -e "s|@BASETAG@|${BASETAG}|" \
    ./dfiles/le-build.Dockerfile | \
docker build --tag ${UNAME}/le-build:${BASETAG} -
}

ANDROID_BUILD_IMAGE () {
[ -d ${PERSISTENT_CD}/android-build ] || mkdir -p ${PERSISTENT_CD}/android-build/scripts

sed -e "s|@UNAME@|${UNAME}|g" \
    -e "s|@BASETAG@|${BASETAG}|" \
    -e "s|@SDKZIP@|${SDKZIP}|" \
    -e "s|@SDKINSTALL@|${SDKINSTALL}|" \
    ./dfiles/android-build.Dockerfile | \
docker build --tag ${UNAME}/android-build:${BASETAG} -
}

KODI_BUILD_IMAGE () {
[ -d ${PERSISTENT_CD}/kodi-build ] || mkdir -p ${PERSISTENT_CD}/kodi-build/scripts

MOLD=$( curl -s https://api.github.com/repos/rui314/mold/releases/latest | \
        grep tarball_url | \
        cut -d '"' -f 4 )

sed -e "s|@UNAME@|${UNAME}|" \
    -e "s|@BASETAG@|${BASETAG}|" \
    -e "s|@MOLD@|${MOLD}|" \
    ./dfiles/kodi-build.Dockerfile | \
docker build --tag ${UNAME}/kodi-build:${BASETAG} -
}

DEVEL_DIRECTORIES () {
[ -d ${PERSISTENT_CD}/kodi-devel ] || mkdir -p ${PERSISTENT_CD}/kodi-devel/scripts \
                                               ${PERSISTENT_CD}/kodi-devel/workspaces \
                                               ${PERSISTENT_CD}/kodi-devel/.kodi
}

CODIUM_IMAGE () {
DEVEL_DIRECTORIES
[ -d ${PERSISTENT_CD}/kodi-devel/.vscode-oss ] || mkdir -p ${PERSISTENT_CD}/kodi-devel/.vscode-oss

CODIUMDEB=$( curl -s https://api.github.com/repos/VSCodium/vscodium/releases/latest | \
             grep browser_download_url | \
             cut -d '"' -f 4 | \
             grep 'amd64.deb' | \
             grep -vE 'amd64.deb.sha1|amd64.deb.sha256' )

sed -e "s|@IDEDEB@|${CODIUMDEB}|" \
    -e "s|@UNAME@|${UNAME}|" \
    -e "s|@BASETAG@|${BASETAG}|" \
    -e "s|@IDECONFDIR@|.vscode-oss|" \
    ./dfiles/kodi-devel.Dockerfile | \
docker build --tag ${UNAME}/kodi-devel:${BASETAG}-codium-latest -
}

VSCODE_IMAGE () {
DEVEL_DIRECTORIES
[ -d ${PERSISTENT_CD}/kodi-devel/.vscode ] || mkdir -p ${PERSISTENT_CD}/kodi-devel/.vscode

VSCODELOCATION=https://packages.microsoft.com/repos/code/pool/main/c/code/
VSCODEPACKAGE=$( curl -s $VSCODELOCATION | \
                 grep amd64.deb | \
                 cut -d'"' -f 2 | \
                 sort | \
                 tail -n1 )

VSCODEDEB=${VSCODELOCATION}${VSCODEPACKAGE}

sed -e "s|@IDEDEB@|${VSCODEDEB}|" \
    -e "s|@UNAME@|${UNAME}|" \
    -e "s|@BASETAG@|${BASETAG}|" \
    -e "s|@IDECONFDIR@|.vscode|" \
    ./dfiles/kodi-devel.Dockerfile | \
docker build --tag ${UNAME}/kodi-devel:${BASETAG}-vscode-latest -
}

USERSETUP_IMAGE
BUILDERS_IMAGE
LE_BUILD_IMAGE
ANDROID_BUILD_IMAGE
KODI_BUILD_IMAGE

case "${IDE}" in
"codium") CODIUM_IMAGE;;
"vscode") VSCODE_IMAGE;;
*) echo "something wrong!" && exit 1;;
esac
