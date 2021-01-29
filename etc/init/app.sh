#!/bin/sh

set -eux

go get github.com/x-motemen/ghq

# gibo
ghq get simonwhitaker/gibo
ln -s $(ghq root)/github.com/simonwhitaker/gibo/gibo $HOME/bin/gibo
