#!/usr/bin/env bash

# Configuration section: Customize these variables as needed
TITLE="${TITLE:-Menu}"                    # Yad dialog title
TEXT="${TEXT:-Action:}"                   # Yad dialog text
WIDTH=${WIDTH:-300}                       # Yad dialog width
HEIGHT=${HEIGHT:-200}                     # Yad dialog height
enable_confirmation=${ENABLE_CONFIRMATIONS:-false}  # Enable user confirmation

# Associative array to define menu items and their corresponding commands
declare -A menu
menu=(
  [Shutdown]="systemctl poweroff"
  [Reboot]="systemctl reboot"
  [Hibernate]="systemctl hibernate"
  [Logout]="swaymsg exit"
)

# Menu entries that require confirmation
menu_confirm="Shutdown Reboot Hibernate Suspend Halt Logout"

# Function to ask for user confirmation using Yad
ask_confirmation() {
  yad --question --text "Are you sure you want to ${selection,,}?"
  confirmed=$?
  echo "Confirmation status: ${confirmed}"
  if [ "${confirmed}" == 0 ]; then
    command="${menu[${selection%%|}]}"  # Remove trailing "|"
    echo "Executing: ${command}"
    ${command}
  else
    echo "User canceled."
  fi
}

# Display the menu and get the user's selection
selection=$(for item in "${!menu[@]}"; do echo "$item"; done | yad --list --title="${TITLE}" --text="${TEXT}" --width=${WIDTH} --height=${HEIGHT} --column=Options --height=200 --width=300)

# Process the user's selection
echo "Selected option: ${selection}"
if [ ! -z "${selection}" ]; then
  if [[ "${enable_confirmation}" = true && \
        ${menu_confirm} =~ (^|[[:space:]])"${selection}"($|[[:space:]]) ]]; then
    echo "Confirmation required."
    ask_confirmation
  else
    command="${menu[${selection%%|}]}"  # Remove trailing "|"
    echo "Executing: ${command}"
    ${command}
  fi
fi
