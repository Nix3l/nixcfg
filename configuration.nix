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

        backupFileExtension = "backup";
    };

    # GRAPHICS
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
        # required
        modesetting.enable = true;

        # use the nvidia open source kernel module
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
        enable = true;
        type = "fcitx5";
        fcitx5.addons = with pkgs; [
            fcitx5-mozc
            fcitx5-gtk
        ];

        fcitx5.waylandFrontend = true;
    };

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
        # essentials
        vim
        git
        gh
        openssl
        zsh
        dconf # needed for gtk
        (ffmpeg-full.override { withUnfree = true; withOpengl = true; })
        appimage-run
	jdk
	xwayland
	grim
	slurp

	# libraries
	libnotify

        # apps
        hyprland
        alacritty
        xfce.thunar
        librewolf-bin
        mpv
        discord
        betterdiscordctl
        lutris
        qbittorrent
        feh
        flameshot
        networkmanagerapplet
        blueberry
        steam
	anki
	eclipses.eclipse-java
	libreoffice-qt6
	obs-studio
	gscreenshot
	quickemu
	gmetronome

        # wine 
        wineWowPackages.stable
        # native wayland support (can be unstable)
        wineWowPackages.waylandFull
        winetricks

        # terminal apps
        neofetch
        unzip
        eza
        wget
        brightnessctl
        htop
        btop
        unrar

        # fonts
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        liberation_ttf
        fira-code
        fira-code-symbols
        font-awesome
        font-awesome_5
        font-awesome_4
	ipafont
	kochi-substitute

        # other
        capitaine-cursors
    ];

    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        liberation_ttf
        fira-code
        fira-code-symbols
        font-awesome
        font-awesome_5
        font-awesome_4
	ipafont
	kochi-substitute
    ];

    # STEAM
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
    };

    # DYNAMICALLY LINKED EXECS
    programs.nix-ld = {
        enable = true;
    };

    # SESSION VARIABLES
    environment.sessionVariables = {
        NIXOS_OZONE_WL = "1"; # hint at electron apps to use wayland
        QT_IM_MODULE = "fcitx";
        QT_IM_MODULES = "wayland;fcitx";
        XMODIFIERS = "@im=fcitx";
        XMODIFIER = "@im=fcitx";
        GTK_IM_MODULE = "wayland";
    };

    # SERVICES
    services.openssh.enable = true;
    services.upower.enable = true;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.11";
}
