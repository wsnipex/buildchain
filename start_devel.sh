#!/bin/bash
. ./variables.sh

IMAGE=kodi-devel

case "${IDE}" in
"codium") IDECONFDIR=.vscode-oss;;
"vscode") IDECONFDIR=.vscode;;
*) echo "something wrong!" && exit 1;;
esac

docker run -it --rm \
    --name devel \
    --env TZ=${CONTTZ} \
    --env LC_ALL=${CONTLCALL} \
    --user ${UNAME} \
    --workdir /home/${UNAME} \
    --privileged \
    --device /dev/cdrom \
    --hostname kodi-devel \
    --env DISPLAY=$DISPLAY \
    --shm-size=2gb \
    --publish 8080:8080 \
    --publish 9090:9090 \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --volume /run/user/${UID}/pulse:/home/${UNAME}/.pulsesocket \
    --volume ${SSHKEYS}:/home/${UNAME}/.ssh \
    --volume ${KODIREPO}:/home/${UNAME}/kodi \
    --volume ${PERSISTENT_CD}/${IMAGE}/scripts:/home/${UNAME}/scripts \
    --volume ${PERSISTENT_CD}/${IMAGE}/${IDECONFDIR}:/home/${UNAME}/${IDECONFDIR} \
    --volume ${PERSISTENT_CD}/${IMAGE}/workspaces:/home/${UNAME}/workspaces \
    --volume KODI-TMP-CONFIG:/home/${UNAME}/.config \
    --volume KODI-TMP-KODI:/home/${UNAME}/.kodi \
    --volume KODICACHE:/home/${UNAME}/.cache \
    --volume KODITMP:/home/${UNAME}/.tmp \
    ${UNAME}/${IMAGE}:${IDE}-latest /bin/bash
