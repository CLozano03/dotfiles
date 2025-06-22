#!/bin/sh

WAYBAR_DIR="$HOME/.config/waybar"
config_file="config.jsonc"
style_file="style.css"

current_theme="cl-original"

# Kill all waybar instances
killall waybar
pkill waybar
# sleep 0.2

if [ ! -f $HOME/.cache/waybar-disabled ]; then
    waybar -c ${WAYBAR_DIR}/themes/${current_theme}/$config_file -s ${WAYBAR_DIR}/themes/${current_theme}/$style_file &
else
    echo ":: Waybar disabled"
    notify-send "! Waybar disabled"
fi

exit 0
