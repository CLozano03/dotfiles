#!/bin/sh

# shortcut to this dotfiles path is $DOTFILES
export DOTFILES="$HOME/dotfiles"
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$ZSH/custom
export XDG_CONFIG_HOME=$HOME/.config
export ZSH_CONFIG=$XDG_CONFIG_HOME/zsh

export PATH="$PATH:/home/cesar/.local/bin"

source ""$ZSH_CONFIG"/config.zsh"

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
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# Loading autocompletion
autoload -Uz compinit && compinit -d ~/.zcompdump

zinit cdreplay -q # To make use of `cd -<TAB>` to navigate to recently visited directories

# =====Aliases=====
if [ -f ""$ZSH_CONFIG"/private_aliases.zsh" ]; then 
  source ""$ZSH_CONFIG"/private_aliases.zsh" # Private aliasees
fi
source ""$ZSH_CONFIG"/aliases.zsh"          # General aliases


unalias zi 2> /dev/null
eval "$(zoxide init zsh)" # zoxide for better cd navigation
eval "$(fzf --zsh)" # fuzzyfinder
eval "$(oh-my-posh init zsh --config $ZSH_CONFIG/ohmyposh/zen.toml)"

# if [ -n "$DBUS_SESSION_BUS_ADDRESS" ]; then
#     dbus-update-activation-environment --all
# fi


# Load fastfetch when zsh
fastfetch

#if [[ -z "$TMUX" ]]; then
#  tmux new-session -A -s main
#fi

# export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
