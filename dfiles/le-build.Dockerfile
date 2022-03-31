FROM @UNAME@/builders:@BASETAG@
RUN apt update && apt -y install \
        bc \
        bzip2 \
        file \
        libjson-perl \
        libncurses5-dev \
        libparse-yapp-perl \
        libxml-parser-perl \
        lzop \
        patch \
        patchutils \
        perl \
        xfonts-utils \
        xsltproc \
        xz-utils \
        zstd && \
    rm -rf /var/lib/apt/lists/*
