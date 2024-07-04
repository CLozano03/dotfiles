#!/bin/sh
#
# # ########## History config ##########
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt append_history
setopt hist_ignore_space  # ignore commands that start with a space
setopt hist_find_no_dups  # do not display duplicates in history search

bindkey -d # Reset all binds 

bindkey '^j' history-search-forward
bindkey '^k' history-search-backward

bindkey '<Up>' history-search-forward
bindkey '<Down>' history-search-backward
#
# # ########## Completion config ##########
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' #ls 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu-no #list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
#
#
# # don't nice background tasks
setopt NO_BG_NICE
setopt NO_HUP
setopt NO_BEEP
#allow functions to have local options
setopt LOCAL_OPTIONS
# allow functions to have local traps
setopt LOCAL_TRAPS
#
#
# # fuzzy find: start to typebindkey
# bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
# bindkey "$terminfo[kcud1]" down-line-or-beginning-search
# bindkey "$terminfo[cuu1]" up-line-or-beginning-search
# bindkey "$terminfo[cud1]" down-line-or-beginning-search
#
# # backward and forward word with option+left/right
bindkey '^[[1;5D' backward-word   # ctrl + left
bindkey '^A' backward-word        # ctrl + a
bindkey '^[[1;5C' forward-word    # ctrl + right
stty -ixon && bindkey '^S' forward-word         # ctrl + s

# # to to the beggining/end of line with fn+left/right or home/end
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# delete char with backspaces and delete
bindkey '^?' backward-delete-char

# # delete word with ctrl+alt+backspace
bindkey '^[^H' backward-kill-line

bindkey '^H' backward-delete-word # ctrl+backspace
# bindkey '^W' backward-kill-word # ctrl+alt+backspace

bindkey '^W' kill-whole-line
bindkey '^o' clear-screen
bindkey '^l' clear-screen

# # edit command line in $EDITOR
autoload -z edit-command-line && zle -N edit-command-line && bindkey '^e' edit-command-line

bindkey '^P' autosuggest-accept

add_sudo_prefix() {
    LBUFFER="sudo $LBUFFER"
    zle reset-prompt
}
# Asocia la función al atajo de teclado Ctrl+k
zle -N add_sudo_prefix && bindkey '^[^[' add_sudo_prefix
