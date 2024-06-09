#!/bin/sh

# shortcut to this dotfiles path is $DOTFILES
export DOTFILES="$HOME/dotfiles"
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$ZSH/custom
export XDG_CONFIG_HOME=$HOME/.config
export ZSH_CONFIG=$XDG_CONFIG_HOME/zsh

source ""$ZSH_CONFIG"/env.zsh"

# Directory to store zinit configuration
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

autoload -Uz compinit && compinit

zinit cdreplay -q # To make use of `cd -<TAB>` to navigate to recently visited directories

source "$ZSH"/oh-my-zsh.sh
source ""$ZSH_CONFIG"/config.zsh"
source ""$ZSH_CONFIG"/prompt.zsh"

# =====Aliases=====
# Load aliases from the following files
if [ -f ""$ZSH_CONFIG"/private_aliases.zsh" ]; then 
  source ""$ZSH_CONFIG"/private_aliases.zsh" # Private aliasees
fi
source ""$ZSH_CONFIG"/aliases.zsh"          # General aliases
# =====End Aliases=====

# Cargar Fastfetch cuando se abre
fastfetch

eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
eval "$(oh-my-posh init zsh --config $ZSH_CONFIG/ohmyposh/zen.toml)"
# Created by `pipx` on 2024-04-15 13:52:09
export PATH="$PATH:/home/cesar/.local/bin"

if [ -n "$DBUS_SESSION_BUS_ADDRESS" ]; then
    dbus-update-activation-environment --all
fi

