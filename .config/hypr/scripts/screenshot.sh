#!/bin/sh

arg1=("$1")

DIR="$HOME/Imagenes/screenshots/"
NAME="scs_$(date +%d%m%Y_%H%M%S).png"

if [ ! -d "$DIR" ]; then
    mkdir -p $DIR
fi

case $arg1 in
    1)
        slurp | grim -g - "$DIR$NAME"
    
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
