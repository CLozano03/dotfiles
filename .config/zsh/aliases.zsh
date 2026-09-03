#!/bin/zsh
# Path: $XDG_CONFIG_HOME/zsh/aliases.zsh

# Some "misspelings"
alias pdw="pwd"
alias chomd="chmod"

alias bigfiles="sudo ncdu --exclude /proc --exclude /sys --exclude /dev --exclude /run --exclude /home /"

# Edit config files
alias zshconf=""$EDITOR" "$HOME"/.zshrc"
alias kittyconf=""$EDITOR" "$XDG_CONFIG_HOME"/kitty/kitty.conf"
alias nvimconf=""$EDITOR" "$XDG_CONFIG_HOME"/nvim/"
alias aliasconf=""$EDITOR" "$XDG_CONFIG_HOME"/zsh/aliases.zsh"
alias hyprconf=""$EDITOR" "$HOME"/.config/hypr"

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
alias iconda='source /opt/miniconda3/etc/profile.d/conda.sh'

# Zoxide instead of cd
alias cd="z"
alias cdi="zi" # Buscar un directorio

alias c="clear"
alias v="nvim"
alias j="just"
alias edit="code ." # Open VSCode in the current directory
alias echo="echo -e"
alias htop="btop"
alias :q="exit"
alias ZZ="exit"
alias cppath="pwd | wl-copy"
alias open="zat &>/dev/null"

# Colorize grep output (cool for log files)
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
install() {sudo pacman -S "$@" }
installyay() {
    yay -S "$@" }

    # Pdf evince with 'open'
    # open() {
    #     evince "$@" >/dev/null 2>&1 &
    #     disown
    # }
    # geeqie with 'view'
    view() {
        geeqie "$@" >/dev/null 2>&1 &
        disown
    }
    alias viewpic="kitten icat"
    # Libreoffice with 'loff'
    loff() {
        libreoffice "$@" >/dev/null 2>&1 &
        disown
    }

    aoc() {python $1 | tee >(wl-copy)
}

zat() {
    if [ $# -gt 0 ]; then
        echo "Opening PDF with Zathura..."
        zathura "$@" &>/dev/null &
        disown
    else
        local file
        file=$(find . -name "*.pdf" | fzf)

        if [ -n "$file" ]; then
            zathura "$@" &>/dev/null &
            disown
        fi
    fi
}

mdtopdf() {
  # Comprobar dependencias
  for cmd in pandoc wkhtmltopdf; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      echo "Error: '$cmd' is not installed. Please install it to use this function."
      return 1
    fi
  done

  # Comprobar argumento
  if [[ $# -ne 1 ]]; then
    echo "Use: mdtopdf <file.md>"
    return 1
  fi

  local input="$1"

  if [[ ! -f "$input" ]]; then
    echo "Error: '$input' does not exist."
    return 1
  fi

  local base="${input:r}"
  local html="${base}.html"
  local pdf="${base}.pdf"

  pandoc "$input" \
    -f gfm \
    -o "$html" \
    --standalone \
    --embed-resources \
    -c https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.5.1/github-markdown.min.css &&
  wkhtmltopdf "$html" "$pdf" &&
  rm "$html"

  if [[ $? -eq 0 ]]; then
    echo "Generated PDF: $pdf"
  else
    echo "Error: Failed to generate PDF."
    return 1
  fi
}


mdtotexpdf() {
  # Comprobar dependencias
  for cmd in pandoc; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      echo "Error: '$cmd' is not installed. Please install it to use this function."
      return 1
    fi
  done

  # Comprobar argumento
  if [[ $# -ne 1 ]]; then
    echo "Use: mdtopdf <file.md>"
    return 1
  fi

  local input="$1"

  if [[ ! -f "$input" ]]; then
    echo "Error: '$input' does not exist."
    return 1
  fi

  local base="${input:r}"
  local tex="${base}.tex"

  pandoc "$input" \
  --standalone \
  --pdf-engine=xelatex \
  -V geometry:margin=2.5cm \
  -o "$tex" &&
  latexmk -pdf "$tex" && latexmk -c "$tex" && rm "$tex"


  if [[ $? -eq 0 ]]; then
    echo "Generated pdf file: $pdf"
  else
    echo "Error: Failed to generate pdf file."
    return 1
  fi
}

# Power off, reboot, etc...
alias pof="shutdown now"
alias rb="reboot"
alias susp="systemctl suspend"

# Generate random passwd from a length
source "$ZSH_CONFIG"/genpasswd.sh

# Rickroll 😏
alias rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | sed 's/has?/has/g' | sh"
