#!/bin/sh

sudo pacman -Syu --noconfirm

#Install yay if it is not installed yet
pacman -Q yay &> /dev/null

if [[ ! $? == 0 ]]; then
  pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si;
else echo "==> Yay instaled"; fi

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

git clone https://github.com/CLozano03/dotfiles "$dirname_install" -q 

cp -v "$dirname_install"/.zshrc $HOME/.zshrc
cp -v -r "$dirname_install"/.config/zsh/* "$zsh_config_dir"
echo "==> \tDeleting aux directory for instalation" && sleep 0.5 && rm -rf "$dirname_install" 
echo "==> \tZsh configuration ready for use. Close your terminal and reopen it for installing all the plugins"

exit 0
