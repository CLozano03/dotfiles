#!/bin/sh

# Dir when screensots are going to be stored
DIR="$HOME/Pictures/screenshots/"
if [ ! -d $DIR ]; then mkdir -p $DIR; fi

NAME="scs_$(date +%d%m%Y_%H%M%S).png"

if [ ! -z $(hyprshade current) ] ;then
    current_hyprshade=$(hyprshade current)
    echo ":: Switch hyprshade off"
    hyprshade off
fi


case $1 in
    1)
        selected="$(slurp)" || exit 1
        sleep 0.2 && grim -g "$selected" "$DIR$NAME" # Have to sleep for correct screenshot
    
        if [ ! -z $current_hyprshade ] ;then
            hyprshade on $current_hyprshade
        fi

        command cat "$DIR$NAME" | wl-copy
        notify-send "Screenshot created and copied to clipboard" "Mode: Selected area"
        swappy  -f "$DIR$NAME"


    ;;
    2)
        sleep 0.6
        grim "$DIR$NAME"

        if [ ! -z $current_hyprshade ] ;then
            hyprshade on $current_hyprshade
        fi

        command cat "$DIR$NAME" | wl-copy
        notify-send "Screenshot created and copied to clipboard" "Mode: Fullscreen"
        swappy -f "$DIR$NAME"
    ;;
    3)
        sleep 1
        monitor="$(hyprctl monitors | awk '/Monitor/{monitor=$2} /focused: yes/{print monitor; exit}')"
        grim -o "$monitor" "$DIR$NAME"

        if [ ! -z $current_hyprshade ] ;then
            hyprshade on $current_hyprshade
        fi

        command cat "$DIR$NAME" | wl-copy
        notify-send "Screenshot created and copied to clipboard" "Mode: Fullscreen"
        swappy -f "$DIR$NAME"
    ;;
esac

exit 0