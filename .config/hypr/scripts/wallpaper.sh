#!/bin/sh

if [ -z $XDG_CONFIG_HOME ]; then
    mkdir -p $HOME/.config
    export $XDG_CONFIG_HOME=$HOME/.config
fi

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

# If there isnt wallpaper in cache select a random one
if [[ ! -f "$cache_file" || ! -s "$cache_file" ]]; then

    random_image=$(find $wallpaper_dir -type f -name "*.jpg" | shuf -n 1)
    # If there isnt wallpapers end program
    if [ -z $random_image ]; then 
        echo "There is not wallpaper in '$wallpaper_dir': $wallpaper_dir"
        echo "==> Exiting..."
        exit 1
    fi

    echo ":: Setting wallpaper with random image"
    echo "$random_image" > "$cache_file"
fi


# ----------------------------------------------------- 
# Get selected wallpaper
# ----------------------------------------------------- 

if [[ -z $1 || $1 == "init" ]] ;then
    wallpaper=$(cat $cache_file)
else
    wallpaper=$1
fi
used_wallpaper=$wallpaper
echo ":: Setting wallpaper with original image $wallpaper"

# ----------------------------------------------------- 
# Copy path of current wallpaper to cache file
# ----------------------------------------------------- 
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
# Write hyprpaper.conf
# -----------------------------------------------------
if [[ $1 == "init" ]]; then
    echo ":: Setting wallpaper with $used_wallpaper"
    killall -e hyprpaper & > /dev/null 2<&1
    sleep 1; 
    wal_tpl=$(cat $XDG_CONFIG_HOME/hypr/hyprpaper.tpl)
    output=${wal_tpl//WALLPAPER/$used_wallpaper}
    echo "$output" > $XDG_CONFIG_HOME/hypr/hyprpaper.conf
    hyprpaper & > /dev/null 2>&1
fi

# ----------------------------------------------------- 
# Reload Waybar
# -----------------------------------------------------
sh ~/dotfiles/waybar/launch.sh &> /dev/null

# ----------------------------------------------------- 
# Create rasi file
# ----------------------------------------------------- 
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
fi
echo "* { current-image: url(\"$blurred_wallpaper\", height); }" > "$rasi_file"

exit 0