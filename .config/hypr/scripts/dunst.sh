#!/bin/sh

killall dunst 

if [ $? == 0 ]; then
    dunst &
    notify-send "Dunst restarted"
else
    dunst &
    notify-send "Dunst started"
fi