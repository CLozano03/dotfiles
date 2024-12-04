#!/bin/bash

# Pause first if there is media playing
if [[ "$(playerctl status)" == "playing" ]]; then 
    sh ~/.config/hypr/scripts/media.sh --pause && sleep 0.2
fi

pidof hyprlock || hyprlock -q 
