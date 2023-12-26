#!/bin/zsh
# Path: ~/.config/zsh/aliases.zsh

# Para algunos 'misspelings'
alias pdw='pwd'
alias chomd='chmod' 

# Configuración de zsh
alias zshconf='code ~/.zshrc'
alias ohmyzsh='code ~/.oh-my-zsh'
# Actualizar configuración de zsh
alias zshrc='source ~/.zshrc'

alias ls='lsd'
alias cat='bat --style=plain --color=always'
alias catn='command cat'
alias c='clear'
alias v='nvim'
alias scilab='scilab &'

# Mostrar NEOFETCH al limpiar la terminal
alias clear='clear && neofetch'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'

# cp, mv, rm con verbose y mas seguridad
alias cp='cp -vi'
alias mv='mv -vi'
alias rm='rm -v --preserve-root'

# Añadir flags
alias mkdir='mkdir -pv'
alias df='df -h'
alias du='du -h'
alias free='free -m'
alias ping='ping -c 3'

# Comandos de directorios
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Comandos de git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gbr='git branch'
alias gbrd='git branch -d'

# Actualizar sistema
alias update='sudo pacman -Syu'
alias updateyay='yay -Syu'

# Visor de pdf evince con open
open() { evince "$@" > /dev/null 2>&1 & disown; }
# Visor de imagenes  geeqie con view
view() { geeqie "$@" > /dev/null 2>&1 & disown; }

# Generador de contraseñas
alias genpasswd='echo `env LC_CTYPE=C tr -dc "a-zA-Z0-9-_\$\?" < /dev/urandom | head -c 20`'

# Rickroll 😏
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'




