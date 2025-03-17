#!/bin/sh

# Pause first if there is media playing
if [[ "$(playerctl status)" == "playing" ]]; then 
    sh ~/.config/hypr/scripts/media.sh --pause && sleep 0.2
fi

# Lock baground will be the current screen
grim $HOME/.config/hypr/lock.png

pidof hyprlock || hyprlock -q 
