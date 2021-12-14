FROM @UNAME@/builders:@BASETAG@
RUN apt update && apt -y install \
        autoconf \
        autopoint \
        ccache \
        cmake \
        curl \
        libasound2-dev \
        libass-dev \
        libcrossguid-dev \
        libcurl4-openssl-dev \
        libdbus-1-dev \
        libdrm-dev \
        libegl1-mesa-dev \
        libegl-dev \
        libfstrcmp-dev \
        libgif-dev \
        libglu1-mesa-dev \
        libiso9660-dev \
        libiso9660++-dev \
        libjpeg-dev \
        liblzo2-dev \
        libmariadb-dev \
        libmicrohttpd-dev \
        libpulse-dev \
        libpython2.7-dev \
        libpython3-dev \
        libsqlite3-dev \
        libssl-dev \
        libtag1-dev \
        libtinyxml-dev \
        libtool-bin \
        libudev-dev \
        libunistring-dev \
        libva-dev \
        libx11-dev \
        libxext-dev \
        libxml2-dev \
        libxrandr-dev \
        libxslt-dev \
        meson \
        nasm \
        pkg-config \
        rapidjson-dev \
        swig && \
    mkdir /mold && wget @MOLD@ -qO - | \
          tar --strip-components=1 --directory=/mold -xz && \
    make --directory=/mold && \
    make --directory=/mold install && \
    rm -rf /mold /var/lib/apt/lists/* && \
    sudo -u @UNAME@ mkdir \
        /home/@UNAME@/.cache \
        /home/@UNAME@/.tmp
