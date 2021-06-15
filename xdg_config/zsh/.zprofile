source "${XDG_CONFIG_HOME}/sh/profile"

if exists anyenv; then
    eval "$(anyenv init -)"
    export PATH="$GOPATH/bin:$PATH"
fi
