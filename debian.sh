#!/bin/bash

# You need to run this script as root. Use "su -".
adduser $USER sudo

# setup non-free repositories and update the system
add-apt-repository contrib non-free non-free-firmware -y
apt update -y && apt upgrade -y

# purge pre installed packages
apt purge evolution \
simple-scan \
gnome-maps \
gnome-contacts \
cheese \
totem \
yelp \
rhythmbox \
shotwell \
gnome-games \
gnome-music \
seahorse \
gnome-characters \
gnome-sound-recorder \
transmission-gtk \
gnome-system-monitor \
libreoffice-common \
firefox-esr -y

apt autoremove -y

# install basic packages
apt install git wget curl vim bash-completion -y

# flatpak and flathub setup
apt install flatpak gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# snaps setup
apt install snapd gnome-software-plugin-snap -y
systectl enable snapd

# basic gnome extensions
apt install gnome-shell-extension-appindicator \
gnome-shell-extension-caffeine \
gnome-shell-extension-dashtodock \
gnome-shell-extension-gsconnect -y

# themes configuration

wget https://github.com/lassekongo83/adw-gtk3/releases/download/v5.3/adw-gtk3v5.3.tar.xz
mv adw-gtk3v5.3.tar.xz /usr/share/themes && cd /usr/share/themes
tar xf adw-gtk3v5.3.tar.xz
rm adw-gtk3v5.3.tar.xz
cd

flatpak install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark

gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# bibata cursor 
git clone https://github.com/Silicasandwhich/Bibata_Cursor_Translucent
./Bibata_Cursor_Translucent/Installer_Bibata.sh
rm -rf Bibata_Cursor_Translucent

## flatpak theme setup
flatpak override --filesystem=$HOME/.icons
flatpak override --filesystem=$HOME/.themes
# sudo flatpak override --env=ICON_THEME=<your cursor>
# sudo flatpak override --env=GTK_THEME=<your gtk theme>
