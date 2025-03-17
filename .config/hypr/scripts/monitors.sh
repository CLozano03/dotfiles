#!/bin/sh
hyprctl -j monitors

resolution=$(hyprctl monitors | grep -A 1 "HDMI-A-1" | awk -F'[@ ]' 'NR==2 {print $1}'| tr -d '\t|\n')

if [ ! "$resolution" ]; then
    echo "No monitor connected" && exit 1
fi

echo "source = ~/.config/hypr/conf/monitors/${resolution}.conf" > ~/.config/hypr/conf/monitor.conf
