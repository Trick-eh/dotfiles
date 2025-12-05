#!/bin/bash
sda1="/dev/sda1"
KingstonUSB="/run/media/trickk/Kingston-USB"
if [ -e "$sda1" ]; then
    if [ ! -d "$KingstonUSB" ]; then
        sudo mkdir -p "${KingstonUSB}"
        sudo mount /dev/sda1 "${KingstonUSB}"
    else
        sudo umount "${KingstonUSB}"
        sudo rmdir "${KingstonUSB}"
    fi
fi

