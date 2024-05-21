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
ZSH_THEME="afowler" 
#ZSH_THEME="agnoster"

export CATALINA_HOME=/usr/share/tomcat9
export AXIS2_HOME="$CATALINA_HOME"/webapps/axis2
export PATH=$AXIS2_HOME/bin:$PATH

# Default editor
export EDITOR='nvim'
export VEDITOR='code'

# Java version can be changed between 8, 11 and 22
export JAVA_VERSION=8
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

# =====Prompt======
# Load prompt configuration
source ""$ZSH_CONFIG"/prompt.zsh"
# ===End Prompt====
# =====Aliases=====
# Load aliases from the following files
if [ -f ""$ZSH_CONFIG"/private_aliases.zsh" ]; then 
  source ""$ZSH_CONFIG"/private_aliases.zsh" # Private aliasees
fi
source ""$ZSH_CONFIG"/aliases.zsh"          # General aliases
# =====End Aliases=====
#
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
# =====End Shortcuts=====

# Mutear sonidos de campana
xset -b

# Cargar Fastfetch cuando se abre
fastfetch

#No lineas duplicadas en historial
setopt HIST_IGNORE_DUPS

# Cargar zoxide
eval "$(zoxide init zsh)"2


# ========= CIAOPATH ============

# @begin(97218204)@ - Do not edit these lines - added automatically!
# You should customize CIAOPATH before this chunk if you place bundles in
# places other than ~/.ciao
if [ -x /home/cesar/.ciaoroot/v1.23.0-m1/build/bin/ciao-env ] ; then
  eval "$(/home/cesar/.ciaoroot/v1.23.0-m1/build/bin/ciao-env --sh)"
fi
# @end(97218204)@ - End of automatically added lines.

# Created by `pipx` on 2024-04-15 13:52:09
export PATH="$PATH:/home/cesar/.local/bin"
