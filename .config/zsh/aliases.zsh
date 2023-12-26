#!/bin/zsh
# Path: ~/.config/zsh/aliases.zsh


alias grep='grep --color=auto'
alias ls="lsd"
alias pdw="pwd"
alias cat='bat --style=plain --color=always'
alias catn="command cat"
alias clear="clear; neofetch"
alias c="clear"

alias v="nvim"

alias scilab="scilab &"

alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"

# Visor de pdf evince con open
open() { evince "$@" > /dev/null 2>&1 & disown; }
# Visor de imagenes con view
view() { geeqie "$@" > /dev/null 2>&1 & disown; }