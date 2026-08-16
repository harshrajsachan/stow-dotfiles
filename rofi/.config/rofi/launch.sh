#!/usr/bin/env bash

set -e

ROFI_DIR="$HOME/.config/rofi"

CONFIG="$ROFI_DIR/rofi.conf"
STYLE="$ROFI_DIR/style-6.rasi"

THEMES_DIR="$HOME/.config/themes"
CURRENT="$THEMES_DIR/current"

THEMES=(
    "berserk"
    "catppuccin"
    "everforest"
    "gruvbox"
    "nord"
    "sakura"
    "twilight"
)

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

    if [[ -L "$CURRENT" ]]; then
        CURRENT_THEME="$(basename "$(readlink -f "$CURRENT")")"
    else
        CURRENT_THEME=""
    fi

    MENU=""

    for theme in "${THEMES[@]}"; do

        if [[ "$theme" == "$CURRENT_THEME" ]]; then
            MENU+="● $theme"
        else
            MENU+="  $theme"
        fi

        MENU+=$'\n'

    done

    printf '%s' "$MENU" |
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
