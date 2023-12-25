#!/bin/bash

# Get GPU information
GPU_NAME=$(nvidia-smi --query-gpu=name --format=csv,noheader,nounits)
GPU_LOAD=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | sed 's/%//')
GPU_TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits | awk '{printf("%d°C", $1)}')

# Define color thresholds
LOW_LOAD_THRESHOLD=30
MEDIUM_LOAD_THRESHOLD=60

# Set default color
COLOR_GREEN="\e[92m"
COLOR_ORANGE="\e[33m"
COLOR_YELLOW="\e[93m"
COLOR_RESET="\e[0m"

# Initialize color variable
COLOR=""

# Check load range and update color accordingly
if [ "${GPU_LOAD}" -gt "$MEDIUM_LOAD_THRESHOLD" ]; then
    COLOR="${COLOR_ORANGE}"  # Orange
fi

if [ "${GPU_LOAD}" -gt "$LOW_LOAD_THRESHOLD" ]; then
    COLOR="${COLOR_YELLOW}"  # Yellow
fi

# Output the information with color if applicable
if [ -n "${COLOR}" ]; then
    echo -e "${COLOR}${GPU_NAME} - Load: ${GPU_LOAD}% - Temp: ${GPU_TEMP}${COLOR_RESET}"
else
    echo "${GPU_NAME} - Load: ${GPU_LOAD}% - Temp: ${GPU_TEMP}"
fi
