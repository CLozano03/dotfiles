#!/bin/sh

# This script is used to change some settings of the system
option=$1
quantity=$2 # This is the quantity of the change, for example, 5 or 10

case $option in
    volumetoggle)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        notify-send "toggle volume"
        ;;
    volumeup)
        pactl set-sink-volume @DEFAULT_SINK@ +"$quantity"%
        current_vol=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n 1 | awk '{print $5}' | awk -F'%' '{print $1}')
        dunstify "Volume" "$current_vol%" -t 1000 -r 60
        ;;
    volumedown)

        pactl set-sink-volume @DEFAULT_SINK@ -"$quantity"%
        current_vol=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n 1 | awk '{print $5}' | awk -F'%' '{print $1}')
        dunstify "Volume" "$current_vol%" -t 1000 -r 60
        ;;
    brightnessup)
        light -A 5%
        dunstify "Brightness" "$(light -G)%" -t 1000 -r 50
        ;;
    brightnessdown)
        light -U 5%
        dunstify "Brightness" "$(light -G)%" -t 1000 -r 50
        ;;
    *)
        echo "Invalid argument"
        ;;
esac