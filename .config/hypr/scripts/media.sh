#!/bin/bash

music_icon="$HOME/.config/swaync/icons/music.png"
media_id=28

# Play the next track
play_next() {
    playerctl next
    #show_music_notification
}

# Play the previous track
play_previous() {
    playerctl previous
    #show_music_notification
}

# Toggle play/pause
toggle_play_pause() {
    playerctl play-pause
    show_music_notification
}

# Stop playback
stop_playback() {
    # Just exec if is not currently stopped
    if [ $(playerctl status) != "Paused" ]; then
        playerctl stop
        notify-send -e -r $media_id -u low -i "$music_icon" "Playback Stopped"
    fi
}

# Display notification with song information
show_music_notification() {
    status=$(playerctl status)

    # Anti intuitive conf --> It takes the status before pressing the play-pause button
    if [[ "$status" == "Paused" ]]; then
        song_title=$(playerctl metadata title)
        song_artist=$(playerctl metadata artist)
        notify-send -e -r $media_id -u low -i "$music_icon" "Now Playing:" "$song_title\nby $song_artist"
    elif [[ "$status" == "Playing" ]]; then
        notify-send -e -r $media_id -u low -i "$music_icon" "Playback Paused"
    fi
}

# Get media control action from command line argument
case "$1" in
    "--nxt")
        play_next
        ;;
    "--prv")
        play_previous
        ;;
    "--pause")
        toggle_play_pause
        ;;
    "--stop")
        stop_playback
        ;;
    *)
        echo "Usage: $0 [--nxt|--prv|--pause|--stop]"
        exit 1
        ;;
esac
