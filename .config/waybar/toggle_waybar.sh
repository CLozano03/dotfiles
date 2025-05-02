#!/bin/bash
# Toggles waybar display

if [ -f ~/.cache/waybar-disabled ] ;then
    rm ~/.cache/waybar-disabled
    sh $HOME/.config/waybar/launch.sh &
else
    touch ~/.cache/waybar-disabled
    killall waybar && pkill waybar
fi
