#!/bin/sh

sudo pacman -Syu --noconfirm 

sudo pacman -S yay figlet --noconfirm
clear 
figlet zsh install

#Installing all stuff
sudo pacman -S yay zsh zoxide fzf fastfetch --noconfirm
yay -S oh-my-posh --noconfirm

chsh -s $(which zsh) # Change default SHELL to zsh

zsh_config_dir="~/.config/zsh"

if [[ ! -d "$zsh_config_dir" ]]; then
  mkdir -v -p "$zsh_config_dir"
fi

dirname_install="/tmp/dotfiles_install"

git clone https://github.com/CLozano03/dotfiles "$dirname_install"

cp -v "$dirname_install"/.zshrc ~/.zshrc
cp -v -r "$dirname_install"/.config/zsh/* "$zsh_config_dir"
rm -v -rf "$dirname_install"
