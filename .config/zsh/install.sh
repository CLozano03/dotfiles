#!/bin/sh

figlet zsh install

#sudo pacman -Syu --nocomfirm

sudo pacman -S zsh --noconfirm
chsh -s $(which zsh) #Change default SHELL to zsh

yay -S oh-my-posh --noconfirm

zsh_config_dir="~/.config/zsh"

if [[ -z "$zsh_config_dir" ]]; then
  mkdir -p "$zsh_config_dir"
fi

dirname_install="dotfiles_install"

git clone https://github.com/CLozano03/dotfiles "$dirname_install"

cp "$dirname_install"/.zshrc ~/.zshrc
cp "$dirname_install"/.config/zsh/* "$zsh_config_dir"
rm -rf "$dirname_install"
