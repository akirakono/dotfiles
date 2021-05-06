limit coredumpsize 0
bindkey -e

setopt auto_cd
setopt no_beep
setopt interactive_comments

# History
export HISTFILE=${XDG_DATA_HOME}/zsh/history
export HISTSIZE=1000
export SAVEHIST=100000


setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_no_store        # no 'history' command itslef
setopt hist_reduce_blanks
setopt hist_ignore_space

setopt hist_verify

# Prompt
if [ -z "${SSH_CONNECTION}" ]; then
    export PROMPT="%F{cyan}%n@%m:%f%F{003}%~
%f%F{magenta}%#%f "
else
    export PROMPT="%F{red}%n@%m:%f%F{003}%~
%f%F{magenta}%#%f "
fi


## show git branch name at $RPROMPT
function git_branch_name {
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo "[git:$(git rev-parse --abrev-ref HEAD 2> /dev/null)]"
    fi
}
function set_rprompt {
    export RPROMPT="%F{green}`git_branch_name`%f"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd set_rprompt

# Completions
autoload -Uz compinit
compinit -d ${XDG_CACHE_HOME}/zsh/zcompdump
setopt complete_in_word
setopt magic_equal_subst
setopt print_eight_bit

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "${XDG_CACHE_HOME}/zsh/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true


if [ -x "`which fzf 2>/dev/null`" ]; then
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --bind=ctrl-k:kill-line'
    alias -g F="| fzf"

    function fzf-cdr() {
        local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | fzf --no-sort --prompt="cdr >" --query "$LBUFFER")"
	if [ -n "$selected_dir" ]; then
	    BUFFER="cd $selected_dir"
	    zle accept-line
	fi
    }
    zle -N fzf-cdr
    bindkey '^x' fzf-cdr


    function fzf-select-history() {
        BUFFER="$(history -nr 1 | awk '!a[$0]++' | fzf --no-sort --query "$LBUFFER" | sed 's/\\n/\n/')"
	CURSOR=$#Buffer            # move the cursort to the end of line
	zle -R -c                  # refresh
    }
    zle -N fzf-select-history
    bindkey '^R' fzf-select-history

    function cdg() {
        local selected_dir=$(ghq list -p | fzf --query "$*")
	if [ -d "$selected_dir" ]; then
	    print -z cd "$selected_dir"
	fi
    }
fi

function execute_immediate() {
    local result
    zsh -c "${BUFFER}" | while read line; do
        result="${result} ${line}"
    done
    BUFFER=${result}
}
zle -N execute_immediate
bindkey '^j' execute_immediate

source "${XDG_CONFIG_HOME}/sh/alias"
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
