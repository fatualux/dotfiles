#!/bin/bash

function display_error() {
  zenity --error --text="$1"
  exit 1
}

action=$(zenity --list --title="7zip GUI" --column="Action" "Compress" "Extract")

if [ "$action" == "Compress" ]; then
  archive_operation=$(zenity --list --title="Archive Operation" --column="Operation" "Create New Archive" "Add to Existing Archive")
  if [ "$archive_operation" == "Create New Archive" ]; then
    archive_name=$(zenity --file-selection --save --title="Select New Archive Name")
    compression_method=$(zenity --list --title="Compression Method" --column="Method" "zip" "tar" "tar.gz" "tar.bz2" "7z")
    compression_level=$(zenity --scale --title="Compression Level" --min-value=1 --max-value=9 --value=5 --step=1)
    file_names=$(zenity --file-selection --multiple --title="Select Files")
    7z a -m${compression_method} -mx${compression_level} "${archive_name}" ${file_names} || display_error "Compression failed"
  elif [ "$archive_operation" == "Add to Existing Archive" ]; then
    archive_name=$(zenity --file-selection --title="Select Existing Archive")
    file_names=$(zenity --file-selection --multiple --title="Select Files to Add")
    7z u "${archive_name}" ${file_names} || display_error "Adding files failed"
  else
    display_error "Invalid Archive Operation"
  fi
elif [ "$action" == "Extract" ]; then
  # Ask to select the archive to extract
  archive_name=$(zenity --file-selection --title="Select Archive to Extract")

  # Get the output directory
  output_directory=$(zenity --file-selection --directory --title="Select Output Directory")

  # Extract the files
  7z x -o"${output_directory}" "${archive_name}" || display_error "Extraction failed"
else
  display_error "Invalid Action"
fi

zenity --info --text="Operation completed successfully"
