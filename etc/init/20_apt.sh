#!/usr/bin/env bash

set -eux

PACKAGES="build-essential vim tmux fzf zsh tree"

if ! type apt > /dev/null 2>&1; then
    exit 0
fi

printf "password for sudo: "
read -s password
echo

set +x
echo $password | sudo -S apt update
echo $password | sudo -S apt upgrade -y
echo $password | sudo -S apt install -y ${PACKAGES}
echo $password | sudo -S apt auto-remove -y

set -x

chsh -s /bin/zsh

