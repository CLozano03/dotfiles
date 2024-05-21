#!/bin/sh
#  ____                               _           _    
# / ___|  ___ _ __ ___  ___ _ __  ___| |__   ___ | |_  
# \___ \ / __| '__/ _ \/ _ \ '_ \/ __| '_ \ / _ \| __| 
#  ___) | (__| | |  __/  __/ | | \__ \ | | | (_) | |_  
# |____/ \___|_|  \___|\___|_| |_|___/_| |_|\___/ \__| 
#                                                      
#  
# by Stephan Raabe (2023) 
# ----------------------------------------------------- 

arg1=("$1")

DIR="$HOME/Imagenes/screenshots/"
NAME="screenshot_$(date +%d%m%Y_%H%M%S).png"

case $arg1 in
    1)
        grim -g "$(slurp)" "$DIR$NAME"
        xclip -selection clipboard -t image/png -i "$DIR$NAME"
        echo "Screenshot created and copied to clipboard" "Mode: Selected area"
        #notify-send "Screenshot created and copied to clipboard" "Mode: Selected area"
        swappy -f "$DIR$NAME"
    ;;
    2)
        sleep 1
        grim "$DIR$NAME" 
        xclip -selection clipboard -t image/png -i "$DIR$NAME"
        echo "Screenshot created and copied to clipboard" "Mode: Fullscreen"
        #notify-send "Screenshot created and copied to clipboard" "Mode: Fullscreen"
        swappy -f "$DIR$NAME"
    ;;
esac
