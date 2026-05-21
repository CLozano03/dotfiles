#!/bin/bash

TERMINAL_CLASS="kitty"
TERMINAL_TITLE="floating-terminal"
LAUNCH_CMD="kitty --title $TERMINAL_TITLE"
SPECIAL_WS="special:term"

CLIENT_DATA=$(hyprctl clients -j | jq -r ".[] | select(.class == \"$TERMINAL_CLASS\" and .title == \"$TERMINAL_TITLE\")")

if [ -n "$CLIENT_DATA" ]; then
	hyprctl dispatch 'hl.dsp.workspace.toggle_special("term")'
else
	$LAUNCH_CMD &
fi
