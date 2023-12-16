#!/usr/bin/env bash

run_waybar() {
    waybar -c ~/.config/waybar/config  -s ~/.config/waybar/style.css
}

restart_waybar() {
    pid=$(pgrep waybar)
    for i in $pid; do
        kill $i
    done
    if [ -z "$pid" ]; then
        run_waybar
    fi
}

restart_waybar
