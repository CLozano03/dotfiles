#!/bin/zsh
# Path: $XDG_CONFIG_HOME/zsh/aliases.zsh

# Some "misspelings" ~~espero no malacostumbrarme~~
alias pdw="pwd"
alias chomd="chmod" 

# config files edition
alias zshconf=""$EDITOR"  "$HOME"/.zshrc"
alias ohmyzsh=""$EDITOR" "$HOME"/.oh-my-zsh"
alias qtconf="$EDITOR "$XDG_CONFIG_HOME"/qtile/config.py"
alias alaconf=""$EDITOR"  "$XDG_CONFIG_HOME"/alacritty/alacritty.toml"
alias piconf=""$EDITOR"  "$XDG_CONFIG_HOME"/picom/picom.conf"
alias aliasconf=""$EDITOR" "$XDG_CONFIG_HOME"/zsh//aliases.zsh"

# Update zsh configuration
alias zshrc="source ~/.zshrc"

# lsd instead of ls and some aliases
alias ls="lsd"
alias lsn="command ls"
alias lln="command ls -l"
alias lt="lsd --total-size -l" # Show total size of each directory. Takes some time 

# Zoxide instead of cd
alias cd="z"
alias cdi="zi" # Buscar un directorio

alias cat="bat --color=always"
alias catn="command cat"
alias c="clear"
alias v="nvim"
alias em="emacs -nw"
alias echo="echo -e"

# Show NEOFETCH when clearing terminal
alias clear="clear && neofetch"

# Colorize grep output (chachi for log files)
alias grep="grep --color=auto"

# cp, mv, rm with verbose and more sure
alias cp="cp -vi"
alias mv="mv -vi"
alias rm="rm -v --preserve-root"

# Adding flags to some commands
alias mkdir="mkdir -pv"
alias df="df -h"
alias du="du -h"
alias free="free -m"
alias ping="ping -c 3"

# Jump between directories with cd
alias ..="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."

# Show all aliases in less/bat format
alias catalias="alias | bat"

# Update system
alias update="sudo pacman -Syu"
alias updateyay="yay -Syu"

# Pdf evince with 'open'
open() { evince "$@" > /dev/null 2>&1 & disown; }
# geeqie with 'view'
view() { geeqie "$@" > /dev/null 2>&1 & disown; }
# Libreoffice with 'loff'
loff() { libreoffice "$@" > /dev/null 2>&1 & disown; }

# Power off, reboot, etc...
alias pof="shutdown now"
alias rb="reboot"
alias susp="systemctl suspend"

# Generate random passwd
alias genpasswd="echo `env LC_CTYPE=C tr -dc "a-zA-Z0-9-_\$\?" < /dev/urandom | head -c 20`"

# Rickroll 😏
alias rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | sh"

# =========== Git aliases ================
alias ga="git add"
alias gaa="git add --all"

alias gb="git branch --sort=committerdate"

alias gco="git checkout"

alias gc="git commit --verbose"
alias gca="git commit --verbose --amend"
alias gcan="git commit --verbose --no-edit --amend"

alias gd="git diff"
alias gdh="git diff HEAD"
alias gdca="git diff --cached"
alias gds="git diff --staged"

alias grb="git rebase"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias grbi="git rebase --interactive"

alias grst="git restore --staged"

alias gsh="git show"

alias gst="git status"

alias gstl="git stash list"
alias gsta="git stash push"
alias gstp="git stash pop"

alias gsw="git switch"
alias gswc="git switch --create"
# ===========Fin git aliases ================
