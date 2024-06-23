#!/bin/sh

sudo pacman -Syu --noconfirm

sudo pacman -S figlet --noconfirm
figlet zsh install

#Installing all stuff
sudo pacman -S zsh zoxide fzf fastfetch --noconfirm
yay -S oh-my-posh --noconfirm

chsh -s $(which zsh) # Change default SHELL to zsh

zsh_config_dir="~/.config/zsh"

if [[ -z "$zsh_config_dir" ]]; then
  mkdir -p "$zsh_config_dir"
fi

dirname_install="dotfiles_install"

git clone https://github.com/CLozano03/dotfiles "$dirname_install"

cp "$dirname_install"/.zshrc ~/.zshrc
cp -r "$dirname_install"/.config/zsh/* "$zsh_config_dir"
rm -rf "$dirname_install"
