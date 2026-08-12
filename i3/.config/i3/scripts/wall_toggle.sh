#!/bin/bash

set -e

THEME_DIR="$HOME/.config/themes/current"
WALL_DIR="$THEME_DIR/wallpapers"
STATE="$HOME/.cache/theme_wall_index"
DEFAULT_FILE="$WALL_DIR/default"

mkdir -p "$HOME/.cache"

# --------------------------------------------------
# Resolve current theme
# --------------------------------------------------

CURRENT_THEME=$(readlink -f "$THEME_DIR")

if [[ -z "$CURRENT_THEME" || ! -d "$CURRENT_THEME" ]]; then
    echo "Current theme not found: $THEME_DIR"
    exit 1
fi

# --------------------------------------------------
# Apply default wallpaper
# --------------------------------------------------

apply_default() {

    if [[ ! -f "$DEFAULT_FILE" ]]; then
        echo "Default wallpaper file not found:"
        echo "  $DEFAULT_FILE"
        exit 1
    fi

    DEFAULT_NAME=$(<"$DEFAULT_FILE")

    # Remove accidental whitespace/newline
    DEFAULT_NAME="${DEFAULT_NAME//$'\r'/}"
    DEFAULT_NAME="${DEFAULT_NAME#"${DEFAULT_NAME%%[![:space:]]*}"}"
    DEFAULT_NAME="${DEFAULT_NAME%"${DEFAULT_NAME##*[![:space:]]}"}"

    DEFAULT_WALL="$WALL_DIR/$DEFAULT_NAME"

    if [[ ! -f "$DEFAULT_WALL" ]]; then
        echo "Default wallpaper not found:"
        echo "  $DEFAULT_WALL"
        exit 1
    fi

    feh --bg-fill "$DEFAULT_WALL"

    echo "Default wallpaper:"
    echo "  $DEFAULT_NAME"
}

# --------------------------------------------------
# Explicit default command
# --------------------------------------------------

if [[ "$1" == "default" ]]; then
    apply_default

    # Reset toggle index for this theme
    {
        echo "$CURRENT_THEME"
        echo "0"
    } >"$STATE"

    exit 0
fi

# --------------------------------------------------
# Find wallpapers
# --------------------------------------------------

mapfile -t WALLPAPERS < <(
    find "$WALL_DIR" -maxdepth 1 -type f \
        \( \
        -iname "*.jpg" \
        -o -iname "*.jpeg" \
        -o -iname "*.png" \
        -o -iname "*.webp" \
        \) |
        sort
)

COUNT=${#WALLPAPERS[@]}

if ((COUNT == 0)); then
    echo "No wallpapers found in:"
    echo "  $WALL_DIR"
    exit 1
fi

# --------------------------------------------------
# Read previous state
# --------------------------------------------------

THEME_CHANGED=false
INDEX=0

if [[ -f "$STATE" ]]; then

    STATE_THEME=$(sed -n '1p' "$STATE")
    STORED_INDEX=$(sed -n '2p' "$STATE")

    if [[ "$STATE_THEME" == "$CURRENT_THEME" ]]; then

        if [[ "$STORED_INDEX" =~ ^[0-9]+$ ]]; then
            INDEX=$STORED_INDEX
        fi

    else
        # Theme changed
        THEME_CHANGED=true
        INDEX=0
    fi

fi

# --------------------------------------------------
# New theme → use default wallpaper
# --------------------------------------------------

if [[ "$THEME_CHANGED" == true ]]; then

    echo "Theme changed:"
    echo "  $CURRENT_THEME"

    apply_default

    # First toggle after default starts from wallpaper 0
    {
        echo "$CURRENT_THEME"
        echo "0"
    } >"$STATE"

    exit 0
fi

# --------------------------------------------------
# Normalize index
# --------------------------------------------------

INDEX=$((INDEX % COUNT))

# --------------------------------------------------
# Apply wallpaper
# --------------------------------------------------

CURRENT_WALL="${WALLPAPERS[$INDEX]}"

feh --bg-fill "$CURRENT_WALL"

echo "Wallpaper:"
echo "  $(basename "$CURRENT_WALL")"

# --------------------------------------------------
# Save next index
# --------------------------------------------------

NEXT_INDEX=$(((INDEX + 1) % COUNT))

{
    echo "$CURRENT_THEME"
    echo "$NEXT_INDEX"
} >"$STATE"
