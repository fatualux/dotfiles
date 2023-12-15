#!/bin/bash

pkill -SIGINT wf-recorder && dunstify ' screen cap ended'
sleep .1

# send signal to update monitor
pkill -RTMIN+8 waybar
