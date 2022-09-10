#!/bin/bash
. ./variables.sh

IMAGE=le-build

docker run -it --rm \
    --name le-build \
    --env TZ=${CONTTZ} \
    --env LC_ALL=${CONTLCALL} \
    --user ${UNAME} \
    --workdir /home/${UNAME} \
    --hostname libreelec-build \
    --volume ${LEREPO}:/home/${UNAME}/libreelec \
    --volume ${KODIREPO}:/home/${UNAME}/kodi \
    --volume ${SSHKEYS}:/home/${UNAME}/.ssh \
    --volume ${PERSISTENT_CD}/${IMAGE}/scripts:/home/${UNAME}/scripts \
    ${UNAME}/${IMAGE}:${BASETAG} /bin/bash
