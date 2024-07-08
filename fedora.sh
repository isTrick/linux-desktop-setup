#!/bin/bash

# remove random packages
dnf remove yelp gnome-maps mediawriter cheese gnome-tour rhythmbox simple-scan gnome-connections

# remove extensoes do sistema
dnf remove gnome-shell-extension-background-logo gnome-classic-session gnome-extensions-app

# instala extensoes do gnome basicas
dnf install gnome-shell-extension-appindicator gnome-shell-extension-caffeine gnome-shell-extension-dash-to-dock gnome-shell-extension-user-theme

# instala apps basicos
dnf install gnome-tweaks

# tema adw-gtk
dnf install adw-gtk3-theme
gsettings set org.gnome.desktop.interface gtk-theme "Adw-gtk3-dark"

# TODO #
# snaps setup
# Yaru theme
