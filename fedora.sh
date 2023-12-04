###################################
# post-install scripts for Fedora #
###################################

# remove random apps
sudo dnf remove yelp gnome-maps mediawriter cheese gnome-tour rhythmbox simple-scan gnome-connections

# remove extensoes do sistema
sudo dnf remove gnome-shell-extension-background-logo gnome-classic-session

# instala extensoes do gnome basicas
sudo dnf install gnome-shell-extension-appindicator gnome-shell-extension-caffeine gnome-shell-extension-dash-to-dock gnome-shell-extension-gsconnect gnome-shell-extension-pop-shell gnome-shell-extension-user-theme
sudo dnf remove gnome-extensions-app

# instala apps basicos
sudo dnf install google-chrome gnome-tweaks htop nvidia-driver

# instala alguns flatpaks
sudo flatpak install com.mattjakeman.ExtensionManager com.Spotify.Client it.mijorus.gearlever

# customizaçao basica dos temas

## tema adw-gtk
sudo dnf install adw-gtk3-theme
gsettings set org.gnome.desktop.interface gtk-theme "Adw-gtk3-dark"

## cursor bibata translucent
git clone https://github.com/Silicasandwhich/Bibata_Cursor_Translucent
cd Bibata_Cursor_Translucent
sudo ./Installer_Bibata.sh
cd
gsettings set org.gnome.desktop.interface cursor-theme 'Bibata_Ghost'
rm -r Bibata_Cursor_Translucent

# altera o layout do touchpad
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'areas'
