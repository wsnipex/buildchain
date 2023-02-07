FROM ubuntu:22.04
ARG USERNAME=jenkins
ARG USERID=1005

RUN apt update && apt -y install \
        autoconf \
        build-essential \
        clang \
        clang-format \
        curl \
        default-jdk \
        gawk \
        gdb \
        git \
        gperf \
        libcurl4-openssl-dev \
        lld \
        python3 \
        bash-completion \
        bsdmainutils \
        ccache \
        locales \
        procps \
        sudo \
        unzip \
        vim-tiny \
        wget \
        zip
RUN useradd -u ${USERID} -ms /bin/bash -G sudo ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL:ALL) NOPASSWD: ALL" >/etc/sudoers.d/${USERNAME} && \
    echo "PS1='\[\033[36m\]\u\[\033[m\]@\[\033[31m\]\h\[\033[m\]:\[\033[33;1m\]\w \[\033[31m\]#\[\033[m\] '" >>/home/${USERNAME}/.bashrc && \
    echo "alias ll='ls -la'" >> /etc/profile && \
    echo "alias la='ls -A'" >> /etc/profile && \
    echo "alias l='ls -CF'" >> /etc/profile && \
    echo "PS1='\[\033[36m\]\u\[\033[m\]@\[\033[31m\]\h\[\033[m\]:\[\033[33;1m\]\w\[\033[m\] \$ '" >>/home/${USERNAME}/.bashrc && \
    rm -rf /usr/share/man/??  /var/lib/apt/lists/*
