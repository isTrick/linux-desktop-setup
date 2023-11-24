###############################
# Debian post-install scripts #
###############################

# add patrickg to sudoers file
su -
adduser patrickg sudo
reboot


# purge random apps and install essential packages
sudo add-apt-repository contrib non-free-firmware
sudo apt update -y
sudo apt upgrade -y
sudo apt purge evolution simple-scan gnome-maps gnome-contacts cheese totem yelp rhythmbox shotwell gnome-games -y


sudo apt install git wget curl build-essential docker htop neofetch nvidia-driver tlp -y
sudo apt purge imagemagick imagemagick-6.q16 -y
sudo apt autoremove -y
sudo tlp start

cd Downloads
wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
wget https://download.virtualbox.org/virtualbox/7.0.12/virtualbox-7.0_7.0.12-159484~Debian~bookworm_amd64.deb
ls
sudo apt install ./<file>.deb
cd
mkdir appimage
cd appimage
wget https://anytype-release.fra1.cdn.digitaloceanspaces.com/Anytype-0.36.0.AppImage

# configura o flathub e instala alguns flatpaks
sudo apt install flatpak gnome-software-plugin-flatpak -y

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install com.mattjakeman.ExtensionManager
flatpak install com.spotify.Client
flatpak install org.gnome.Boxes
flatpak install com.usebottles.bottles
flatpak install io.github.jliljebl.Flowblade
flatpak install flathub com.discordapp.Discord
flatpak install flathub com.google.Chrome
flatpak install flathub org.videolan.VLC
flatpak install flathub com.obsproject.Studio
flatpak install flathub io.github.mimbrero.WhatsAppDesktop
flatpak install flathub org.onlyoffice.desktopeditors
flatpak install flathub com.github.micahflee.torbrowser-launcher
flatpak install flathub org.kde.krita
flatpak install flathub fr.handbrake.ghb
flatpak install flathub org.filezillaproject.Filezilla
flatpak install flathub com.github.tenderowl.frog
flatpak install it.mijorus.gearlever
flatpak install com.microsoft.Edge
flatpak install org.audacityteam.Audacity
flatpak install org.kde.kdenlive

# instala algumas extensôes do Gnome
sudo apt install gnome-shell-extension-appindicator gnome-shell-extension-arc-menu gnome-shell-extension-caffeine gnome-shell-extension-dash-to-panel gnome-shell-extension-dashtodock gnome-shell-extension-desktop-icons-ng gnome-shell-extension-gsconnect
sudo apt install gir1.2-gda-5.0 gir1.2-gsound-1.0 -y

# configura o tema Colloid, com o cursor bibata-translucent
git clone https://github.com/vinceliuice/Colloid-gtk-theme
cd Colloid-gtk-theme
./install.sh --libadwaita --tweaks float
./install.sh --libadwaita --tweaks nord float
./install.sh --libadwaita --tweaks black float --name Colloid-Black

https://github.com/vinceliuice/Colloid-icon-theme
cd Colloid-icon-theme
./install.sh
./install.sh -s nord
cd

git clone https://github.com/Silicasandwhich/Bibata_Cursor_Translucent
cd Bibata_Cursor_Translucent
./Installer_Bibata.sh
cd

sudo flatpak override --filesystem=$HOME/.icons
sudo flatpak override --filesystem=$HOME/.themes
sudo flatpak override --env=ICON_THEME=Bibata_Ghost
sudo flatpak override --env=GTK_THEME=Colloid_Dark

curl -s https://wallpapers.manishk.dev/install.sh | bash -s THEME_CODE

# configura oh-my-zsh com starship
sudo apt install zsh -y
chsh -s /bin/zsh
zsh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# plugins=(git zsh-autosuggestions zsh-syntax-highlighting debian python) ZSH_THEME="spaceship"
# Instalar fontes Ubuntu, Inconsolata e JetBrains (nerdfonts)


# Grub e Plymouth
sudo apt install grub-customizer -y

sudo mkdir /boot/grub/themes
cd /boot/grub/themes
sudo wget https://www.dropbox.com/s/4c672ec9sc8fu5k/themes.tar.gz
sudo tar -xvzf themes.tar.gz
sudo rm -fr themes.tar.gz

# Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian/ $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
