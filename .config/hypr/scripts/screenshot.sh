#!/bin/sh

# Dir when screensots are going to be stored
DIR="$HOME/Pictures/screenshots/"
if [ ! -d $DIR ]; then mkdir -p $DIR; fi

NAME="scs_$(date +%d%m%Y_%H%M%S).png"

case $1 in
    1)
        selected="$(slurp)"
        sleep 0.2 && grim -g "$selected" "$DIR$NAME" # Have to sleep for correct screenshot
    
        if [[ $? -eq 0 ]]; then
            command cat "$DIR$NAME" | wl-copy
            notify-send "Screenshot created and copied to clipboard" "Mode: Selected area"
            swappy  -f "$DIR$NAME"
        fi
    ;;
    2)
        sleep 0.6
        grim "$DIR$NAME"
        command cat "$DIR$NAME" | wl-copy
        notify-send "Screenshot created and copied to clipboard" "Mode: Fullscreen"
        swappy -f "$DIR$NAME"
    ;;
esac
