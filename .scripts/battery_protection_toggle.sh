#!/bin/bash

status=$(ipman --status | cut --delimiter=" " --fields=3 | cut --characters=1 | awk '{print tolower($1)}')

if [[ $status != "e" ]]; then
    pkexec ipman --enable
    notify-send -e -u low "Battery Protection Mode Enabled"
else 
    pkexec ipman --disable
    notify-send -e -u low "Battery Protection Mode Disabled"
fi
