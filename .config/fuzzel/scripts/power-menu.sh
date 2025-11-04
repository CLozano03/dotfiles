#!/bin/bash

SELECTION="$(printf "󰐥 Shutdown\n󰌾 Lock\n󰤄 Suspend\n󰍃 Log out\n Reboot\n Reboot to UEFI" | fuzzel --dmenu)"

case $SELECTION in
*"󰌾 Lock"*)
    hyprlock -q
    ;;
*"󰤄 Suspend"*)
    systemctl suspend
    ;;
*"󰍃 Log out"*)
    hyprctl dispatch exit
    ;;
*" Reboot"*)
    systemctl reboot
    ;;
*" Reboot to UEFI"*)
    systemctl reboot --firmware-setup
    ;;
*"󰐥 Shutdown"*)
    shutdown now
    ;;
esac
