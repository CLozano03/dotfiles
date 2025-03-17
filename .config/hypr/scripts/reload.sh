#!/bin/sh

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
hyprctl reload && notify-send "Hypr reload"
hypridle &

# Waybar
# waybar &
# notify-send "Waybar restarted"