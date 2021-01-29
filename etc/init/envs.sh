#!/bin/sh

set -eux

mkdir -p "$XDG_DATA_HOME"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CACHE_HOME"
mkdir -p "$HOME/src"
mkdir -p "$HOME/bin"
mkdir -p "$XDG_CACHE_HOME/zsh"

git clone https://github.com/anyenv/anyenv ${XDG_DATA_HOME}/anyenv

${XDG_DATA_HOME}/anyenv/bin/anyenv install --init

anyenv install goenv
anyenv install nodenv

set +x
eval "$(anyenv init -)"

GO_VERSION=$(goenv install -l | egrep -v [a-z] | tail -1) # latest version
goenv install ${GO_VERSION}
goenv global ${GO_VERSION}

NODE_VERSION=$(nodenv install -l | egrep -v [a-z] | tail -1) # latest version
nodenv install ${NODE_VERSION}
nodenv global ${NODE_VERSION}


