FROM @UNAME@/@BASEIMG@:@BASETAG@
RUN apt update && apt -y install \
        clang \
        clang-format \
        default-jre \
        g++ \
        gdb \
        git \
        lld \
        make \
        python3 && \
    echo "PS1='\[\033[36m\]\u\[\033[m\]@\[\033[31m\]\h\[\033[m\]:\[\033[33;1m\]\w\[\033[0m\]" \
         "(\[\033[0;37m\]\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\[\033[0m\]) \$ '" \
         >>/home/@UNAME@/.bashrc && \
    echo "export PATH=\$PATH:/home/@UNAME@/scripts" \
         >>/home/@UNAME@/.bashrc && \
    rm -rf /var/lib/apt/lists/*
