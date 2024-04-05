#!/bin/sh

# shortcut to this dotfiles path is $DOTFILES
export DOTFILES="$HOME/dotfiles"

export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$ZSH/custom
export XDG_CONFIG_HOME=$HOME/.config
export ZSH_CONFIG=$XDG_CONFIG_HOME/zsh
#Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="afowler" 
ZSH_THEME="agnoster"

# Default editor
export EDITOR='nvim'
export VEDITOR='code'

# Java version can be changed between 11 and 22
export JAVA_VERSION=11
export JAVA_HOME=/usr/lib/jvm/java-"$JAVA_VERSION"-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# all of our zsh files
typeset -U config_files
#config_files=("$DOTFILES"/*/*.zsh)

# Load config files
#source "$DOTFILES"/.config/zsh/config.zsh

unset config_files 

# Uncomment the following line to use case-sensitive completion.
#CASE_SENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	zsh-history-substring-search
)

source $ZSH/oh-my-zsh.sh

# Prompt configuration
function dir_icon {
	if [[ "$PWD" == "$HOME" ]]; then
		echo "%B%F{yellow}%f%b"
	else
		echo "%B%F{cyan}%f%b"
	fi
}

function parse_git_branch {
	local branch
	branch=$(git symbolic-ref --short HEAD 2> /dev/null)
	if [ -n "$branch" ]; then
		echo " [$branch]"
	fi
}

PROMPT=' %F{cyan}󰣇%f %F{magenta}%n%f $(dir_icon) %F{red}%~%f%${vcs_info_msg_0_} %F{yellow}$(parse_git_branch)%f %(?.%B%F{green}.%F{red})%f%b '


# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# =====Aliases=====
# Carga de aliases del archivo aliases.zsh
if [ -f ""$ZSH_CONFIG"/private_aliases.zsh" ]; then 
  source ""$ZSH_CONFIG"/private_aliases.zsh" # Aliases privadoss
fi
source ""$ZSH_CONFIG"/aliases.zsh"          # Aliases generales cargar SIEMPRE EL ULTIMO enre todos los archivos de aliases

# =====Fin Aliases=====
# =====Shortcuts=====
bindkey -s '^L' 'clear\n'     # Ctrl + L

# Función para agregar sudo al principio de la línea actual
add_sudo_prefix() {
    LBUFFER="sudo $LBUFFER"
    zle reset-prompt
}

# Asocia la función al atajo de teclado Ctrl+j
zle -N add_sudo_prefix
bindkey '^K' add_sudo_prefix
# =====Fin Shortcuts=====

# Mutear sonidos de campana
xset -b

# Cargar logo Arch en la terminal cuando se abre
clear

#No lineas duplicadas en historial
setopt HIST_IGNORE_DUPS

# Cargar zoxide
eval "$(zoxide init zsh)"2


# ========= CIAOPATH ============

# @begin(97218204)@ - Do not edit these lines - added automatically!
# You should customize CIAOPATH before this chunk if you place bundles in
# places other than ~/.ciao
if [ -x /home/cesar/.ciaoroot/v1.22.0-m7/build/bin/ciao-env ] ; then
  eval "$(/home/cesar/.ciaoroot/v1.22.0-m7/build/bin/ciao-env --sh)"
fi
# @end(97218204)@ - End of automatically added lines.
