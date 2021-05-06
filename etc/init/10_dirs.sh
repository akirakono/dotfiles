#!/usr/bin/env bash

set -eux

source $(dirname $(readlink -f "$0"))/../../.env


mkdir -p "$XDG_DATA_HOME"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CACHE_HOME"
mkdir -p "$HOME/src"
mkdir -p "$HOME/bin"
mkdir -p "$XDG_DATA_HOME"/bash
mkdir -p "$XDG_DATA_HOME"/zsh
mkdir -p "$XDG_CACHE_HOME"/zsh
mkdir -p "$XDG_CACHE_HOME"/vim
