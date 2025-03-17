#!/bin/sh

# Script used to toggle settings
option=$1
quantity=$2 # This is the quantity of the change, for example, 5 or 20

# Function to dunstify the volume
notify_mic(){
    mic_muted="$(pactl list sources | grep -A 7 'input' | grep 'Mute' | awk 'END {print}' | awk '{print $2}')"

    if [[ "$mic_muted" == "yes" ]]; then
        dunstify -a "toggling" -i microphone-off "Off" -r 60 -t 1000
    else
        dunstify -a "toggling" -i microphone "On" -r 60 -t 1000
    fi
}

notify_pad(){
    pad_enabled="$(xinput list-props 'SynPS/2 Synaptics TouchPad' | grep 'Device Enabled' | awk '{print $4}')"

    if [[ "$pad_enabled" == 1 ]]; then
        dunstify -a "toggling" -i trackpad-lock "Touchpad lock" -r 65 -t 1000
    else
        dunstify -a "toggling" -i trackpad "Touchpad enabled" -r 65 -t 1000
    fi
}

case $option in
    togglemic)
        pactl set-source-mute @DEFAULT_SOURCE@ toggle
        notify_mic;
        ;;
    togglepad)
        notify_pad
        ;;
    *)
        echo "Invalid argument"
        exit 1
        ;;
esac

exit 0