#!/bin/bash
. ./variables.sh

IMAGE=android-build

docker run -it --rm \
    --name android-build \
    --env TZ=${CONTTZ} \
    --user ${UNAME} \
    --workdir /home/${UNAME} \
    --hostname android-build \
    --volume XBMCTMP:/home/${UNAME}/.tmp \
    --volume XBMCCACHE:/home/${UNAME}/.cache \
    --volume ${XBMCREPO}:/home/${UNAME}/xbmc \
    --volume ${SSHKEYS}:/home/${UNAME}/.ssh \
    --volume ${PERSISTENT_CD}/${IMAGE}/scripts:/home/${UNAME}/scripts \
    ${UNAME}/${IMAGE}:${BASETAG} /bin/bash
