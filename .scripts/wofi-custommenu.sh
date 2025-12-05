#!/bin/bash

entries="\t  Bluetooth\n\t 󰘊 Wifi\n\t 󰖀 Sound\n\t  Process-Admin"

selected=$(echo -e $entries|wofi --conf ~/.config/wofi/custommenu/custommenu-config --style ~/.config/wofi/custommenu/custommenu.css | awk '{print tolower($2)}')

case $selected in
  bluetooth)
    kitty bluetuith & sleep 0.1348 ; ./.scripts/resize.sh 439 149&hyprctl dispatch setfloating&&hyprctl dispatch moveactive exact 11 41 ;;
  wifi)
      kitty -e bash -c 'sleep 0.1348;nmtui'& sleep 0.1348 ; ./.scripts/resize.sh 683 495&hyprctl dispatch setfloating&&hyprctl dispatch moveactive exact 11 41;;
  sound)
      pavucontrol & sleep 0.1348 ; ./.scripts/resize.sh 566 449&hyprctl dispatch setfloating&&hyprctl dispatch moveactive exact 11 41 ;;
  process-admin)
    kitty btop & sleep 0.1348 ; ./.scripts/resize.sh 698 481&hyprctl dispatch setfloating&&hyprctl dispatch moveactive exact 11 41 ;;
esac

