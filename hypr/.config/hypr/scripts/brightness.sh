#!/bin/sh

option=$1

notify_bright(){

    light=$(light -G | awk -F'.' '{print $1}')
    echo $light

    if [[ "$light" -lt 25 ]]; then
        notify-send -a brightness -i brightness-1 "${light} %" -t 1000 -r 50
    elif [[ "$light" -lt 45 ]]; then
        notify-send -a brightness -i brightness-2 "${light} %" -t 1000 -r 50
    elif [[ "$light" -lt 70 ]]; then
        notify-send -a brightness -i brightness-3 "${light} %" -t 1000 -r 50
    else
        notify-send -a brightness -i brightness-4 "${light} %" -t 1000 -r 50
    fi
}


case $option in
    brightnessup)
        light -A 5%
        notify_bright;
        ;;
    brightnessdown)
        light -U 5%
        notify_bright;
        ;;
    *)
        echo "Invalid argument"
        ;;
esac