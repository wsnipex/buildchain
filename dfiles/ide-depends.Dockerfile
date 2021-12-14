FROM @UNAME@/kodi-build:@BASETAG@
RUN apt update && apt -y install \
# dependencies of codium
    gnupg \
    libgtk-3-0 \
    libsecret-1-0 \
    libxss1 \
# other useful stuff for debugging
    sqlite3 && \
    rm -rf /var/lib/apt/lists/*
