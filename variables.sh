# choose you base image
BASEIMG=debian
BASETAG=bullseye

# dont change these
UNAME=$( whoami )
CONTTZ=$( cat /etc/timezone )

# choose your default ide (codium or vscode)
IDE=codium

# mold linker tag to build
MOLD=https://github.com/rui314/mold/tarball/v1.1

# set this directory where you cloned LibreElec repo to
LEREPO=~/repos/le

# set that dir to where you cloned kodi
KODIREPO=~/repos/kodi

# set this to the dir where your ssh keypairs live, to smoothly push to github
SSHKEYS=~/.ssh

# config files, scripts, etc. are stored at a persistent place
PERSISTENT_CD=~/.persistent_containerdata
