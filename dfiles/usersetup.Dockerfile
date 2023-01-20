FROM @BASEIMG@:@BASETAG@
RUN apt update && apt -y install \
        bash-completion \
        bsdmainutils \
        locales \
        procps \
        pulseaudio-utils \
        sudo \
        unzip \
        vim-tiny \
        wget \
        zip && \
    useradd -ms /bin/bash @UNAME@ && \
    usermod -aG cdrom,floppy,sudo,audio,dip,video,plugdev @UNAME@ && \
    echo "@UNAME@ ALL=(ALL:ALL) NOPASSWD: ALL" \
         >/etc/sudoers.d/@UNAME@ && \
    echo "PS1='\[\033[36m\]\u\[\033[m\]@\[\033[31m\]\h\[\033[m\]:\[\033[33;1m\]\w \[\033[31m\]#\[\033[m\] '" \
          >>/root/.bashrc && \
    echo "alias ll='ls -la'" >> /root/.bashrc && \
    echo "alias la='ls -A'" >> /root/.bashrc && \
    echo "alias l='ls -CF'" >> /root/.bashrc && \
    echo "PS1='\[\033[36m\]\u\[\033[m\]@\[\033[31m\]\h\[\033[m\]:\[\033[33;1m\]\w\[\033[m\] \$ '" \
         >>/home/@UNAME@/.bashrc && \
    echo "alias ll='ls -la'" >> /home/@UNAME@/.bashrc && \
    echo "alias la='ls -A'" >> /home/@UNAME@/.bashrc && \
    echo "alias l='ls -CF'" >> /home/@UNAME@/.bashrc && \
    sed -i "s|; default-server =|default-server = unix:/home/@UNAME@/.pulsesocket/native|" /etc/pulse/client.conf && \
    sed -i "s|; autospawn = yes|autospawn = no|" /etc/pulse/client.conf && \
    sed -i "s|; daemon-binary = /usr/bin/pulseaudio|daemon-binary = /bin/true|" /etc/pulse/client.conf && \
    sed -i "s|; enable-shm = yes|enable-shm = false|" /etc/pulse/client.conf && \
    rm -rf /usr/share/man/?? /usr/share/man/??_* /var/lib/apt/lists/*
