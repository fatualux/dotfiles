#!/bin/bash

# Get GPU load percentage
GPU_LOAD=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)

# Define color thresholds
LOW_LOAD_THRESHOLD=30
MEDIUM_LOAD_THRESHOLD=60

# Set default color
COLOR="#00FF00"  # Green

# Check load range and update color accordingly
if [ "$GPU_LOAD" -gt "$MEDIUM_LOAD_THRESHOLD" ]; then
    COLOR="#FFA500"  # Orange
fi

if [ "$GPU_LOAD" -gt "$LOW_LOAD_THRESHOLD" ]; then
    COLOR="#FFFF00"  # Yellow
fi

# Output the color
echo "$COLOR"
