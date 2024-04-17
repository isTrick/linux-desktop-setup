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

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia.prime.sync.enable = true;
  hardware.nvidia.modesetting.enable = true;
  
  hardware.nvidia.prime.intelBusId = "PCI:0:2:0";
  hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0";

  virtualisation.docker.enableNvidia = true;

  # Enable the Gnome Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.core-utilities.enable = false;
  environment.gnome.excludePackages = [ pkgs.gnome-tour ];

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
    description = "Patrick Girardi";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      anytype
      ticktick
      floorp # alternative web browser

      android-studio
      github-desktop
    	
      nerdfonts
      cavalier # audio visualizer
      
      gnomeExtensions.material-shell # material shell
      gnomeExtensions.blur-my-shell # blur effects
      gnomeExtensions.coverflow-alt-tab # beautiful alt+tab
      gnomeExtensions.burn-my-windows # windows animations
      gnomeExtensions.desktop-cube # desktop effects
      gnomeExtensions.rounded-window-corners
      
      bibata-cursors-translucent
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
    environment.systemPackages = with pkgs; [
    git # versionating
    wget # download things
    wine # windows tools
    bottles # manage wine
    docker # manage containers
    pciutils # config pci devices
    protonvpn-gui # free vpn
    
    vlc # media player
    vscode # versatile IDE
    virtualbox # virtualization tool
    brave # web-browser
    fragments # torrents
    gnome-frog # OCR tool
    onlyoffice-bin # office
    whatsapp-for-linux # whatsapp client
    
    spotify # music streaming
    stremio # video streaming hub
    foliate # e-book reader
    
    audacity # audio editor
    kdenlive # video editor
    krita # painting tool
    obs-studio # screen recording
    handbrake # video compressing
    noisetorch # mic noise reduction
    easyeffects # audio equalizer
    upscayl # upscale images
    imaginer # image generation

    gnome.gnome-weather # gnome weather
    gnome.gnome-clocks # gnome clocks
    gnome.gnome-calendar # gnome calendar
    gnome.gnome-system-monitor # system monitor
    gnome.gnome-font-viewer # managing fonts
    gnome.file-roller # unzip
    gnome.nautilus # web browser
    gnome.gnome-calculator # calculator
    gnome.gnome-tweaks # gnome tweaks
    gnome.eog # gnome image viewer
    gnome.gnome-disk-utility # gnome disk utility
    gnome.geary # gnome mail client
    gnome-text-editor # text editor
    gnome.gnome-boxes # gnome virtualization tool
    gnome-console # gnome terminal
    evince # gnome document viewer
    amberol # music player
    clapper # video player
    
    gnomeExtensions.dash-to-dock # dock
    gnomeExtensions.vitals # panel system monitor
    gnomeExtensions.clipboard-indicator # clipboard
    gnomeExtensions.caffeine # keep awage
    gnomeExtensions.awesome-tiles # superior tiling
    gnomeExtensions.tray-icons-reloaded # tray icons
    gnomeExtensions.gsconnect # kde connect
    gnomeExtensions.lock-keys # lock keys indicator
    gnomeExtensions.color-picker # panel color picker
    gnomeExtensions.desktop-icons-ng-ding # desktop icons
    gnomeExtensions.tiling-assistant
    
    sassc
    gtk-engine-murrine
    gnome.gnome-themes-extra
    adw-gtk3
    
  ];
  
  services.gnome.sushi.enable = true; # file manager pre visualization
  
  virtualisation.virtualbox.host.enable = true; # virtualbox configuration
  users.extraGroups.vboxusers.members = [ "patrickg" ]; # virtualbox configuration
  

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
  system.stateVersion = "23.11"; # Did you read the comment?

  # ZSH
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  
  programs.starship.enable = true;
  
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.autosuggestions.enable = true;
}
