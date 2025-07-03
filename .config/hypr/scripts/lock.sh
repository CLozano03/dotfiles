#!/bin/sh

LOCK_FILE="$HOME/.cache/lockscreen.lock"
if [ -f $LOCK_FILE ]; then exit 0; fi

touch $LOCK_FILE

# Launch Hyprlock
pidof hyprlock || hyprlock -q

rm $LOCK_FILE
