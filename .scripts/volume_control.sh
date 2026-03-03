#!/bin/bash

function volume_up {
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "$1"+
}

function volume_down() {
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "$1"-
}

function toggle_mute() {
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
}

case "$1" in
    "up") volume_up "$2" 
    ;;
"down") volume_down "$2"
    ;;
"toggle-mute") toggle_mute
    ;;
esac

