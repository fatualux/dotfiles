#!/usr/bin/env bash

run_waybar() {
    waybar -c ~/.config/waybar/config  -s ~/.config/waybar/style.css
}

waybar_active() {
    pid=$(pidof waybar)a
    if [ -z "$pid" ]; then
        return 1
    fi
    return 0
}

restart_waybar() {
  if waybar_active; then
    for i in $pid; do
        kill $i
    done
    if [ -z "$pid" ]; then
        run_waybar
    fi
  else
    run_waybar
  fi
}

restart_waybar
