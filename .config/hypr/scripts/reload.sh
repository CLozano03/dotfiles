#!/bin/sh

LOCK_FILE="$HOME/.cache/reload.lock"
if [ -f $LOCK_FILE ]; then exit 0; fi

touch $LOCK_FILE

# Kill processes to be restarted
_ps=(waybar rofi swaync hypridle)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" >/dev/null; then
        pkill "${_prs}"
    fi
done

# Sway
# sleep 0.2
# swaync
# notify-send "Sway reload"

# Hypr
hyprctl reload # && notify-send "Hypr reload"
hypridle &

# Waybar
if [ ! -f ~/.cache/waybar-disabled ]; then
    sh ~/.config/waybar/launch.sh
fi
#notify-send "Waybar restarted"

rm $LOCK_FILE
