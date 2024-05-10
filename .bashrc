#!/bin/bash

SourceConfigDir() {
  directory="$1"
  directory_splat="$HOME/.bash/$directory/*"
  if [ -d "$HOME/.bash/$directory" ]; then
    for config_file in $directory_splat; do
      source "$config_file"
    done
  else
    echo "No $HOME/.bash/$directory/*"
  fi
}

SourceConfigDir 'config'
