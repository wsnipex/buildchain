# choose you base image
BASEIMG=debian
BASETAG=bullseye

# dont change these
UNAME=$( whoami )
CONTTZ=$( cat /etc/timezone )
CONTLCALL=C.UTF-8

# choose your default ide (codium or vscode)
IDE=codium

# android
SDKZIP=https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip
NDKZIP=https://dl.google.com/android/repository/android-ndk-r21e-linux-x86_64.zip
PLATFORMS="platforms;android-28"
BUILDTOOLS="build-tools;28.0.3"

# set this directory where you cloned LibreElec repo to
LEREPO=~/repos/le

# set that dir to where you cloned kodi
KODIREPO=~/repos/kodi

# set this to the dir where your ssh keypairs live, to smoothly push to github
SSHKEYS=~/.ssh

# config files, scripts, etc. are stored at a persistent place
PERSISTENT_CD=~/.persistent_containerdata
