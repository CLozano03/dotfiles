#!/bin/sh

LOCK_DIR="$HOME/.config/hypr"
CACHE_DIR="$HOME/.cache/hyprlock"
LOCK_CONF="$LOCK_DIR/hyprlock.conf"
CONF_DIR="$LOCK_DIR/hyprlock.d"
MEDIA_SCRIPT="$LOCK_DIR/scripts/media.sh"
BACKGROUNDS_FILENAME="generated_backgrounds.conf"


# Pause media
if [[ "$(playerctl status 2>/dev/null)" == "Playing" ]]; then 
    sh "$MEDIA_SCRIPT" --pause && sleep 0.2
fi

# Create DIRS
mkdir -p "$CONF_DIR"
mkdir -p "$CACHE_DIR"

# Delete old files
rm -f "$CACHE_DIR"/lock_*.png
rm -f ${CONF_DIR}/${BACKGROUNDS_FILENAME}

# Capturar todos los monitores y generar sus bloques de configuración
monitors=$(hyprctl monitors -j | jq -r '.[].name')

for mon in $monitors; do
    img="$CACHE_DIR/lock_${mon}.png"
    grim -o "$mon" "$img"

    cat >> ${CONF_DIR}/${BACKGROUNDS_FILENAME} <<EOF
background {
    monitor = $mon
    path = $img
    blur_size = 3
    blur_passes = 3
    noise = 0.0117
    contrast = 1.3
    brightness = 0.9
    vibrancy = 0.21
    vibrancy_darkness = 0.0
}
EOF
done

# Use last monitos as fallback
LAST_IMG="$CACHE_DIR/lock_$(echo "$monitors" | tail -n1).png"
cp "$LAST_IMG" "$CACHE_DIR/lock.png"

# Generar la configuración final combinando todos los .conf de hyprlock.d
cat "$CONF_DIR"/*.conf > "$LOCK_CONF"

# Lanzar Hyprlock
pidof hyprlock || hyprlock -q
