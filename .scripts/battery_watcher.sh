#!/bin/bash


function get_battery_percentage {
    echo $(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | awk '{print $2}' | cut --delimiter=% --field=1)
}

function get_battery_status {
    echo $(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state | awk '{print $2}')
}


while [ true ]; do

battery_status=$(get_battery_status)
battery_percentage=$(get_battery_percentage)

    case "$battery_status" in
        charging) 
            if [ "$battery_percentage" == "99"]; then
            notify-send -e -u normal "Battery fully charged" "Battery is at $battery_percentage%\nConsider turning on battery protection mode"
            sleep 1m
            fi
            ;;
        *) 
            if [ "$battery_percentage" == "5" ]; then
                notify-send -e -u normal "Battery is really low" "Battery is at $battery_percentage%"
            else if [ "$battery_percentage" == "10" ]; then
                notify-send -e -u critical "Battery is low" "Battery is at $battery_percentage%"
            else if [ "$battery_percentage" == "15" ]; then
                notify-send -e -u critical "Battery is running low" "Battery is at $battery_percentage%"
            fi
            fi
            fi
            sleep 1m
            ;;
    esac

done

