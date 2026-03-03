#!/bin/bash

(killall hypridle && notify-send -e -u low "Hypridle toggled off") || (hypridle & notify-send -e -u low "Hypridle toggled on")
