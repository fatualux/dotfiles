#!/bin/bash

# Get GPU information
GPU_NAME=$(nvidia-smi --query-gpu=name --format=csv,noheader,nounits)
GPU_LOAD=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | sed 's/%//')
GPU_TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits | awk '{printf("%d°C", $1)}')

# Set default class
GPU_CLASS="custom-gpu"

# Set class based on GPU load
if [ "$GPU_LOAD" -ge 75 ]; then
  GPU_CLASS="${GPU_CLASS}.critical"
elif [ "$GPU_LOAD" -ge 50 ]; then
  GPU_CLASS="${GPU_CLASS}.warning"
fi

# Print the GPU information with class
echo "$GPU_NAME - Load: $GPU_LOAD% - Temp: $GPU_TEMP"
