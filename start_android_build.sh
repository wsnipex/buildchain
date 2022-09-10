#!/bin/bash
. ./variables.sh

IMAGE=android-build

docker run -it --rm \
    --name android-build \
    --env TZ=${CONTTZ} \
    --env LC_ALL=${CONTLCALL} \
    --user ${UNAME} \
    --workdir /home/${UNAME} \
    --hostname android-build \
    --volume KODITMP:/home/${UNAME}/.tmp \
    --volume KODICACHE:/home/${UNAME}/.cache \
    --volume ${KODIREPO}:/home/${UNAME}/kodi \
    --volume ${SSHKEYS}:/home/${UNAME}/.ssh \
    --volume ${PERSISTENT_CD}/${IMAGE}/scripts:/home/${UNAME}/scripts \
    ${UNAME}/${IMAGE}:${BASETAG} /bin/bash
