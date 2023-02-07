# choose your base image
BASEIMG=debian
BASETAG=bullseye

# dont change these
UNAME=jenkins
CONTTZ=$( cat /etc/timezone )
CONTLCALL=C.UTF-8

# choose your default ide (codium or vscode)
IDE=codium

# android
#SDKZIP=https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip
SDKZIP=https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
SDKINSTALL='"platforms;android-30" "platforms;android-31" "platforms;android-33" "build-tools;30.0.2" "build-tools;31.0.0" "build-tools;33.0.1" "ndk;21.4.7075529" "ndk;25.1.8937393"'

# set this directory where you cloned LibreElec repo to
LEREPO=~/repos/le

# set that dir to where you cloned kodi
KODIREPO=~/repos/kodi

# set this to the dir where your ssh keypairs live, to smoothly push to github
SSHKEYS=~/.ssh

# config files, scripts, etc. are stored at a persistent place
PERSISTENT_CD=~/.persistent_containerdata
