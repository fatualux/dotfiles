#!/bin/bash

swaymsg workspace stats
if [ "$1" == "cpu" ]; then
    alacritty -e "btop" "-s" "PERCENT_CPU"
    exit
fi

if [ "$1" == "memory" ]; then
    alacritty -e "btop" "-s" "M_RESIDENT"
    exit
fi

alacritty "btop"
exit
