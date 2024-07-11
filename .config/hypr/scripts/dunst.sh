#!/bin/sh

killall dunst && dunst &

if [ $? == 0 ]; then
    notify-send "Dunst restarted"
else
    dunst &
    notify-send "Dunst started"
fi
