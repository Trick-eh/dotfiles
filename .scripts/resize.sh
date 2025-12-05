#!/bin/bash

current_size=$(hyprctl activewindow -j | jq -r '.size')
current_width=$(echo $current_size | jq -r '.[0]')
current_height=$(echo $current_size | jq -r '.[1]')
desired_width=$1 # 511
desired_height=$2 # 149
width=$((desired_width - current_width))
height=$((desired_height - current_height))

exec hyprctl dispatch resizeactive $width $height
