#!/bin/bash

THIS_SCRIPT="$(readlink -f "${BASH_SOURCE[0]}")"

BACKGROUND_DIR="$HOME/.config/sway/wallz"

BACKGROUND_LIST=("$BACKGROUND_DIR"/*)
echo "Background list: ${BACKGROUND_LIST[@]}"

CURRENT_INDEX_FILE="$HOME/.config/sway/.current_wallpaper_index"

cycle_wallpaper() {
    # Read the current index from the file, or start at 0 if the file doesn't exist
    if [[ -f "$CURRENT_INDEX_FILE" ]]; then
        CURRENT_INDEX=$(cat "$CURRENT_INDEX_FILE")
    else
        CURRENT_INDEX=0
    fi

    echo "Current index: $CURRENT_INDEX"

    NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#BACKGROUND_LIST[@]} ))
    echo "Next index: $NEXT_INDEX"

    NEXT_BACKGROUND="${BACKGROUND_LIST[$NEXT_INDEX]}"
    echo "Next background: $NEXT_BACKGROUND"

    killall swaybg
    swaybg --output '*' --mode fill --image "$NEXT_BACKGROUND" &

    sed -i "s|^output \* bg .* fill|output \* bg $NEXT_BACKGROUND fill|" "$HOME/.config/sway/config"

    echo $NEXT_INDEX > "$CURRENT_INDEX_FILE"

}

while true; do
    echo "Cycling wallpaper..."
    killall -f $THIS_SCRIPT
    cycle_wallpaper
    sleep 90
done
