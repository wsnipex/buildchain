#!/bin/bash
. ./variables.sh

[ -d ${PERSISTENT_CD}/le-build ]      || mkdir -p ${PERSISTENT_CD}/le-build/scripts
[ -d ${PERSISTENT_CD}/android-build ] || mkdir -p ${PERSISTENT_CD}/android-build/scripts
[ -d ${PERSISTENT_CD}/kodi-build ]    || mkdir -p ${PERSISTENT_CD}/kodi-build/scripts
[ -d ${PERSISTENT_CD}/kodi-devel ]    || mkdir -p ${PERSISTENT_CD}/kodi-devel/scripts \
                                                  ${PERSISTENT_CD}/kodi-devel/workspaces \
                                                  ${PERSISTENT_CD}/kodi-devel/.kodi \
                                                  ${PERSISTENT_CD}/kodi-devel/.vscode-oss \
                                                  ${PERSISTENT_CD}/kodi-devel/.vscode

docker pull ${BASEIMG}:${BASETAG}

sed -e "s|@UNAME@|${UNAME}|" \
    -e "s|@BASEIMG@|${BASEIMG}|" \
    -e "s|@BASETAG@|${BASETAG}|" \
    ./dfiles/usersetup.Dockerfile | \
docker build --tag ${UNAME}/${BASEIMG}:${BASETAG} -

sed -e "s|@UNAME@|${UNAME}|" \
    -e "s|@BASEIMG@|${BASEIMG}|" \
    -e "s|@BASETAG@|${BASETAG}|" \
    ./dfiles/builders.Dockerfile | \
docker build --tag ${UNAME}/builders:${BASETAG} -

sed -e "s|@UNAME@|${UNAME}|" \
    -e "s|@BASETAG@|${BASETAG}|" \
    ./dfiles/le-build.Dockerfile   | \
docker build --tag ${UNAME}/le-build:${BASETAG} -

sed -e "s|@UNAME@|${UNAME}|g" \
    -e "s|@BASETAG@|${BASETAG}|" \
    ./dfiles/android-build.Dockerfile   | \
docker build --tag ${UNAME}/android-build:${BASETAG} -

sed -e "s|@UNAME@|${UNAME}|" \
    -e "s|@BASETAG@|${BASETAG}|" \
    -e "s|@MOLD@|${MOLD}|" \
    ./dfiles/kodi-build.Dockerfile | \
docker build --tag ${UNAME}/kodi-build:${BASETAG} -

sed -e "s|@UNAME@|${UNAME}|" \
    -e "s|@BASETAG@|${BASETAG}|" \
    ./dfiles/ide-depends.Dockerfile | \
docker build --tag ${UNAME}/ide-depends:${BASETAG} -

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
docker build --tag ${UNAME}/kodi-devel:codium-latest -

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
docker build --tag ${UNAME}/kodi-devel:vscode-latest -
