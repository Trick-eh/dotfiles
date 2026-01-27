#! /bin/bash

if pgrep -x "wlogout" >/dev/null; then
    killall wlogout
else
    wlogout -P 0
fi    
