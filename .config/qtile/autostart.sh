#!/bin/sh

#configuracion teclado espannol
setxkbmap es &

#iconos de sistema

#Discos
udiskie -t &

#Gestor de red networkmanager
nm-applet &

blueman-applet &

nitrogen --restore &

picom &
