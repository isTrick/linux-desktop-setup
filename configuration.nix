# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system, removing XTerm.
  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];
  hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable the GNOME Desktop Environment, without the apps.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.windowManager.qtile.enable = true;
  services.gnome.core-utilities.enable = false;
  environment.gnome.excludePackages = [
   pkgs.gnome-tour
  ];

  # Configure keymap in X11
  services.xserver = {
    layout = "br";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.patrickg = {
    isNormalUser = true;
    description = "Patrick Gnosis";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      vlc
      tilix
      virtualbox
      gnome.eog
      gnome.cheese

      gnomeExtensions.dash-to-panel
      gnomeExtensions.arcmenu
     
    ];
  };
  
    users.users.pgirardi = {
    isNormalUser = true;
    description = "Patrick Girardi";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kitty
      neovim
      vscode       
      zathura
      cava
      gnome.gnome-boxes
      mpv
      ranger
      cmus
      feh
      neofetch
      gnome.gnome-disk-utility

      gnomeExtensions.dash-to-dock
      gnomeExtensions.logo-menu
      gnomeExtensions.vitals
      gnomeExtensions.pop-shell

      nerdfonts

    ];

  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
     vim 
     wget
     git
     firefox
     google-chrome
     gnome.gnome-tweaks
     gnome.nautilus
     nautilus-open-any-terminal
     gnome.file-roller
     gnome.gnome-font-viewer
     deluge-gtk
     gnome.gnome-calculator
     obsidian
     htop
     audacity
     libsForQt5.kdenlive
     krita
     handbrake
     obs-studio
     onlyoffice-bin
     gnome.gnome-chess    
     gnuchess
     spotify
     gnome-frog
     gnote
     gnome.gnome-system-monitor
     whatsapp-for-linux
 
     gnomeExtensions.pano
     gnomeExtensions.lock-keys
     gnomeExtensions.custom-hot-corners-extended
     gnomeExtensions.caffeine
     gnomeExtensions.awesome-tiles
     gnomeExtensions.tray-icons-reloaded
     gnomeExtensions.gsconnect
     
     sassc
     gtk-engine-murrine
     gnome.gnome-themes-extra
     bibata-cursors-translucent
     adw-gtk3

     wine
     bottles
     distrobox
     docker

     python3
     python311Packages.pip
     python311Packages.pyautogui
     python311Packages.pillow
     python311Packages.mouseinfo
  ];

  services.gnome.sushi.enable = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "pgirardi" "patrickg" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  # ZSH
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  
  programs.starship.enable = true;
  
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.autosuggestions.enable = true;
  
}
