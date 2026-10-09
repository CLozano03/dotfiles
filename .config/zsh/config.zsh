#!/bin/sh

# History config
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt append_history
setopt hist_ignore_space # ignore commands that start with a space
setopt hist_find_no_dups # do not display duplicates in history search

bindkey -d # Reset all binds

# Bindkeys mode, load bindkeys, then overwrite
bindkey -e # Load emacs bindkeys by default
if [[ "$VI_MODE" -eq 1 ]]; then
    bindkey -v
fi

# Re-bind TAB to fzf-tab after the `bindkey -d` reset above wiped it
bindkey -M emacs '^I' fzf-tab-complete
bindkey -M viins '^I' fzf-tab-complete

bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey '<Down>' history-search-backward
bindkey '<Up>' history-search-forward

# Completion config
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' #ls 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu-no #list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# don't nice background tasks
setopt NO_BG_NICE
setopt NO_HUP
setopt NO_BEEP
#allow functions to have local options
setopt LOCAL_OPTIONS
# allow functions to have local traps
setopt LOCAL_TRAPS

bindkey '^[L' clear-screen

# edit command line in $EDITOR
autoload -z edit-command-line && zle -N edit-command-line && bindkey '^e' edit-command-line

bindkey '^O' autosuggest-accept
bindkey -s ^f "tmux-sessionizer\n"
bindkey -s '\eh' "tmux-sessionizer -s 0\n"
bindkey -s '\et' "tmux-sessionizer -s 1\n"
bindkey -s '\en' "tmux-sessionizer -s 2\n"
bindkey -s '\es' "tmux-sessionizer -s 3\n"

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;6D" beginning-of-line
bindkey "^[[1;6C" end-of-line

# ESC ESC to add sudo at the beggining of the line
add_sudo_prefix() {
    LBUFFER="sudo $LBUFFER"
    zle reset-prompt
}
zle -N add_sudo_prefix && bindkey '^[^[' add_sudo_prefix

autoload -Uz add-zsh-hook

function clean_empty_input() {
    local lines=("${(f)BUFFER}")

    # Delete lines if empty
    if ((${#lines[@]} > 1)); then
        local all_empty=true
        for line in $lines; do
            [[ -n "${line//[[:space:]]/}" ]] && all_empty=false
        done
        if $all_empty; then
            BUFFER=""
            zle reset-prompt
            return 0
        fi
    fi

    # Only a line -> Normal behavior
    zle .accept-line
}

zle -N accept-line clean_empty_input

# VIM MODE CONFIG

# Change cursor depending on the vim mode
function zle-keymap-select {
    case $KEYMAP in
    vicmd) echo -ne '\e[1 q' ;;        # Block (█) in normal mode
    viins | main) echo -ne '\e[5 q' ;; # Bar (|) in insert mode
    esac
    zle .redisplay
}

# Executed when new zsh line
function zle-line-init {
    # zle vi-cmd-mode # Uncoment line to init in normal mode
    zle-keymap-select
}

function custom-clean-screen() {
    zle clear-screen
    zle-keymap-select
}

if [[ "$VI_MODE" -eq 1 ]]; then
    zle -N zle-keymap-select
    zle -N zle-line-init
    zle -N custom-clean-screen
    bindkey '^?' backward-delete-char
    bindkey -M vicmd '^M' accept-line
    bindkey -M viins '^M' accept-line
    bindkey '^[^L' custom-clean-screen
fi

# -----------------------------------------------------------------------------
# AI-powered Git Commit Function
# Copy paste this gist into your ~/.bashrc or ~/.zshrc to gain the `gcm` command. It:
# 1) gets the current staged changed diff
# 2) sends them to an LLM to write the git commit message
# 3) allows you to easily accept, edit, regenerate, cancel
# But - just read and edit the code however you like
# the `llm` CLI util is awesome, can get it here: https://llm.datasette.io/en/stable/

unalias gcm 2>/dev/null
gcm() {
    # Function to generate commit message
    generate_commit_message() {
        git diff --cached | iconv -f UTF-8 -t UTF-16 -c | iconv -f UTF-16 -t UTF-8 -c | llm -m openrouter/cohere/north-mini-code:free "
Below is a diff of all staged changes, coming from the command:

\`\`\`
git diff --cached
\`\`\`

Please generate a concise, one-line commit message for these changes, following the Conventional Commits format: <type>: <description>, using one of these types: feat, fix, chore, refactor, docs, test, style, perf. Reply with only the commit message, no explanation." |
            sed '/^[[:space:]]*$/d' | tail -n 1 | sed -E 's/^"(.*)"$/\1/'
    }

    # Function to read user input compatibly with both Bash and Zsh
    read_input() {
        if [ -n "$ZSH_VERSION" ]; then
            echo -n "$1"
            read -r REPLY
        else
            read -p "$1" -r REPLY
        fi
    }

    # Main script
    echo "Generating AI-powered commit message..."
    commit_message=$(generate_commit_message)

    while true; do
        echo -e "\nProposed commit message:"
        echo "$commit_message"

        read_input "Do you want to (a)ccept, (e)dit, (r)egenerate, or (c)ancel? "
        choice=$REPLY

        case "$choice" in
        a | A)
            if git commit -m "$commit_message"; then
                echo "Changes committed successfully!"
                return 0
            else
                echo "Commit failed. Please check your changes and try again."
                return 1
            fi
            ;;
        e | E)
            read_input "Enter your commit message: "
            commit_message=$REPLY
            if [ -n "$commit_message" ] && git commit -m "$commit_message"; then
                echo "Changes committed successfully with your message!"
                return 0
            else
                echo "Commit failed. Please check your message and try again."
                return 1
            fi
            ;;
        r | R)
            echo "Regenerating commit message..."
            commit_message=$(generate_commit_message)
            ;;
        c | C)
            echo "Commit cancelled."
            return 1
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
        esac
    done
}
