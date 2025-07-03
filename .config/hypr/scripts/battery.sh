#!/bin/sh

# Get the current battery details
BATTERY_INFO=$(upower -i $(upower -e | grep BAT))
BATTERY_LEVEL=$(echo "$BATTERY_INFO" | grep percentage | awk '{print $2}' | tr -d '%')
BATTERY_STATE=$(echo "$BATTERY_INFO" | grep state | awk '{print $2}')

# Select the icon based on the battery level
if [ "$BATTERY_STATE" == "charging" ]; then
    if [ "$BATTERY_LEVEL" -ge 92 ]; then
        ICON="󰂅" # nf-md-battery
    elif [ "$BATTERY_LEVEL" -ge 85 ]; then
        ICON="󰂋" # nf-md-battery_90
    elif [ "$BATTERY_LEVEL" -ge 75 ]; then
        ICON="󰂊" # nf-md-battery_80
    elif [ "$BATTERY_LEVEL" -ge 65 ]; then
        ICON="󰢞" # nf-md-battery_70
    elif [ "$BATTERY_LEVEL" -ge 55 ]; then
        ICON="󰂉" # nf-md-battery_60 
    elif [ "$BATTERY_LEVEL" -ge 45 ]; then
        ICON="󰢝" # nf-md-battery_50
    elif [ "$BATTERY_LEVEL" -ge 35 ]; then
        ICON="󰂈" # nf-md-battery_40   
    elif [ "$BATTERY_LEVEL" -ge 25 ]; then
        ICON="󰂇" # nf-md-battery_30
    elif [ "$BATTERY_LEVEL" -ge 15 ]; then
        ICON="󰂆" # nf-md-battery_20
    else
        ICON="󰢜"
    fi
else
    if [ "$BATTERY_LEVEL" -ge 92 ]; then
        ICON="󰁹" # nf-md-battery
    elif [ "$BATTERY_LEVEL" -ge 85 ]; then
        ICON="󰂂" # nf-md-battery_90
    elif [ "$BATTERY_LEVEL" -ge 75 ]; then
        ICON="󰂁" # nf-md-battery_80
    elif [ "$BATTERY_LEVEL" -ge 65 ]; then
        ICON="󰂀" # nf-md-battery_70
    elif [ "$BATTERY_LEVEL" -ge 55 ]; then
        ICON="󰁿" # nf-md-battery_60 
    elif [ "$BATTERY_LEVEL" -ge 45 ]; then
        ICON="󰁾" # nf-md-battery_50
    elif [ "$BATTERY_LEVEL" -ge 35 ]; then
        ICON="󰁾" # nf-md-battery_40   
    elif [ "$BATTERY_LEVEL" -ge 25 ]; then
        ICON="󰁼" # nf-md-battery_30
    elif [ "$BATTERY_LEVEL" -ge 15 ]; then
        ICON="󰁻" # nf-md-battery_20
    else
        ICON="󰁺"
    fi
fi

echo ""$BATTERY_LEVEL"% $ICON"