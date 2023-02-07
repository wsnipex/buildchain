FROM localhost/kodi/jenkins/base:jammy
RUN apt update && apt -y install \
      bison flex \
      gcc-12-arm-linux-gnueabi g++-12-arm-linux-gnueabi linux-libc-dev-armhf-cross \
      gcc-12-aarch64-linux-gnu g++-12-aarch64-linux-gnu linux-libc-dev-arm64-cross \
    && rm -rf /usr/share/man/??  /var/lib/apt/lists/* 

RUN for TOOL in /usr/bin/aarch64-linux-gnu*-12; do ALT=$(echo $TOOL | sed -e 's|/usr/bin/||' -e 's/-12$//g'); update-alternatives --install /usr/bin/$ALT $ALT $TOOL 100; done && \
    for TOOL in /usr/bin/arm-linux-gnueabi-*12; do ALT=$(echo $TOOL | sed -e 's|/usr/bin/||' -e 's/-12$//g'); update-alternatives --install /usr/bin/$ALT $ALT $TOOL 100; done
