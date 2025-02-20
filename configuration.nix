{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
  ];

  # BOOTLOADER
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ENABLE FLAKES
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # NETWORKING
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # LOCALE
  time.timeZone = "Asia/Amman";
  i18n.defaultLocale = "ja_JP.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  # USERS
  users.users.nix3l = {
    isNormalUser = true;
    description = "nix3l";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # HOME MANAGER
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "nix3l" = import ./home.nix;
    };
  };

  # GRAPHICS
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # required.
    modesetting.enable = true;

    # Use the nvidia open source kernel module
    open = false;

    # enable the nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # KEYBOARD
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  
  # japanese input
  i18n.inputMethod = {
     type = "fcitx5";
     enable = true;
     fcitx5.addons = with pkgs; [
       fcitx5-mozc
       fcitx5-gtk
     ];

     fcitx5.waylandFrontend = true;
  };

  services.xserver.desktopManager.runXdgAutostartIfNone = true;
      
  # touchpad support in X servers
  services.libinput.enable = true;

  # PRINTING
  services.printing.enable = true;

  # AUDIO
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # PROGRAMS
  nixpkgs.config.allowUnfree = true; # allow non-FOSS
  environment.systemPackages = with pkgs; [
     neovim
     git
     gh
     openssl

     alacritty
     xfce.thunar
     librewolf-bin
     mpv
     discord
     betterdiscordctl
     spotify
     spicetify-cli
     lutris
     qbittorrent
     rofi-wayland

     neofetch
     unzip
     eza
     wget

     # nerd-fonts
     noto-fonts
     noto-fonts-cjk-sans
     noto-fonts-emoji
     liberation_ttf
     fira-code
     fira-code-symbols
  ];

  fonts.packages = with pkgs; [
     # nerd-fonts
     noto-fonts
     noto-fonts-cjk-sans
     noto-fonts-emoji
     liberation_ttf
     fira-code
     fira-code-symbols
  ];

  # SERVICES
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11";
}
