source "${XDG_CONFIG_HOME}/sh/profile"

if exists anyenv; then
    eval "$(anyenv init -)" # todo if exits
    export PATH="$GOPATH/bin:$PATH"
fi
