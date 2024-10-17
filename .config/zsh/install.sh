#!/bin/sh

sudo pacman -Syu --noconfirm

#Install yay if it is not installed yet
pacman -Q yay &> /dev/null 

if [[ ! $? == 0 ]]; then
  sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si;
else echo "==> Yay instaled"; fi

sudo pacman -S figlet --noconfirm
clear && figlet zsh install && sleep 1

#Installing all stuff
sudo pacman -S zsh zoxide fzf fastfetch lsd bat --noconfirm
yay -S oh-my-posh --noconfirm

# Change default SHELL to zsh
sudo chsh -s $(which zsh) $(whoami)

zsh_config_dir="$HOME/.config/zsh"

if [[ ! -d "$zsh_config_dir" ]]; then
  mkdir -v -p "$zsh_config_dir"
fi

dirname_install="/tmp/dotfiles_install"

git clone https://github.com/CLozano03/dotfiles "$dirname_install" -q 

echo -e "  ==>  Copying ~/.zshrc..." && sleep 0.5 && cp "$dirname_install"/.zshrc $HOME/.zshrc
echo -e "  ==>  Copying zsh config in "$zsh_config_dir"..." && sleep 0.5 && cp -r "$dirname_install"/.config/zsh/* "$zsh_config_dir"
echo -e "  ==>  Deleting aux directory for instalation" && sleep 0.5 && rm -rf "$dirname_install" 
echo -e "\n  ==>  Zsh configuration ready for use. Close your terminal and reopen it for installing all the plugins\n"

exit 0
