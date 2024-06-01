#!/bin/bash

# this script in a variable
THIS_SCRIPT="$(readlink -f "${BASH_SOURCE[0]}")"

# Set the directory where the backgrounds are stored
BACKGROUND_DIR="$HOME/.config/sway/wallz"

# Get the list of backgrounds
BACKGROUND_LIST=("$BACKGROUND_DIR"/*)
echo "Background list: ${BACKGROUND_LIST[@]}"

# File to store the current index
CURRENT_INDEX_FILE="$HOME/.config/sway/.current_wallpaper_index"

# Function to cycle to the next wallpaper
cycle_wallpaper() {
    # Read the current index from the file, or start at 0 if the file doesn't exist
    if [[ -f "$CURRENT_INDEX_FILE" ]]; then
        CURRENT_INDEX=$(cat "$CURRENT_INDEX_FILE")
    else
        CURRENT_INDEX=0
    fi

    echo "Current index: $CURRENT_INDEX"

    # Calculate the index of the next background
    NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#BACKGROUND_LIST[@]} ))
    echo "Next index: $NEXT_INDEX"

    # Get the path of the next background
    NEXT_BACKGROUND="${BACKGROUND_LIST[$NEXT_INDEX]}"
    echo "Next background: $NEXT_BACKGROUND"

    # Set the background to the next background
    # fade to black
    killall swaybg
    swaybg --output '*' --mode fill --image "$NEXT_BACKGROUND" &

    # Save the current background in the sway config file
    sed -i "s|^output \* bg .* fill|output \* bg $NEXT_BACKGROUND fill|" "$HOME/.config/sway/config"

    # Save the next index to the file
    echo $NEXT_INDEX > "$CURRENT_INDEX_FILE"

    # Send a notification with the new background name with an icon from the current background
    # dunstify -i "$NEXT_BACKGROUND" "Background changed" "$(basename "$NEXT_BACKGROUND")"
}

# Infinite loop to cycle wallpapers every 90 seconds
while true; do
    echo "Cycling wallpaper..."
    killall -f $THIS_SCRIPT
    cycle_wallpaper
    sleep 90
done
