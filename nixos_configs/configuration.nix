# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Flakes (not really using, may disable later...)
  nix.settings.experimental-features = [ "nix-command" "flakes"]; 

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enabling hyprlnd
  programs.hyprland = {
      enable = true;
      nvidiaPatches = true;
      xwayland.enable = true;
  };
  environment.sessionVariables = {
      # may not need this
      WLR_NO_HARDWARE_CURSORS = "1";
      # For hint apps
      NIXOS_OZONE_WL = "1";
  };

  # Aliases, shell varaibles, etc.
  environment.interactiveShellInit = ''
    alias vim='nvim'
  '';

  hardware = {
      #Opengl
      opengl.enable = true; opengl.driSupport = true;
      opengl.driSupport32Bit = true;
      # for compositors & NVIDIA
      nvidia.modesetting.enable = true;
      nvidia.open = false;
      nvidia.nvidiaSettings = true;
      nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
      # Other NVIDIA
  };

  # Display manager
  services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = true;
      libinput.enable = true;
      videoDrivers = ["nvidia"];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.katier = {
    isNormalUser = true;
    description = "Katie R";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Auto upgrade nix!
  system.autoUpgrade.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Nix Utils
    home-manager
    # Graphics: WM, login manager, etc 
    rofi-wayland
    # eww-wayland 
    waybar
    lightdm
    swww # Gif-able wallpaper
    # for notifications
    dunst
    # mako
    # swaynotificationcenter # Struggles with Hyprland
    libnotify #not needed?
    # Daemons / control
    pulseaudio
    pavucontrol
    opentabletdriver # for graphic tablets
    # Essential Apps 
    neovim 
    firefox
    xfce.thunar
    alacritty # good term, can rem later
    kitty # default for hyprland, also p good
    # Terminal Essentials
    neofetch
    htop-vim
    wev # run to show keybind names
    trashy
    # Personal Essentials 
    rustdesk
    discord
    xournalpp
    zathura
    xpad
    gimp
    inkscape-with-extensions
    vlc
    geeqie
    # flameshot # personal fave screencap tool, doesn't work w/ hyprland, soo...
    grim
    slurp
    # Development Tools
    git
    nodejs_20
    binutils # objdump, linkers
    libgccjit # C compiler
    gnumake42
    wget 
    python3Full # Currently 3.10
    python310Packages.pip # pip for above
    # Entertainment & Terminal Toys
    spotify
    spotifyd # Daemon for SPT
    spotify-tui
    obs-studio
    cava # music visualizer
    cmatrix
    fortune
    lolcat
    cowsay
  ];

  fonts.fonts = with pkgs; [
    nerdfonts 
  ];
  
  # screensharing for Wayland
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # For sound
  sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
  };
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.waybar.package = inputs.hyprland.packages.${pkgs.system}.waybar-hyprland;

  # List services that you want to enable:
  
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.qemuGuest.enable = true;

  # Term Util
  security.sudo.enable = true; # probably unecessary
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
  
}
