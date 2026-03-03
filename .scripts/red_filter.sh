#!/bin/bash

if [ $(pgrep hyprsunset) > 0 ] ; then
    killall hyprsunset
else
    hyprsunset -t $1 &
fi
