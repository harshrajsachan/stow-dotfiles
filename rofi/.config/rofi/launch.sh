#!/usr/bin/env bash

set -e

ROFI_DIR="$HOME/.config/rofi"

CONFIG="$ROFI_DIR/rofi.conf"
STYLE="$ROFI_DIR/style-6.rasi"

THEMES_DIR="$HOME/.config/themes"
CURRENT="$THEMES_DIR/current"

# ============================================================================
# Validate
# ============================================================================

if [[ ! -f "$CONFIG" ]]; then
    echo "Error: $CONFIG not found"
    exit 1
fi

if [[ ! -f "$STYLE" ]]; then
    echo "Error: $STYLE not found"
    exit 1
fi

if [[ ! -d "$THEMES_DIR" ]]; then
    echo "Error: $THEMES_DIR not found"
    exit 1
fi

# ============================================================================
# Application Launcher
# ============================================================================

app_launcher() {

    rofi \
        -show drun \
        -config "$CONFIG" \
        -theme "$STYLE"

}

# ============================================================================
# Theme Launcher
# ============================================================================

theme_launcher() {

    local current_theme=""
    local menu=""
    local theme_dir
    local theme

    # ------------------------------------------------------------------------
    # Get current theme
    # ------------------------------------------------------------------------

    if [[ -L "$CURRENT" ]]; then
        current_theme="$(basename "$(readlink -f "$CURRENT")")"
    fi

    # ------------------------------------------------------------------------
    # Find every theme directory automatically
    # ------------------------------------------------------------------------

    for theme_dir in "$THEMES_DIR"/*/; do

        [[ -d "$theme_dir" ]] || continue

        theme="$(basename "$theme_dir")"

        if [[ "$theme" == "$current_theme" ]]; then
            menu+="● $theme"
        else
            menu+="  $theme"
        fi

        menu+=$'\n'

    done

    # ------------------------------------------------------------------------
    # Launch Rofi
    # ------------------------------------------------------------------------

    printf '%s' "$menu" |
        rofi \
            -dmenu \
            -i \
            -no-custom \
            -p "Theme" \
            -config "$CONFIG" \
            -theme "$STYLE"

}

# ============================================================================
# Main
# ============================================================================

case "${1:-app}" in

app)
    app_launcher
    ;;

theme)
    theme_launcher
    ;;

*)
    echo "Usage:"
    echo "  $0 app"
    echo "  $0 theme"
    exit 1
    ;;

esac
