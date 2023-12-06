###################################
# post-install scripts for Fedora #
###################################

# remove random packages
sudo dnf remove yelp gnome-maps mediawriter cheese gnome-tour rhythmbox simple-scan gnome-connections

# remove extensoes do sistema
sudo dnf remove gnome-shell-extension-background-logo gnome-classic-session gnome-extensions-app

# instala extensoes do gnome basicas
sudo dnf install gnome-shell-extension-appindicator gnome-shell-extension-caffeine gnome-shell-extension-dash-to-dock gnome-shell-extension-user-theme

# instala apps basicos
sudo dnf install google-chrome-stable gnome-tweaks nvidia-driver pycharm-community cava epiphany

# instala alguns flatpaks
flatpak install com.mattjakeman.ExtensionManager it.mijorus.gearlever com.raggesilver.BlackBox # configurações
flatpak install de.haeckerfelix.Fragments com.github.tenderowl.frog com.github.finefindus.eyedropper # utilitários
flatpak install com.Spotify.Client io.bassi.Amberol com.obsproject.Studio # mídia
flatpak install io.gitlab.idevecore.Pomodoro com.todoist.Todoist # produtividade
flatpak install org.ferdium.Ferdium io.github.mimbrero.WhatsAppDesktop org.telegram.desktop com.protonvpn.www  # internet
flatpak install io.podman_desktop.PodmanDesktop org.gnome.Builder # desenvolvimento

# customizaçao basica dos temas

## tema adw-gtk
sudo dnf install adw-gtk3-theme
gsettings set org.gnome.desktop.interface gtk-theme "Adw-gtk3-dark"

## cursor bibata translucent
git clone https://github.com/Silicasandwhich/Bibata_Cursor_Translucent
sudo ./Bibata_Cursor_Translucent/Installer_Bibata.sh
gsettings set org.gnome.desktop.interface cursor-theme 'Bibata_Ghost'
rm -r Bibata_Cursor_Translucent

## tema de icones MoreWaita
git clone https://github.com/somepaulo/MoreWaita.git
sudo ./MoreWaita/install.sh
gsettings set org.gnome.desktop.interface icon-theme 'MoreWaita'
rm -r MoreWaita

