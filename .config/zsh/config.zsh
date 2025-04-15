#!/bin/sh

# History config
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

# Bindkeys mode, load bindkeys, then overwrite
bindkey -e # Load emacs bindkeys by default
if [[ "$VI_MODE" -eq 1 ]]; then
    bindkey -v
fi

bindkey '^P' history-search-backward  
bindkey '^N' history-search-forward  
bindkey '<Down>' history-search-backward
bindkey '<Up>' history-search-forward

# Completion config
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' #ls 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu-no #list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# don't nice background tasks
setopt NO_BG_NICE
setopt NO_HUP
setopt NO_BEEP
#allow functions to have local options
setopt LOCAL_OPTIONS
# allow functions to have local traps
setopt LOCAL_TRAPS


# edit command line in $EDITOR
autoload -z edit-command-line && zle -N edit-command-line && bindkey '^e' edit-command-line

bindkey '^O' autosuggest-accept
bindkey '^H' backward-delete-word # ctrl+backspace

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;6D" beginning-of-line
bindkey "^[[1;6C" end-of-line

# ESC ESC to add sudo at the beggining of the line
add_sudo_prefix() {
    LBUFFER="sudo $LBUFFER"
    zle reset-prompt
}
zle -N add_sudo_prefix && bindkey '^[^[' add_sudo_prefix

autoload -Uz add-zsh-hook

function clean_empty_input() {
  local lines=("${(f)BUFFER}")

  # Delete lines if empty
  if (( ${#lines[@]} > 1 )); then
    local all_empty=true
    for line in $lines; do
      [[ -n "${line//[[:space:]]/}" ]] && all_empty=false
    done
    if $all_empty; then
      BUFFER=""
      zle reset-prompt
      return 0
    fi
  fi

  # Only a line -> Normal behavior
  zle .accept-line
}

zle -N accept-line clean_empty_input


# VIM MODE

# Change cursor depending on the vim mode
function zle-keymap-select {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q' ;;  # Block (█) in normal mode
        viins|main) echo -ne '\e[5 q' ;;  # Bar (|) in insert mode
    esac
}

# Executed when new zsh line 
function zle-line-init {
    # zle vi-cmd-mode # Init in normal mode
    echo -ne '\e[5 q'  # Init in insert mode with bar
}

if [[ "$VI_MODE" -eq 1 ]]; then
    zle -N zle-keymap-select
    zle -N zle-line-init
    bindkey '^?' backward-delete-char
    bindkey -M vicmd '^M' accept-line
    bindkey -M viins '^M' accept-line
fi
