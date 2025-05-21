#!/bin/sh

WAYBAR_DIR="$HOME/.config/waybar"
current_theme="cl-original"
config_file="config.jsonc"
style_file="style.css"

# Kill all waybar instances
killall waybar
pkill waybar
sleep 0.3

if [ ! -f $HOME/.cache/waybar-disabled ]; then
    waybar -c ${WAYBAR_DIR}/themes/${current_theme}/$config_file -s ${WAYBAR_DIR}/themes/${current_theme}/$style_file &
else
    echo ":: Waybar disabled"
    notify-send "! Waybar disabled"
fi

exit 0
