#!/bin/zsh
# Path: ~/.config/zsh/aliases.zsh

# Para algunos 'misspelings'
alias pdw='pwd'
alias chomd='chmod' 

# Configuración
alias zshconf='code ~/.zshrc'
alias ohmyzsh='code ~/.oh-my-zsh'
alias qtconf='code ~/.config/qtile/config.py'
# Actualizar configuración de zsh
alias zshrc='source ~/.zshrc'

# Cambiar ls por lsd y ajustar normales
alias ls='lsd'
alias lsn='command ls'
alias lln='command ls -l'

alias cat='bat --color=always'
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

# Mostrar aliases en formato less/bat
alias aliasn='alias | bat'

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

# Apagar, reiniciar, suspender, hibernar
alias pof='shutdown now'
alias rb='sudo reboot now'
alias susp='systemctl suspend'
alias hib='systemctl hibernate'

# Visor de pdf evince con open
open() { evince "$@" > /dev/null 2>&1 & disown; }
# Visor de imagenes  geeqie con view
view() { geeqie "$@" > /dev/null 2>&1 & disown; }
# Libreoffice con loff
loff() { libreoffice "$@" > /dev/null 2>&1 & disown; }

# Generarr una contraseña aleatoria
alias genpasswd='echo `env LC_CTYPE=C tr -dc "a-zA-Z0-9-_\$\?" < /dev/urandom | head -c 20`'

# Rickroll 😏
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

