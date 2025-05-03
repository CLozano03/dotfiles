# ~/.zprofile

# Init Hyprland without greeter
if [ "$(tty)" = "/dev/tty1" ] && [ -z "$WAYLAND_DISPLAY" ] && [ -z "$DISPLAY" ]; then
    exec Hyprland
fi
