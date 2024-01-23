#!/bin/zsh
# Path: $XDG_CONFIG_HOME/zsh/aliases.zsh

#Cargar alias de otros archivos
source ""$XDG_CONFIG_HOME"/zsh/aliases/git_aliases.zsh"

# Para algunos "misspelings"
alias pdw="pwd"
alias chomd="chmod" 

# Configuración
alias zshconf="code "$HOME"/.zshrc"
alias ohmyzsh="code "$HOME"/.oh-my-zsh"
alias qtconf="code "$XDG_CONFIG_HOME"/qtile/config.py"
# Actualizar configuración de zsh
alias zshrc="source ~/.zshrc"

# Cambiar ls por lsd y ajustar normales
alias ls="lsd"
alias lsn="command ls"
alias lln="command ls -l"

alias cat="bat --color=always"
alias catn="command cat"
alias c="clear"
alias clear="clear && neofetch"
alias v="nvim"
alias scilab="scilab &"

# Mostrar NEOFETCH al limpiar la terminal
alias clear="clear && neofetch"

# Colorize grep output (good for log files)
alias grep="grep --color=auto"

# cp, mv, rm con verbose y mas seguridad
alias cp="cp -vi"
alias mv="mv -vi"
alias rm="rm -v --preserve-root"

# Añadir flags
alias mkdir="mkdir -pv"
alias df="df -h"
alias du="du -h"
alias free="free -m"
alias ping="ping -c 3"

# Comandos de directorios
alias ..="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."

# Mostrar aliases en formato less/bat
alias aliasn="alias | bat"

# Actualizar sistema
alias update="sudo pacman -Syu"
alias updateyay="yay -Syu"

# Visor de pdf evince con open
open() { evince "$@" > /dev/null 2>&1 & disown; }
# Visor de imagenes  geeqie con view
view() { geeqie "$@" > /dev/null 2>&1 & disown; }
# Libreoffice con loff
loff() { libreoffice "$@" > /dev/null 2>&1 & disown; }

# Apagar, reiniciar, suspender, hibernar
alias pof="shutdown now"
alias rb="reboot"
alias susp="systemctl suspend"
alias hib="systemctl hibernate"

# Generarr una contraseña aleatoria
alias genpasswd="echo `env LC_CTYPE=C tr -dc "a-zA-Z0-9-_\$\?" < /dev/urandom | head -c 20`"

# Rickroll 😏
alias rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"

