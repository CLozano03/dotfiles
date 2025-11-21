#!/bin/sh

TERMINAL_CLASS="kitty"
TERMINAL_TITLE="floating-terminal"
LAUNCH_CMD="kitty --title $TERMINAL_TITLE"

if hyprctl clients -j | jq -e ".[] | select(.class == \"$TERMINAL_CLASS\" and .title == \"$TERMINAL_TITLE\")" >/dev/null; then
    hyprctl dispatch togglespecialworkspace term

else
    $LAUNCH_CMD
fi
