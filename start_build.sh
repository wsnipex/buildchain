#!/bin/bash
. ./variables.sh

IMAGE=kodi-build

docker run -it --rm \
    --name build \
    --env TZ=${CONTTZ} \
    --env LC_ALL=${CONTLCALL} \
    --user ${UNAME} \
    --workdir /home/${UNAME} \
    --hostname kodi-build \
    --volume ${KODIREPO}:/home/${UNAME}/kodi \
    --volume KODITMP:/home/${UNAME}/.tmp \
    --volume KODICACHE:/home/${UNAME}/.cache \
    --volume ${PERSISTENT_CD}/${IMAGE}/scripts:/home/${UNAME}/scripts \
    --volume ${SSHKEYS}:/home/${UNAME}/.ssh \
    ${UNAME}/${IMAGE}:${BASETAG} /bin/bash
