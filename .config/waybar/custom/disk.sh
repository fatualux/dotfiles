#!/bin/bash

# HOME partition usage, in human-readable format
home_usage=$(df -h /home)

# ROOT partition usage, in human-readable format
root_usage=$(df -h /)

# Display disk usage using a Zenity progress dialog
yad --title="Disk Usage" --text="HOME Partition:\n\n$home_usage\n\nROOT Partition:\n\n$root_usage"
