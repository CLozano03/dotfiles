#!/bin/sh

sudo pacman -Syu --noconfirm 

sudo pacman -S figlet --noconfirm
clear 
figlet zsh install && sleep 1

#Installing all stuff
sudo pacman -S zsh zoxide fzf fastfetch --noconfirm
yay -S oh-my-posh --noconfirm

# Change default SHELL to zsh
username=$(whoami)
sudo chsh -s $(which zsh) $username 

zsh_config_dir="$HOME/.config/zsh"

if [[ ! -d "$zsh_config_dir" ]]; then
  mkdir -v -p "$zsh_config_dir"
fi

dirname_install="/tmp/dotfiles_install"

git clone https://github.com/CLozano03/dotfiles "$dirname_install"

cp -v "$dirname_install"/.zshrc $HOME/.zshrc
cp -v -r "$dirname_install"/.config/zsh/* "$zsh_config_dir"
rm -v -rf "$dirname_install"
