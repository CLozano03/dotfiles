#!/bin/sh

sh ~/.config/hypr/scripts/dunst.sh      # dunst
sh ~/.config/waybar/launch.sh           # waybar
hyprctl reload && 
dunstify "Hyprctl reload"               # hypr  
sh ~/.config/hypr/scripts/term_ack.sh   # term_ack
