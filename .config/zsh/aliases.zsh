#!/bin/zsh
# Path: $XDG_CONFIG_HOME/zsh/aliases.zsh

# Some "misspelings"
alias pdw="pwd"
alias chomd="chmod" 

# Edit config files
alias zshconf=""$EDITOR" "$HOME"/.zshrc"
alias ohmyzsh=""$EDITOR" "$HOME"/.oh-my-zsh"
alias alaconf=""$EDITOR" "$XDG_CONFIG_HOME"/alacritty/alacritty.toml"
alias kittyconf=""$EDITOR" "$XDG_CONFIG_HOME"/kitty/kitty.conf"
alias ffconf=""$EDITOR" "$XDG_CONFIG_HOME"/fastfetch/config.jsonc"
alias neoconf=""$EDITOR" "$XDG_CONFIG_HOME"/neofetch/config.conf"
alias aliasconf=""$EDITOR" "$XDG_CONFIG_HOME"/zsh/aliases.zsh"
#alias greetconf="sudo "$EDITOR" /etc/lightdm/lightdm.conf"
alias hyprconf=""$VEDITOR" "$HOME"/.config/hypr"
alias barconf=""$VEDITOR" "$HOME"/.config/waybar"

# Update zsh configuration
alias zshrc="source ~/.zshrc"

# bat
alias cat='bat --style=plain'
alias catnp='bat --style=plain --paging=never'

# ls
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias lln="command ls -l"
alias lt="lsd --total-size -l" # Show total size of each directory. Takes some time

# Zoxide instead of cd
alias cd="z"
alias cdi="zi" # Buscar un directorio

alias c="clear"
alias v="nvim"
alias j="just"
alias edit="code ." # Open VSCode in the current directory
alias em="emacs -nw"
alias emacs="emacsclient -c -a 'emacs'"
alias echo="echo -e"
alias neo="neofetch"
alias htop="btop"
alias gparted="sudo -E gparted"
alias :q="exit"
alias cppath="pwd | wl-copy"


# Show NEOFETCH when clearing terminal

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
alias catalias="alias | cat"
alias aliasn="catalias"

# Update system
alias update="sudo pacman -Syu"
alias updateyay="yay -Syu"

#Instaling
install(){sudo pacman -S "$@" }
installyay(){ yay -S "$@" }

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

# Generate random passwd from a length
source "$ZSH_CONFIG"/genpasswd.sh

# Rickroll 😏
alias rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | sed 's/has?/has/g' | sh"

