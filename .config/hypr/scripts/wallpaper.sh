#!/bin/sh

# Dirs
wallpaper_dir="$HOME/Pictures/wallpapers"
cache_dir="$HOME/.cache/wallpapers"
generated_versions="$cache_dir/wallpaper_generated_versions"

# Files
cache_file="$cache_dir/current_wallpaper"
blurred_wallpaper="$cache_dir/blurred_wallpaper.png"
square_wallpaper="$cache_dir/square_wallpaper.png"
rasi_file="$cache_dir/current_wallpaper.rasi"
blur="20x8"

# Creating cache_dir if not exists
if [ ! -d $cache_dir ]; then mkdir -p $cache_dir; fi
# Create folder with generated versions if not exists
if [ ! -d $generated_versions ]; then mkdir -p $generated_versions; fi

# ----------------------------------------------------- 
# Get selected wallpaper
# ----------------------------------------------------- 

if [ -z $1 ] ;then
    if [ -f $cache_file ] ;then
        wallpaper=$(cat $cache_file)
    else
        wallpaper=$default_wallpaper
    fi
else
    wallpaper=$1
fi
used_wallpaper=$wallpaper
echo ":: Setting wallpaper with original image $wallpaper"

# ----------------------------------------------------- 
# Copy path of current wallpaper to cache file
# ----------------------------------------------------- 
if [ ! -f $cache_file ] ;then
    touch $cache_file
fi
echo "$wallpaper" > $cache_file
echo ":: Path of current wallpaper copied to $cache_file"

# Get wallpaper filename
wallpaper_filename=$(basename $wallpaper)
echo ":: Wallpaper Filename: $wallpaper_filename"

# Execute pywal
echo ":: Execute pywal with $wallpaper"
wal -q -i $wallpaper
# source "$cache_dir/wal/colors.sh"

# ----------------------------------------------------- 
# Wallpaper Effects
# -----------------------------------------------------

if [ -f $HOME/dotfiles/.settings/wallpaper-effect.sh ] ;then
    effect=$(cat $HOME/dotfiles/.settings/wallpaper-effect.sh)
    if [ ! "$effect" == "off" ] ;then
        used_wallpaper=$generated_versions/$effect-$wallpaper_filename
        if [ -f $generated_versions/$effect-$wallpaper_filename ] && [ "$force_generate" == "0" ] && [ "$use_cache" == "1" ] ;then
            echo ":: Use cached wallpaper $effect-$wallpaper_filename"
        else
            echo ":: Generate new cached wallpaper $effect-$wallpaper_filename with effect $effect"
            dunstify "Using wallpaper effect $effect..." "with image $wallpaper_filename" -h int:value:10 -h string:x-dunst-stack-tag:wallpaper
            source $HOME/dotfiles/hypr/effects/wallpaper/$effect
        fi
        echo ":: Loading wallpaper $generated_versions/$effect-$wallpaper_filename with effect $effect"
    else
        echo ":: Wallpaper effect is set to off"
    fi
fi

# ----------------------------------------------------- 
# Reload Waybar
# -----------------------------------------------------
sh ~/dotfiles/waybar/launch.sh &> /dev/null

# ----------------------------------------------------- 
# Created blurred wallpaper
# -----------------------------------------------------

echo ":: Generate new cached wallpaper blur-$blur-$wallpaper_filename with blur $blur"
magick $wallpaper -resize 75% $blurred_wallpaper
echo ":: Resized to 75%"
if [ ! "$blur" == "0x0" ] ;then
    magick $blurred_wallpaper -blur $blur $blurred_wallpaper
    cp $blurred_wallpaper $generated_versions/blur-$blur-$wallpaper_filename.png
    echo ":: Blurred"
fi
cp $generated_versions/blur-$blur-$wallpaper_filename.png $blurred_wallpaper

# ----------------------------------------------------- 
# Create rasi file
# ----------------------------------------------------- 
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
fi
echo "* { current-image: url(\"$blurred_wallpaper\", height); }" > "$rasi_file"