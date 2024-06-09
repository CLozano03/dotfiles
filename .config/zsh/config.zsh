#!/bin/sh

# ########## History config ##########
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt append_history
setopt hist_ignore_space  # ignore commands that start with a space
setopt hist_find_no_dups  # do not display duplicates in history search

bindkey '^n' history-search-forward
bindkey '^p' history-search-backward

# ########## Completion config ##########
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' #ls 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu-no #list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'


# don't nice background tasks
setopt NO_BG_NICE
setopt NO_HUP
setopt NO_BEEP
# allow functions to have local options
setopt LOCAL_OPTIONS
# allow functions to have local traps
setopt LOCAL_TRAPS


# fuzzy find: start to type
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search
bindkey "$terminfo[cuu1]" up-line-or-beginning-search
bindkey "$terminfo[cud1]" down-line-or-beginning-search

# backward and forward word with option+left/right
bindkey '^[^[[D' backward-word
bindkey '^[b' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[f' forward-word

# to to the beggining/end of line with fn+left/right or home/end
bindkey "${terminfo[khome]}" beginning-of-line
bindkey '^[[H' beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey '^[[F' end-of-line

# delete char with backspaces and delete
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char

#bindkey '^L' forward-char


# delete word with ctrl+alt+backspace
bindkey '^[[3;5~' backward-kill-line
#bindkey '^[[3-'

bindkey '^H' backward-delete-word # ctrl+backspace
bindkey '^W' backward-kill-word # ctrl+alt+backspace


# edit command line in $EDITOR
bindkey '^e' edit-command-line

add_sudo_prefix() {
    LBUFFER="sudo $LBUFFER"
    zle reset-prompt
}
# Asocia la función al atajo de teclado Ctrl+k
zle -N add_sudo_prefix && bindkey '^K' add_sudo_prefix

# Mute bell sounds
xset -b


# Configuration for history search 
if test -d /usr/local/opt/fzf/shell; then
    # shellcheck disable=SC1091
 
    . /usr/local/opt/fzf/shell/key-bindings.zsh
else
    bindkey '^R' history-incremental-search-backward
fi
