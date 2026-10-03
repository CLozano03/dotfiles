#!/bin/bash

# Restaurar la configuración de GRUB desde tus dotfiles
cp ~/dotfiles/grub/default /etc/default/grub

# Generate config
grub-mkconfig -o /boot/grub/grub.cfg
echo ":: Restored and updated GRUB cfg"
