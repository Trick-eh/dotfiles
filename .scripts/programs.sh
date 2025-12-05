#!/bin/bash
rm ~/.config/programlist
touch ~/.config/programlist 
pacman -Qe > ~/.config/programlist
        
