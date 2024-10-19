#!/bin/sh

file="$HOME/.config/hypr/conf/var.conf"
term=$(cat $file | grep 'terminal' | awk '{print $NF}')

echo $term

if [ "$term" = "alacritty" ]; then
    term="Alacritty"
fi

sed -i '/\$wRTerminal/d' $file # Remove the line with the word wRTerminal

echo "\$wRTerminal = $term" >> $file # Add the new terminal

exit 0