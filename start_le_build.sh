#!/bin/bash
. ./variables.sh

IMAGE=le-build

docker run -it --rm \
    --name le-build \
    --env TZ=${CONTTZ} \
    --user ${UNAME} \
    --workdir /home/${UNAME} \
    --hostname libreelec-build \
    --volume ${LEREPO}:/home/${UNAME}/LE \
    --volume ${XBMCREPO}:/home/${UNAME}/XBMC \
    --volume ${SSHKEYS}:/home/${UNAME}/.ssh \
    --volume ${PERSISTENT_CD}/${IMAGE}/scripts:/home/${UNAME}/scripts \
    ${UNAME}/${IMAGE}:${BASETAG} /bin/bash
