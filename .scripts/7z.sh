#!/bin/bash

# Function to display an error message and exit
function display_error() {
  zenity --error --text="$1"
  exit 1
}

# Get the operation type from the user
operation=$(zenity --list --title="7zip GUI" --column="Operation" "Compress" "Extract")

# Get the archive name
archive_name=$(zenity --file-selection --title="Select Archive Name")

# Ask the user if they want to create a new archive or add to an existing one
archive_operation=$(zenity --list --title="Archive Operation" --column="Operation" "Create New Archive" "Add to Existing Archive")

if [ "$archive_operation" == "Create New Archive" ]; then
  # For compression, get compression method and level
  if [ "$operation" == "Compress" ]; then
    compression_method=$(zenity --list --title="Compression Method" --column="Method" "zip" "tar" "tar.gz" "tar.bz2" "7z")
    compression_level=$(zenity --scale --title="Compression Level" --min-value=1 --max-value=9 --value=5 --step=1)

    # Get file names
    file_names=$(zenity --file-selection --multiple --title="Select Files")
    
    # Compress the files
    7z a -m
