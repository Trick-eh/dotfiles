#!/bin/bash

entries="\t ⇠ Logout\n\t  ⏾ Suspend\n\t  ⭮ Reboot\n\t  ⏻ Shutdown"

selected=$(echo -e $entries|wofi --conf ~/.config/wofi/custommenu/powermenu-config --style ~/.config/wofi/custommenu/custommenu.css | awk '{print tolower($2)}')

case $selected in
  logout)
    killall Hyprland;;
  suspend)
    systemctl suspend;;
  reboot)
    reboot;;
  shutdown)
    shutdown -h now;;
esac
