#!/bin/sh

# Script used to change volume settings
option=$1
quantity=$2 # This is the quantity of the change, for example, 5 or 20

# Function to dunstify the volume
notify_vol(){
    volume_val="$(pactl list sinks | grep '^[[:space:]]Volume:' | awk 'END {print}' | head -n 1 | awk '{print $5}' | awk -F'%' '{print $1}')"
    mute="$(pactl list sinks | grep 'Mute:' |  awk 'END {print}' | awk '{print $2}')"
    echo "$volume_val"

    if [[ "$volume_val" == 0 || "$mute" == "yes" ]]; then
        dunstify -a "pactl" -i volume-mute "Muted" -r 50 -t 1000
    elif [[ "$volume_val" -lt 30 ]]; then
        dunstify -a "pactl" -i volume-low "${volume_val} %" -r 50 -t 1000 # -h int:value:$volume_val
    elif [[ "$volume_val" -lt 70 ]]; then
        dunstify -a "pactl" -i volume-medium "${volume_val} %" -r 50 -t 1000        
    else
        dunstify -a "pactl" -i volume-high "${volume_val} %" -r 50 -t 1000        
    fi
}

case $option in
    volumetoggle)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        notify_vol;
        ;;
    volumeup)
        pactl set-sink-volume @DEFAULT_SINK@ +"$quantity"%
        notify_vol;
        ;;
    volumedown)
        pactl set-sink-volume @DEFAULT_SINK@ -"$quantity"%
        notify_vol;
        ;;
    *)
        echo "Invalid argument"
        ;;
esac

exit 0