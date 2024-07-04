#!/bin/sh
#                _ _                              
# __      ____ _| | |_ __   __ _ _ __   ___ _ __  
# \ \ /\ / / _` | | | '_ \ / _` | '_ \ / _ \ '__| 
#  \ V  V / (_| | | | |_) | (_| | |_) |  __/ |    
#   \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___|_|    
#                   |_|         |_|               
#  
# ----------------------------------------------------- 

#wallpaper dir

# Cache file for holding the current wallpaper
wallpaper_dir="$HOME/wallpaper/desktop_bg"
if [ -f ~/dotfiles/.settings/wallpaper-folder.sh ] ;then
    source ~/dotfiles/.settings/wallpaper-folder.sh
fi
used_wallpaper="$HOME/.cache/used_wallpaper"
cache_file="$HOME/.cache/current_wallpaper"
blurred="$HOME/.cache/blurred_wallpaper.png"
square="$HOME/.cache/square_wallpaper.png"
rasi_file="$HOME/.cache/current_wallpaper.rasi"


# Create cache file if not exists
if [ ! -f $cache_file ] ;then
    touch $cache_file
    echo "$HOME/wallpaper/default.jpg" > "$cache_file"
fi

#Create rasi file if not exists
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    echo "* { current-image: url(\"$HOME/wallpaper/default.jpg\", height); }" > "$rasi_file"
fi

current_wallpaper=$(cat "$cache_file")

wallpaper="$current_wallpaper"

case $1 in

    # Load wallpaper from .cache of last session 
    "init")
        sleep 1
        if [ -f $cache_file ]; then
            exit #wal -q -i $current_wallpaper
        else
            exit #wal -q -i $wallpaper_dir/
        fi
    ;;
    
    # Select wallpaper with rofi
    "select")
        sleep 0.2
        selected=$( find "$wallpaper_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read rfile
        do
            echo -en "$rfile\x00icon\x1f$wallpaper_dir/${rfile}\n"
        done | rofi -dmenu -i -replace -config ~/.config/rofi/config_wallpaper.rasi)
        if [ ! "$selected" ]; then
            echo "No wallpaper selected"
            exit
        fi

        wallpaper="$wallpaper_dir/$selected"
        #wal -q -i $wallpaper_dir/$selected

    ;;


    # Randomly select wallpaper 
    *)
        #wal -q -i ~/wallpaper/
    ;;

esac
# ----------------------------------------------------- 
# Load current pywal color scheme
# ----------------------------------------------------- 
#source "$HOME/.cache/wal/colors.sh"
echo ":: Wallpaper: $wallpaper"

# ----------------------------------------------------- 
# get wallpaper image name
# ----------------------------------------------------- 
newwall=$(echo $wallpaper | sed "s|$HOME/wallpaper/desktop_bg/||g")
echo ":: New Wallpaper: $newwall"

# ----------------------------------------------------- 
# Set the new wallpaper
# -----------------------------------------------------

cp $wallpaper $HOME/.cache/
mv $HOME/.cache/$newwall $used_wallpaper

# hyprpaper
echo ":: Using hyprpaper"
killall hyprpaper
wal_tpl=$(cat $HOME/.config/hypr/hyprpaper.tpl)
output=${wal_tpl//WALLPAPER/$used_wallpaper}
echo "$output" > $HOME/.config/hypr/hyprpaper.conf
hyprpaper &


# ----------------------------------------------------- 
# Created blurred wallpaper
# -----------------------------------------------------
if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    dunstify "Creating blurred version ..." "with image $newwall" -h int:value:50 -h string:x-dunst-stack-tag:wallpaper
fi

magick $used_wallpaper -resize 75% $blurred
echo ":: Resized to 75%"
if [ ! "$blur" == "0x0" ] ;then
    magick $blurred -blur $blur $blurred
    echo ":: Blurred"
fi

# ----------------------------------------------------- 
# Created quare wallpaper
# -----------------------------------------------------
if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    dunstify "Creating square version ..." "with image $newwall" -h int:value:75 -h string:x-dunst-stack-tag:wallpaper
fi
magick $wallpaper -gravity Center -extent 1:1 $square
echo ":: Square version created"



# ----------------------------------------------------- 
# Write selected wallpaper into .cache files
# ----------------------------------------------------- 
echo "$wallpaper" > "$cache_file"
echo "* { current-image: url(\"$blurred\", height); }" > "$rasi_file"


# ----------------------------------------------------- 
# Send notification
# ----------------------------------------------------- 

if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    dunstify "Wallpaper procedure complete!" "with image $newwall" -h int:value:100 -h string:x-dunst-stack-tag:wallpaper
fi

echo "DONE!"


exit 0
