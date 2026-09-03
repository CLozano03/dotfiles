# ~/.zprofile

# Init Hyprland without greeter
if [ -z "$WAYLAND_DISPLAY" ] && [ -z "$DISPLAY" ]; then
  exec start-hyprland
  # exec startx lxqt-session
fi
