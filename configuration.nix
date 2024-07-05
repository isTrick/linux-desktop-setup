{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking.
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  time.timeZone = "America/Sao_Paulo";
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

  # NVIDIA Proprietary Driver configuration.
  hardware.nvidia.prime.sync.enable = true;
  hardware.nvidia.modesetting.enable = true;
  
  hardware.nvidia.prime.intelBusId = "PCI:0:2:0";
  hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0";

  # Enable the Gnome Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.core-utilities.enable = false;
  services.gnome.sushi.enable = true;
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
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "vboxusers" "docker" ];
    packages = with pkgs; [
      # cavalier
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
    environment.systemPackages = with pkgs; [
      # Terminal
      vim 
      wget
      fastfetch
      tree
      tmux
      vagrant
      distrobox
     
      # Main
      ferdium
      brave
      anytype
      bitwarden-desktop
      onlyoffice-bin
      qbittorrent
  
      # Gnome GTK4
      gnome.gnome-weather
      gnome.gnome-clocks
      gnome.gnome-calendar
      gnome.geary
      gnome.gnome-font-viewer
      gnome.file-roller
      gnome.gnome-calculator
      gnome.nautilus
      gnome.eog
      gnome.gnome-disk-utility
      gnome.gnome-boxes
      gnome-console
      gnome.gnome-tweaks
      gnome-text-editor    
      evince
      gnome-frog
      resources
      g4music
      celluloid
      dialect
      furtherance
      
      # Audiovisual
      audacity
      kdenlive
      obs-studio
      handbrake
      losslesscut-bin
      parabolic
      openshot-qt
  
      # Image manipulation
      krita
      gthumb
      upscayl
  
      # Other
      stremio
      easyeffects
      cava
      spotify
      
      # Wine
      wine
      bottles
  
      # Themes
      nerdfonts
      sassc
      gtk-engine-murrine
      gnome.gnome-themes-extra
      adw-gtk3
      yaru-theme
      font-awesome
  
      # Gnome extensions
      gnomeExtensions.dash-to-dock
      gnomeExtensions.clipboard-indicator
      gnomeExtensions.caffeine
      gnomeExtensions.appindicator
      gnomeExtensions.lock-keys
      gnomeExtensions.tiling-assistant
      gnomeExtensions.color-picker
      gnomeExtensions.gnome-40-ui-improvements
      gnomeExtensions.gsconnect
  
      # VSCode extensions
      vscode-with-extensions
      vscode-extensions.vscodevim.vim
      vscode-extensions.ms-python.python
      vscode-extensions.yzhang.markdown-all-in-one
      vscode-extensions.jnoortheen.nix-ide
  
      # VIM plugins
      vimPlugins.vim-vagrant
      vimPlugins.python-mode
  
      # Python packages
      python312
      spotdl
      python312Packages.numpy
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # NixOS Version.
  system.stateVersion = "24.05";

  # ZSH
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  
  programs.starship.enable = true;
  
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.autosuggestions.enable = true;

  # Libvirt Virtualization
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };
  
  # VMware
  virtualisation.vmware.host.enable = true;
  
  # VBox
  virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableKvm = true;
  
  # Virtmanager
  programs.virt-manager.enable = true;
  
  # Docker
  virtualisation.docker.enable = true;
}
