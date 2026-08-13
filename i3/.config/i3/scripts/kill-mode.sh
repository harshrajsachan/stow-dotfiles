#!/bin/bash

STATE="/tmp/ultra_mode"

start_services() {

    # Visual
    picom >/dev/null 2>&1 &
    dunst >/dev/null 2>&1 &
    redshift >/dev/null 2>&1 &
    clipmenud >/dev/null 2>&1 &

    # Polybar
    ~/.config/polybar/launch.sh >/dev/null 2>&1 &

    # Audio
    systemctl --user start pipewire.service
    systemctl --user start pipewire-pulse.service
    systemctl --user start wireplumber.service

    # Portals
    systemctl --user start xdg-desktop-portal.service
    systemctl --user start xdg-desktop-portal-gtk.service

    # Bluetooth
    sudo systemctl start bluetooth.service >/dev/null 2>&1

    # Wallpaper
    feh --bg-fill ~/Pictures/wallpaper.jpg >/dev/null 2>&1 &

    # Optional
    autotiling >/dev/null 2>&1 &
}

stop_services() {

    ######## Visual ########
    pkill polybar
    pkill picom
    pkill dunst
    pkill redshift
    pkill clipmenud
    pkill xss-lock

    ######## Wallpaper ########
    pkill feh
    pkill mpvpaper
    pkill xwinwrap

    ######## Audio ########
    systemctl --user stop pipewire.service
    systemctl --user stop pipewire-pulse.service
    systemctl --user stop wireplumber.service

    ######## Bluetooth ########
    sudo systemctl stop bluetooth.service >/dev/null 2>&1

    ######## Portals ########
    systemctl --user stop xdg-desktop-portal.service
    systemctl --user stop xdg-desktop-portal-gtk.service

    pkill xdg-desktop-portal
    pkill xdg-desktop-portal-gtk
    pkill xdg-document-portal

    ######## GVFS ########
    pkill gvfsd
    pkill gvfsd-fuse
    pkill gvfsd-metadata

    ######## Network Applets ########
    pkill nm-applet

    ######## Clipboard ########
    pkill clipmenud
    pkill greenclip
    pkill cliphist
    pkill parcellite

    ######## Misc ########
    pkill autotiling
    pkill btop

    ######## File Managers ########
    pkill pcmanfm
    pkill ranger

    ######## Background ########
    xsetroot -solid black
}

if [ ! -f "$STATE" ]; then
    touch "$STATE"
    stop_services
else
    rm -f "$STATE"
    start_services
fi
