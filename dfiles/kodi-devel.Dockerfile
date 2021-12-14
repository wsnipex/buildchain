FROM @UNAME@/ide-depends:@BASETAG@
RUN wget @IDEDEB@ -qO /ide.deb && \
    apt update && apt -y install /ide.deb && \
    rm -f /ide.deb && \
    rm -rf /var/lib/apt/lists/* && \
    sudo -u @UNAME@ mkdir \
        /home/@UNAME@/workspaces \
        /home/@UNAME@/.config \
        /home/@UNAME@/.kodi \
        /home/@UNAME@/@IDECONFDIR@
