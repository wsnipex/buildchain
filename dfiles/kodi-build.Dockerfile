FROM @UNAME@/builders:@BASETAG@
RUN apt update && apt -y install \
        autopoint \
        ccache \
        cmake \
        libasound2-dev \
        libass-dev \
        libdbus-1-dev \
        libdrm-dev \
        libegl1-mesa-dev \
        libegl-dev \
        libfstrcmp-dev \
        libgbm-dev \
        libgif-dev \
        libglu1-mesa-dev \
        libinput-dev \
        libiso9660-dev \
        libiso9660++-dev \
        libjpeg-dev \
        liblzo2-dev \
        libmariadb-dev \
        libmicrohttpd-dev \
        libpulse-dev \
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
        libxkbcommon-dev \
        libxml2-dev \
        libxrandr-dev \
        libxslt-dev \
        meson \
        nasm \
        pkg-config \
        rapidjson-dev \
        swig && \
    mkdir -p /mold/build && wget @MOLD@ -qO - | \
          tar --strip-components=1 --directory=/mold -xz && \
    cd /mold/build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=c++ /mold && \
    cmake --build . -j $(getconf _NPROCESSORS_ONLN) && \
    cmake --install . && \
    cd / && \
    rm -rf /mold /var/lib/apt/lists/* && \
    sudo -u @UNAME@ mkdir \
        /home/@UNAME@/.cache \
        /home/@UNAME@/.tmp
