#!/bin/bash
#   ____ _ _       _     _     _    
#  / ___| (_)_ __ | |__ (_)___| |_  
# | |   | | | '_ \| '_ \| / __| __| 
# | |___| | | |_) | | | | \__ \ |_  
#  \____|_|_| .__/|_| |_|_|___/\__| 
#           |_|                     
#  

# Clipboard Manager. This script uses cliphist, rofi, and wl-copy.

# Actions:
# CTRL Del to delete an entry
# ALT Del to wipe clipboard contents

while true; do
    result=$(
        rofi -i -dmenu \
            -kb-custom-1 "Control-Delete" \
            -kb-custom-2 "Alt-Delete" \
            -config ~/dotfiles/.config/rofi/config-clipboard.rasi < <(cliphist list)
    )

    case "$?" in
        1)
            exit
            ;;
        0)
            case "$result" in
                "")
                    continue
                    ;;
                *)
                    cliphist decode <<<"$result" | wl-copy
                    exit
                    ;;
            esac
            ;;
        10)
            cliphist delete <<<"$result"
            ;;
        11)
            cliphist wipe
            ;;
    esac
done




# case $1 in
#     d) cliphist list | rofi -dmenu -replace -config ~/dotfiles/rofi/config-cliphist.rasi | cliphist delete
#        ;;

#     w) if [ `echo -e "Clear\nCancel" | rofi -dmenu -config ~/dotfiles/rofi/config-short.rasi` == "Clear" ] ; then
#             cliphist wipe
#        fi
#        ;;

#     *) cliphist list | rofi -dmenu -replace -config ~/dotfiles/rofi/config-cliphist.rasi | cliphist decode | wl-copy
#        ;;
# esac
