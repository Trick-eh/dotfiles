#!/bin/bash

HYPR_CONFIG_DIR="$HOME/.config/hypr"

TOUCHPAD_CONFIG="touchpad.conf"

CONFIG_FILE="$HYPR_CONFIG_DIR/devices/$TOUCHPAD_CONFIG"

enabled=$(grep -o "enabled\s*=\s*[01]" "$CONFIG_FILE")

if [ "$enabled" == "enabled = 0" ]; then

    sed -i "s/enabled\s*=\s*0/enabled = 1/" "$CONFIG_FILE"
    state="enabled"

else

    sed -i "s/enabled\s*=\s*1/enabled = 0/" "$CONFIG_FILE"
    state="disabled"

fi

# Reload the settings in Hyprland

hyprctl reload

# Display notification based on touchpad state

if [ "$state" == "enabled" ]; then

    notify-send -u low "Touchpad Enabled" 

else

    notify-send -u low "Touchpad Disabled" 

fi

echo "Touchpad state toggled." 

