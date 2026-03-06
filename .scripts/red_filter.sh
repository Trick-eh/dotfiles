#!/bin/bash

if [ $(pgrep hyprsunset) ] ; then
    killall hyprsunset
else
    hyprsunset -t $1 &
fi
