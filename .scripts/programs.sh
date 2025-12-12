#!/bin/bash
if [ ! -f ~/.config/programlist ]; then
    touch ~/.config/programlist
fi

pacman -Qe > ~/.config/programlist
        
