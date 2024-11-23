#!/bin/sh

sh ~/.config/hypr/scripts/dunst.sh      # dunst
hyprctl reload && notify-send "Hypr reload"            # hypr  
sh "$HOME"/.config/waybar/launch.sh    && notify-send "Waybar restarted"   # waybar
sh ~/.config/hypr/scripts/term_ack.sh   # term_ack
