FROM @UNAME@/kodi-build:@BASETAG@
RUN wget @IDEDEB@ -qO /ide.deb && \
    apt update && apt -y install /ide.deb \
                                 sqlite3 && \
    rm -rf /ide.deb /var/lib/apt/lists/* && \
    sudo -u @UNAME@ mkdir \
        /home/@UNAME@/workspaces \
        /home/@UNAME@/.config \
        /home/@UNAME@/.kodi \
        /home/@UNAME@/@IDECONFDIR@
