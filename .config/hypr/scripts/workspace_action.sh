#!/bin/sh

BLOCK_SIZE=10
CURRENT_WS=$(hyprctl activeworkspace -j | jq -r .id)
BASE=$(( ( (CURRENT_WS - 1) / BLOCK_SIZE ) * BLOCK_SIZE ))
TARGET_WS=$(( BASE + $2 ))

hyprctl dispatch "$1" "$TARGET_WS"
