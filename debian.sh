###############################
# Debian post-install scripts #
###############################

# add patrickg to sudoers file
su -
adduser patrickg sudo
reboot

# setup repositories and update the system
sudo add-apt-repository contrib non-free-firmware
sudo apt update -y
sudo apt upgrade -y

# purge pre installed packages
sudo apt purge evolution simple-scan gnome-maps gnome-contacts cheese totem yelp rhythmbox shotwell gnome-games -y
sudo apt autoremove -y

# install basic packages
sudo apt install git wget curl build-essential htop neofetch -y
sudo apt autoremove -y
## optional for nvidia users
sudo apt install nvidia-driver -y
## optional for laptop users
sudo apt install tlp
sudo tlp start

## vscode and virtualbox setup
cd Downloads
wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 #download VScode stable .deb package
wget https://download.virtualbox.org/virtualbox/7.0.12/virtualbox-7.0_7.0.12-159484~Debian~bookworm_amd64.deb #download virtualbox 7 .deb package
sudo apt install ./<file>.deb #to install the downloaded .deb packages, use 'ls' command to copy their names
cd

# configura o flathub e instala alguns flatpaks
sudo apt install flatpak gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install com.mattjakeman.ExtensionManager #gnome extension manager, with power-ups
flatpak install com.spotify.Client #spotify client
flatpak install org.gnome.Boxes #simple virtualization tool
flatpak install com.usebottles.bottles #wine made easy
flatpak install org.kde.kdenlive #most popular oper-source video editor
flatpak install flathub com.discordapp.Discord #discord client
flatpak install flathub com.google.Chrome #google chrome
flatpak install flathub org.videolan.VLC #vlc media player
flatpak install flathub com.obsproject.Studio #obs studio
flatpak install flathub io.github.mimbrero.WhatsAppDesktop #whatsapp client
flatpak install flathub com.github.micahflee.torbrowser-launcher #tor browser, for dark web access and privacy
flatpak install flathub org.kde.krita #excellent painting tool, can be used as photo editor
flatpak install flathub fr.handbrake.ghb #video enconder and decoder
flatpak install flathub org.filezillaproject.Filezilla #ftp client
flatpak install flathub com.github.tenderowl.frog #simple ocr tool
flatpak install org.audacityteam.Audacity #to work with audio

# appimages setup
mkdir ~/appimages #put your appimages in this folder on your home
flatpak install it.mijorus.gearlever #to easily handle the appimages

# basic gnome extensions
sudo apt install gnome-shell-extension-appindicator gnome-shell-extension-caffeine gnome-shell-extension-dashtodock gnome-shell-extension-gsconnect #appindicator, caffeine, dashtodock, gsconnect

# themes configuration

## colloid shell & gtk theme
git clone https://github.com/vinceliuice/Colloid-gtk-theme
cd Colloid-gtk-theme
./install.sh --libadwaita --tweaks float #to install the with the default colors and floating panel
./install.sh --libadwaita --tweaks nord float #nord colorscheme
./install.sh --libadwaita --tweaks black float --name Colloid-Black #colloid but darker

## colloid icon theme
https://github.com/vinceliuice/Colloid-icon-theme
cd Colloid-icon-theme
./install.sh #standart colors
./install.sh -s nord #nord colorscheme

## bibata cursor theme - but translucent
git clone https://github.com/Silicasandwhich/Bibata_Cursor_Translucent
cd Bibata_Cursor_Translucent
./Installer_Bibata.sh
cd

## flatpak theme setup
sudo flatpak override --filesystem=$HOME/.icons
sudo flatpak override --filesystem=$HOME/.themes
sudo flatpak override --env=ICON_THEME=<your cursor>
sudo flatpak override --env=GTK_THEME=<your gtk theme>


#  oh-my-zsh setup with starship prompt

## zsh
sudo apt install zsh -y
chsh -s /bin/zsh
zsh

## oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## starship
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

## autosuggestion and syntax highighting for zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

## finishing, you need to put this config in your .zshrc setup
#plugins=(git zsh-autosuggestions zsh-syntax-highlighting debian python) ZSH_THEME="spaceship"

# grub theme
sudo apt install grub-customizer -y #to easily handle the themes

## install some themes
sudo mkdir /boot/grub/themes
cd /boot/grub/themes
sudo wget https://www.dropbox.com/s/4c672ec9sc8fu5k/themes.tar.gz
sudo tar -xvzf themes.tar.gz
sudo rm -fr themes.tar.gz

##finishing, open grub-customizer and select the best theme

# docker setup
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian/ $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
