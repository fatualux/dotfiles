#!/bin/bash

# Function to check if iio-sensor-proxy service is active
wait_for_service() {
    while ! systemctl is-active --quiet iio-sensor-proxy; do
        sleep 1
    done
}

# Get the name of the currently focused output
output_name=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
if [ -z "$output_name" ]; then
    echo "Error: Could not determine the output name."
    exit 1
fi

# Function to get the current orientation from the sensor
get_orientation() {
    gdbus call --system --dest net.hadess.SensorProxy --object-path /net/hadess/SensorProxy --method org.freedesktop.DBus.Properties.Get net.hadess.SensorProxy AccelerometerOrientation | awk -F '"' '{print $2}'
}

# Function to rotate screen based on orientation
rotate_screen() {
    local orientation=$1
    case "$orientation" in
        normal)
            dunstify -a "Auto-rotate" "Normal"
            swaymsg output $output_name transform normal
            ;;
        inverted)
            dunstify -a "Auto-rotate" "Inverted"
            swaymsg output $output_name transform 180
            ;;
        left-up)
            dunstify -a "Auto-rotate" "Left-up"
            swaymsg output $output_name transform 270
            ;;
        right-up)
            dunstify -a "Auto-rotate" "Right-up"
            swaymsg output $output_name transform 90
            ;;
        *)
            echo "Unknown orientation: $orientation"
            ;;
    esac
}

# Wait for the iio-sensor-proxy service to start
wait_for_service

# Loop indefinitely, checking the orientation and rotating the screen accordingly
while true; do
    orientation=$(get_orientation)
    if [ -z "$orientation" ]; then
        echo "Error: Could not get the orientation."
        sleep 1
        continue
    fi
    rotate_screen "$orientation"
    sleep 1
done
