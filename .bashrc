export HISTFILE=${XDG_DATA_HOME}/bash/history
export HISTSIZE=1000
export HISTFILESIZE=100000
export HISTCONTROL=ignoreboth
shopt -s histappend

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

source "${XDG_CONFIG_HOME}/sh/alias"
