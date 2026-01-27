#!/usr/bin/env bash
last_selection = $(wl-paste)
wofi-pass -c -i -s
if [ last_selection != $(wl-paste) ]; then
    notify-send "Password copied to clipboard" -t 3000 -e
    sleep 10 && cliphist delete-query $(cliphist decode $(cliphist list | head -n 1 | cut -f 1))
    printf "" | wl-copy
fi
